import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/core/ui/widgets/custom_button.dart';
import 'package:onlymessage/app/pages/auth/register/register_controller.dart';
import 'package:onlymessage/app/pages/auth/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _userNameEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _userNameEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao tentar se registrar');
          },
          success: () {
            hideLoader();
            showSuccess('Registro realizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registro',
                style: context.textStyle.textTitle,
              ),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _userNameEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome de usuário obrigatório.'),
                    Validatorless.min(
                        3, 'Nome precisa ser maior que 3 caracteres.'),
                    Validatorless.max(
                        50, 'Nome precisa ser menor que 50 caracteres.')
                  ]),
                  style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  decoration:
                      const InputDecoration(labelText: 'Nome de Usuário'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatória.'),
                    Validatorless.min(
                        8, 'Senha precisa ser maior que 8 caracteres.'),
                    Validatorless.max(
                        32, 'Senha precisa ser menor que 32 caracteres.')
                  ]),
                  style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar Senha obrigatória.'),
                    Validatorless.compare(
                        _passwordEC, 'Senha diferente de Confirma Senha.')
                  ]),
                  style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  width: double.infinity,
                  label: 'REGISTRAR',
                  onPressed: () {
                    final valid = _formKey.currentState?.validate() ?? false;
                    if (valid) {
                      controller.register(_userNameEC.text, _passwordEC.text);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Já tem uma conta?',
                      style: context.textStyle.textRegular,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Clique aqui',
                        style: context.textStyle.textRegular.copyWith(
                          color: const Color(0XFF491E82),
                        ),
                      ),
                    ),
                    Text(
                      'para entrar.',
                      style: context.textStyle.textRegular,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
