import 'package:crud_practica/src/pages/producto_page.dart';
import 'package:flutter/material.dart';
import 'package:crud_practica/src/bloc/provider.dart';
import 'package:crud_practica/src/pages/home_page.dart';
import 'package:crud_practica/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Validaciones App',
        initialRoute: 'producto',
        routes: {
          'login'     : (BuildContext context) => LoginPage(),
          'home'      : (BuildContext context) => HomePage(),
          'producto'  : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}