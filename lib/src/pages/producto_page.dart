import 'package:flutter/material.dart';
import 'package:crud_practica/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){}
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){}
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearBoton(),
              ],
            )
          ),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre'
      ),
      validator: (value) {
        if(value.length < 3){
          return 'Ingrese el nombre del producto.';
        }else {
          return null;
        }
      },
    );
  }

  _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value) {
        if(utils.isNumeric(value)){
          return null;
        }else {
          return 'Ingrese solo números.';
        }
      },
    );
  }

  _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save), 
      label: Text('Guardar'),
      onPressed: _submit, 
    );
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    
  }
}