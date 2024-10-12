import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/features/auth/presentation/pages/cubits/auth/auth_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = Modular.get<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) {
        if (state.userEntity == null) {
          Modular.to.navigate('/auth');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro de usuário'),
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: _authCubit.logout,
              ),
            ],
          ),
          body: Container(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Modular.to.pushNamed('./form');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
