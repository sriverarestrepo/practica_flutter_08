import 'package:flutter/material.dart';
import 'package:crud_practica/src/widgets/background_login_widget.dart';
import 'package:crud_practica/src/widgets/forms_login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundLoginWidget(),
          FormsLoginWidget(),
        ],
      )
     );
  }
}