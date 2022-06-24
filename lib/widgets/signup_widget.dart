// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import '../helpers/helpers_auth.dart';
import '../main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future _signUp() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      stdout.writeln(e);

      HelpersAuth.showSnackBar(e.message);
    }

    print(FirebaseAuth.instance.currentUser);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const FlutterLogo(size: 120),
                const SizedBox(height: 20),
                const Text(
                  'Bem vindo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Digite um email válido!'
                          : null,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 6
                      ? 'Digite uma senha maior que 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  decoration:
                      const InputDecoration(labelText: 'Confirme a senha'),
                  obscureText: true,
                  validator: (_) => _passwordController.text !=
                          _confirmPasswordController.text
                      ? 'Senhas não coincidem!'
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.arrow_forward, size: 32),
                  label: const Text(
                    'Criar conta',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: _signUp,
                ),
                const SizedBox(height: 20),
                //RichText(
                //  text: TextSpan(
                //      style: const TextStyle(color: Colors.white, fontSize: 20),
                //      text: 'Já tem uma conta?',
                //      children: [
                //        TextSpan(
                //          recognizer: TapGestureRecognizer()
                //            ..onTap = widget.onClickedSignIn,
                //          text: 'Entrar',
                //          style: TextStyle(
                //            decoration: TextDecoration.underline,
                //            color: Theme.of(context).colorScheme.secondary,
                //          ),
                //        )
                //      ]),
                //),
                const SizedBox(height: 20),
              ],
            )),
      );
}
