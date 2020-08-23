import 'package:flutter/material.dart';
import 'package:crud_practica/src/bloc/provider.dart';
import 'package:crud_practica/src/providers/productos_provider.dart';
import 'package:crud_practica/src/models/producto_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

        final productos = snapshot.data;
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, i) => _crearItemProducto(context, productos[i])          
          );
          
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
      onPressed: () => Navigator.pushNamed(
        context, 
        'producto').then((value) {
          setState(() {});
        }),
    );
  }

  _crearItemProducto(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        print('$direccion');
        productoProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: [
            (producto.fotoUrl == null) 
            ? Image(image: AssetImage('assets/no-image.png'))
            : FadeInImage(
              image: NetworkImage(producto.fotoUrl),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${producto.titulo} -> ${producto.valor}'),
              subtitle: Text('${producto.id}'),
              onTap: () => Navigator.pushNamed(
                context, 
                'producto',
                arguments: producto).then((value) {
                  setState(() {});
                } ),
            ),
          ],
        ),
      )
    );
  }
}


