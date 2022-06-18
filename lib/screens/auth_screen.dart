import 'package:flutter/material.dart';

import '../widgets/login_widget.dart';
import '../widgets/signup_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggle() => setState(() => _isLogin = !_isLogin);

  @override
  Widget build(BuildContext context) => _isLogin
      ? LoginWidget(onClickedSignUp: _toggle)
      : SignUpWidget(onClickedSignIn: _toggle);
}
