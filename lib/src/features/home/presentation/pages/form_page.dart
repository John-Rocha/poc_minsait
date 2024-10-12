import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poc_minsait/src/core/models/models.dart';
import 'package:poc_minsait/src/core/widgets/custom_text_button.dart';
import 'package:poc_minsait/src/core/widgets/custom_text_field.dart';
import 'package:poc_minsait/src/features/home/presentation/cubits/form_page/form_page_cubit.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late final FormPageCubit _formCubit;

  @override
  void initState() {
    super.initState();
    _formCubit = Modular.get<FormPageCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _formCubit.clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormPageCubit, FormPageState>(
      bloc: _formCubit,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
          _formCubit.clearErrorMessages();
        }

        if (state.isSaved) {
          Modular.to.pop(true);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _formCubit.clearErrorMessages();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Formulário de cadastro'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: state.isFormValid ? _formCubit.saveForm : null,
                ),
              ],
            ),
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dados pessoais',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'CPF',
                            initialValue: state.document.value,
                            keyboardType: TextInputType.number,
                            onChanged: _formCubit.documentChanged,
                            errorText: switch (state.document.displayError) {
                              DocumentValidatorError.empty =>
                                'Campo obrigatório',
                              DocumentValidatorError.invalid => 'CPF inválido',
                              _ => null,
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Nome',
                            initialValue: state.fullName.value,
                            onChanged: _formCubit.fullNameChanged,
                            errorText: switch (state.fullName.displayError) {
                              FullNameValidationError.empty =>
                                'Campo obrigatório',
                              FullNameValidationError.incomplete =>
                                'Nome incompleto',
                              _ => null,
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Data de nascimento',
                            initialValue: state.birthDate.value,
                            onChanged: _formCubit.birthDateChanged,
                            errorText: switch (state.birthDate.displayError) {
                              BirthDateValidatorError.empty =>
                                'Campo obrigatório',
                              BirthDateValidatorError.invalid =>
                                'Data inválida',
                              _ => null,
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Endereço',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'CEP',
                                  initialValue: state.cep.value,
                                  keyboardType: TextInputType.number,
                                  onChanged: _formCubit.onCepChanged,
                                  errorText: switch (state.cep.displayError) {
                                    CepValidatorError.empty =>
                                      'Campo obrigatório',
                                    CepValidatorError.invalid => 'CEP inválido',
                                    _ => null,
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CepInputFormatter(ponto: false),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              CustomTextButton(
                                label: 'Buscar',
                                onPressed: state.cep.isValid
                                    ? () =>
                                        _formCubit.searchCep(state.cep.value)
                                    : null,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            key: Key('logradouro_${state.logradouro}'),
                            label: 'Rua',
                            initialValue: state.logradouro,
                            readonly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Número',
                            keyboardType: TextInputType.number,
                            onChanged: _formCubit.numberChanged,
                            errorText: switch (state.number.displayError) {
                              NumberHouseValidatorError.invalid =>
                                'Campo obrigatório',
                              _ => null,
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Complemento',
                            onChanged: _formCubit.complementoChanged,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            key: Key('bairro_${state.bairro}'),
                            label: 'Bairro',
                            initialValue: state.bairro,
                            readonly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            key: Key('localidade_${state.localidade}'),
                            label: 'Cidade',
                            initialValue: state.localidade,
                            readonly: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            key: Key('uf_${state.uf}'),
                            label: 'Estado',
                            initialValue: state.uf,
                            readonly: true,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
