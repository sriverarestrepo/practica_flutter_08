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
      body: Container(),
      floatingActionButton: _crearBoton(context),
     );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}