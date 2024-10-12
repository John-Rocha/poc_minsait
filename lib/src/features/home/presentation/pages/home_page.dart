import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/features/auth/presentation/pages/cubits/auth/auth_cubit.dart';
import 'package:poc_minsait/src/features/home/presentation/cubits/home_page/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AuthCubit _authCubit;
  late final HomePageCubit _homePageCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = Modular.get<AuthCubit>();
    _homePageCubit = Modular.get<HomePageCubit>()..getPersons();
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
          body: BlocBuilder<HomePageCubit, HomePageState>(
            bloc: _homePageCubit,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }

              return RefreshIndicator(
                onRefresh: _homePageCubit.getPersons,
                child: ListView.separated(
                  itemCount: state.persons.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final person = state.persons[index];
                    return ListTile(
                      title: Text(
                        person.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.cpf),
                          Text(person.birthDate),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
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
