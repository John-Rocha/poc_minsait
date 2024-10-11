part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isLoading,
    this.errorMessage,
    this.userEntity,
    this.authEntity,
  });

  final FullName fullName;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? userEntity;
  final AuthEntity? authEntity;

  const AuthState.empty()
      : fullName = const FullName.pure(),
        email = const Email.pure(),
        password = const Password.pure(),
        confirmPassword = const Password.pure(),
        isLoading = false,
        errorMessage = null,
        userEntity = null,
        authEntity = null;

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

  AuthState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    Password? confirmPassword,
    bool? isLoading,
    String? errorMessage,
    UserEntity? userEntity,
    AuthEntity? authEntity,
  }) {
    return AuthState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
      authEntity: authEntity ?? this.authEntity,
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
        authEntity,
      ];
}
