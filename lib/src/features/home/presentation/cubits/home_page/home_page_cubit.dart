import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_minsait/src/features/home/domain/entities/person_entity.dart';
import 'package:poc_minsait/src/features/home/domain/usecases/get_persons_usecase.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required GetPersonsUsecase getPersonsUsecase})
      : _getPersonsUsecase = getPersonsUsecase,
        super(const HomePageState.initial());

  final GetPersonsUsecase _getPersonsUsecase;

  Future<void> getPersons() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getPersonsUsecase();

    result.fold(
      (error) {
        emit(
          state.copyWith(
            errorMessage: error.message,
            isLoading: false,
          ),
        );
      },
      (persons) {
        emit(
          state.copyWith(persons: persons, isLoading: false),
        );
      },
    );
  }
}
