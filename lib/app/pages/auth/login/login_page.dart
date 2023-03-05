import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/core/ui/widgets/custom_button.dart';
import 'package:onlymessage/app/pages/auth/login/login_controller.dart';
import 'package:onlymessage/app/pages/auth/login/login_state.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _userNameEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          loginError: () {
            hideLoader();
            showError('E-mail ou senha incorretos.');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar login');
          },
          success: () {
            hideLoader();
            showSuccess('Login realizado com sucesso.');
            Navigator.of(context).popAndPushNamed('/home');
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: context.textStyle.textTitle,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      controller: _userNameEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Nome de usuário obrigatório.'),
                        Validatorless.min(
                            3, 'Nome precisa ser maior que 3 caracteres.'),
                        Validatorless.max(
                            50, 'Nome precisa ser menor que 50 caracteres.')
                      ]),
                      style:
                          context.textStyle.textRegular.copyWith(fontSize: 16),
                      decoration:
                          const InputDecoration(labelText: 'Nome de Usuário'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória.'),
                        Validatorless.min(
                            8, 'Senha precisa ser maior que 8 caracteres.'),
                        Validatorless.max(
                            32, 'Senha precisa ser menor que 32 caracteres.')
                      ]),
                      style:
                          context.textStyle.textRegular.copyWith(fontSize: 16),
                      decoration: const InputDecoration(labelText: 'Senha'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      width: double.infinity,
                      label: 'ENTRAR',
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;

                        if (valid) {
                          controller.login(_userNameEC.text, _passwordEC.text);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Não possui conta?',
                          style: context.textStyle.textRegular,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/auth/register');
                          },
                          child: Text(
                            'Clique aqui',
                            style: context.textStyle.textRegular.copyWith(
                              color: const Color(0XFF491E82),
                            ),
                          ),
                        ),
                        Text(
                          'e crie uma.',
                          style: context.textStyle.textRegular,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
