part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isLoading,
    this.errorMessage,
    this.userEntity,
  });

  final FullName fullName;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? userEntity;

  const SignupState.empty()
      : fullName = const FullName.pure(),
        email = const Email.pure(),
        password = const Password.pure(),
        confirmPassword = const Password.pure(),
        isLoading = false,
        errorMessage = null,
        userEntity = null;

  bool get isSignupValid =>
      Formz.validate([
        fullName,
        email,
        password,
        confirmPassword,
      ]) &&
      password.value == confirmPassword.value;

  bool get isLoginValid => Formz.validate([
        email,
        password,
      ]);

  SignupState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    Password? confirmPassword,
    bool? isLoading,
    String? errorMessage,
    UserEntity? userEntity,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        confirmPassword,
        isLoading,
        errorMessage,
        userEntity,
      ];
}
