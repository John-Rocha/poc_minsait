import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/models/email.dart';
import 'package:poc_minsait/src/core/models/full_name.dart';
import 'package:poc_minsait/src/core/models/password.dart';
import 'package:poc_minsait/src/core/widgets/custom_elevated_button.dart';
import 'package:poc_minsait/src/core/widgets/custom_text_button.dart';
import 'package:poc_minsait/src/core/widgets/custom_text_field.dart';
import 'package:poc_minsait/src/features/auth/presentation/pages/cubits/auth/auth_cubit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;

  late final AuthCubit _signupCubit;

  @override
  void initState() {
    super.initState();
    _signupCubit = Modular.get<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _signupCubit.resetState();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: BlocConsumer<AuthCubit, AuthState>(
                bloc: _signupCubit,
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                      ),
                    );
                  }

                  if (state.userEntity != null) {
                    setState(() {
                      _isLogin = true;
                    });
                  }

                  if (state.authEntity != null) {
                    Modular.to.navigate('/home');
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: _isLogin
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  CustomTextField(
                                    label: 'Nome completo',
                                    prefixIcon: const Icon(Icons.person),
                                    onChanged: _signupCubit.onFullNameChanged,
                                    errorText: switch (
                                        state.fullName.displayError) {
                                      FullNameValidationError.empty =>
                                        'Campo é obrigatório',
                                      FullNameValidationError.incomplete =>
                                        'Nome completo inválido',
                                      _ => null,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                      ),
                      CustomTextField(
                        label: 'E-mail',
                        prefixIcon: const Icon(Icons.email),
                        onChanged: _signupCubit.onEmailChanged,
                        errorText: switch (state.email.displayError) {
                          EmailValidationError.empty => 'Campo é obrigatório',
                          EmailValidationError.invalid => 'E-mail inválido',
                          _ => null,
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: 'Senha',
                        prefixIcon: const Icon(Icons.lock),
                        isPasswordField: true,
                        onChanged: _signupCubit.onPasswordChanged,
                        errorText: switch (state.password.displayError) {
                          PasswordValidationError.empty =>
                            'Campo é obrigatório',
                          PasswordValidationError.tooShort =>
                            'Senha muito curta',
                          _ => null,
                        },
                      ),
                      const SizedBox(height: 20),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: _isLogin
                            ? const SizedBox.shrink()
                            : Column(
                                children: [
                                  CustomTextField(
                                    label: 'Confirmação de senha',
                                    isPasswordField: true,
                                    prefixIcon: const Icon(Icons.lock),
                                    onChanged:
                                        _signupCubit.onConfirmPasswordChanged,
                                    errorText: state.password.value !=
                                            state.confirmPassword.value
                                        ? 'As senhas não coincidem'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                      ),
                      if (state.isLoading)
                        const CircularProgressIndicator()
                      else
                        Column(
                          children: [
                            CustomElevatedButton(
                              label: _isLogin ? 'Entrar' : 'Cadastrar',
                              onPressed:
                                  state.isSignupValid || state.isLoginValid
                                      ? () {
                                          if (_isLogin) {
                                            _signupCubit.signin();
                                          } else {
                                            _signupCubit.signup();
                                          }
                                        }
                                      : null,
                            ),
                            const SizedBox(height: 20),
                            CustomTextButton(
                              label: _isLogin
                                  ? 'Não tem uma conta? Cadastre-se'
                                  : 'Já tem uma conta? Entrar',
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
