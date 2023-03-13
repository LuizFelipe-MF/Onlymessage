import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/pages/splash/splash_controller.dart';
import 'package:onlymessage/app/pages/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashController> {
  @override
  void onReady() {
    controller.verifyAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SplashController, SplashState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () {},
            success: () {
              Navigator.of(context).popAndPushNamed('/home');
            },
            error: () {
              Navigator.of(context).popAndPushNamed('/auth/login');
            });
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/simple_logo.png',
              width: context.percentWidth(0.50),
              fit: BoxFit.cover,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    ));
  }
}
