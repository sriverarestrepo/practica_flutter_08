import 'package:flutter/material.dart';
import 'package:crud_practica/src/bloc/provider.dart';
import 'package:crud_practica/src/providers/productos_provider.dart';
import 'package:crud_practica/src/models/producto_model.dart';

class HomePage extends StatelessWidget {

  final productoProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: _cargarListadoProductos(),
      floatingActionButton: _crearBoton(context),
     );
  }


  _cargarListadoProductos() {
    return FutureBuilder(
      future: productoProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {

        if(snapshot.hasData){
          return Container();
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
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