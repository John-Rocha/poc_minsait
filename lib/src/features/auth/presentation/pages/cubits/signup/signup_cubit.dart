import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:poc_minsait/src/core/models/models.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';
import 'package:poc_minsait/src/features/auth/domain/usecases/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required SignupUsecase signupUsecase})
      : _signupUsecase = signupUsecase,
        super(const SignupState.empty());

  final SignupUsecase _signupUsecase;

  void onFullNameChanged(String value) {
    final fullName = FullName.dirty(value);
    emit(state.copyWith(fullName: fullName));
  }

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String value) {
    final confirmPassword = Password.dirty(value);
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  Future<void> signup() async {
    if (state.password.value != state.confirmPassword.value) {
      emit(state.copyWith(errorMessage: 'As senhas não coincidem.'));
      return;
    }

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 2));

    final result = await _signupUsecase(
      name: state.fullName.value,
      email: state.email.value,
      password: state.password.value,
    );

    result.fold(
      (error) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: error.message,
          ),
        );
      },
      (userEntity) {
        emit(
          state.copyWith(
            isLoading: false,
            userEntity: userEntity,
          ),
        );
      },
    );
  }

  void resetState() {
    emit(const SignupState.empty());
  }
}
