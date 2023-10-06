import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../routes/routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const Gutter(),
            FilledButton(
              onPressed: () => const HomeRoute().go(context),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
