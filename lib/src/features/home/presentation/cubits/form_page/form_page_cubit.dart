import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:poc_minsait/src/core/models/models.dart';
import 'package:poc_minsait/src/core/services/cep_service.dart';
import 'package:poc_minsait/src/features/home/domain/entities/address_entity.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/create_person_usecase.dart';

part 'form_page_state.dart';

class FormPageCubit extends Cubit<FormPageState> {
  FormPageCubit({
    required CreatePersonUsecase createPersonUsecase,
    required CepService cepService,
  })  : _createPersonUsecase = createPersonUsecase,
        _cepService = cepService,
        super(const FormPageState.initial());

  final CreatePersonUsecase _createPersonUsecase;
  final CepService _cepService;

  void documentChanged(String value) {
    final document = Document.dirty(value);
    emit(
      state.copyWith(document: document),
    );
  }

  void fullNameChanged(String value) {
    final fullName = FullName.dirty(value);
    emit(
      state.copyWith(fullName: fullName),
    );
  }

  void birthDateChanged(String value) {
    final birthDate = BirthDate.dirty(value);
    emit(
      state.copyWith(birthDate: birthDate),
    );
  }

  void onCepChanged(String value) {
    emit(
      state.copyWith(cep: Cep.dirty(value)),
    );
  }

  Future<void> searchCep(String value) async {
    emit(state.copyWith(isLoading: true));
    final result = await _cepService.getAddress(value);

    result.fold(
      (error) {
        emit(state.copyWith(errorMessage: error.message, isLoading: false));
      },
      (address) {
        emit(
          state.copyWith(
            logradouro: address.logradouro,
            bairro: address.bairro,
            localidade: address.localidade,
            uf: address.uf,
            isLoading: false,
            // Preserve valores já preenchidos
            document: state.document,
            fullName: state.fullName,
            birthDate: state.birthDate,
            number: state.number,
            complemento: state.complemento,
            cep: state.cep,
            errorMessage: null,
            isSaved: false,
          ),
        );
      },
    );
  }

  void numberChanged(String value) {
    emit(
      state.copyWith(
        number: NumberHouse.dirty(value),
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  void complementoChanged(String value) {
    emit(
      state.copyWith(
        complemento: value.isEmpty ? '' : value,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  void clearErrorMessages() {
    emit(
      state.copyWith(
        errorMessage: null,
      ),
    );
  }

  Future<void> saveForm() async {
    if (state.isFormValid) {
      emit(state.copyWith(isLoading: true));
      final result = await _createPersonUsecase(
        person: PersonEntity(
          cpf: state.document.value,
          name: state.fullName.value,
          birthDate: state.birthDate.value,
          address: AddressEntity(
            cep: state.cep.value,
            logradouro: state.logradouro,
            number: state.number.value,
            complemento: state.complemento,
            bairro: state.bairro,
            localidade: state.localidade,
            uf: state.uf,
          ),
        ),
      );

      result.fold(
        (error) {
          emit(state.copyWith(errorMessage: error.message, isLoading: false));
        },
        (_) {
          emit(
            state.copyWith(
              isLoading: false,
              isSaved: true,
            ),
          );
        },
      );
    }
  }

  void clearFields() {
    emit(const FormPageState.initial());
  }
}
