import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/core/ui/widgets/custom_button.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_controller.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_state.dart';
import 'package:validatorless/validatorless.dart';
import 'package:onlymessage/app/models/user.dart';

class PerfilEditPage extends StatefulWidget {
  final UserAuth user;

  const PerfilEditPage({
    super.key,
    required this.user,
  });

  @override
  State<PerfilEditPage> createState() => _PerfilEditPageState();
}

class _PerfilEditPageState
    extends BaseState<PerfilEditPage, PerfilEditController> {
  final _formKey = GlobalKey<FormState>();
  late final _usernameEC = TextEditingController(text: widget.user.username);
  final _passwordEC = TextEditingController();

  @override
  void onReady() {
    controller.load(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: context.textStyle.textSemiBold,
        ),
      ),
      body: BlocListener<PerfilEditController, PerfilEditState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            success: () {
              hideLoader();
              showSuccess(
                  state.successMessage ?? 'Informações alteradas com sucesso.');
              Navigator.of(context).pop(state.user);
            },
            error: () {
              hideLoader();
              showError(
                  state.errorMessage ?? 'Erro ao tentar salvar alterações.');
            },
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BlocSelector<PerfilEditController, PerfilEditState, File?>(
                    selector: (state) => state.temporaryImage,
                    builder: (context, temporaryImage) {
                      return InkWell(
                        onTap: () => getImage(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: temporaryImage != null
                              ? Image.file(
                                  temporaryImage,
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loading.gif',
                                  image:
                                      'http://10.0.2.2:3001${widget.user.imageUrl}',
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Editar foto de perfil',
                    style: context.textStyle.textRegular
                        .copyWith(color: const Color(0XFF5F5E6D)),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  TextFormField(
                    controller: _usernameEC,
                    validator: Validatorless.multiple([
                      Validatorless.min(
                          3, 'Nome precisa ser maior que 3 caracteres.'),
                      Validatorless.max(
                          50, 'Nome precisa ser menor que 50 caracteres.')
                    ]),
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                    decoration:
                        const InputDecoration(labelText: 'Nome de Usuário'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.min(
                          8, 'Senha precisa ser maior que 8 caracteres.'),
                      Validatorless.max(
                          32, 'Senha precisa ser menor que 32 caracteres.')
                    ]),
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                    decoration: const InputDecoration(labelText: 'Nova Senha'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: Validatorless.multiple([
                      Validatorless.compare(
                          _passwordEC, 'Senha diferente de Confirma Senha.')
                    ]),
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                    decoration: const InputDecoration(
                        labelText: 'Confirmar Nova Senha'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: double.infinity,
                    label: 'SALVAR ALTERAÇÕES',
                    onPressed: () {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        controller.updateUserInformations(
                            _usernameEC.text, _passwordEC.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final File img = File(image.path);
    controller.updateImage(img);
  }
}
