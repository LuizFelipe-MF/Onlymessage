import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:provider/provider.dart';

class AplicationBinding extends StatelessWidget {
  final Widget child;

  const AplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        )
      ],
      child: child,
    );
  }
}
