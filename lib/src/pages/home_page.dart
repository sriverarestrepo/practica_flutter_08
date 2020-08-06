import 'package:flutter/material.dart';
import 'package:crud_practica/src/bloc/provider.dart';

class HomePage extends StatelessWidget {


  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Text('Email: ${bloc.email}'),
           Divider(),
           Text('Password: ${bloc.password}'),
          ],
        ),
      ),
     );
  }
}