import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:crud_practica/src/models/producto_model.dart';
import 'package:crud_practica/src/providers/productos_provider.dart';
import 'package:crud_practica/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey     = GlobalKey<FormState>();
  
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final productoProvider = new ProductosProvider();
  
  ProductoModel producto = new ProductoModel();

  bool _guardando = false;

  PickedFile foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel productoData = ModalRoute.of(context).settings.arguments;

    if(productoData != null){
      producto =productoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarImagen,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _capturarFoto,
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
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
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
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre'
      ),
      onSaved: (value) => producto.titulo = value,
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
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => producto.valor = double.parse(value),
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
      onPressed: (_guardando)? null : _submit, 
    );
  }

  _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible, 
      title: Text('disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          producto.disponible = value;
        });
      }
    );

  }


  void _submit() async{
    String msg = '';

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {_guardando = true;});

    if(foto != null){
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }

    if(producto.id == null){
      productoProvider.crearProducto(producto);
      msg = 'Producto creado exitosamente.';
    }else{
      productoProvider.editarProducto(producto);
      msg = 'Producto actualizado exitosamente.';
    }

    //setState(() {_guardando = false;});
    _mostrarSnackbar(msg);

    Navigator.pop(context);
  }


  void _mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),

    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto(){
    if (producto.fotoUrl != null) {
       return FadeInImage(
         image: NetworkImage(producto.fotoUrl),
         placeholder: AssetImage('assets/jar-loading.gif'),
         height: 300.0,
         fit: BoxFit.contain,
       );     
    }else {
       if( foto != null ){
        return Image.file(
          File(foto.path),
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }

  }


  void _seleccionarImagen() {
     _procesarImagen(ImageSource.gallery);
  }

  void _capturarFoto() {
       _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource imageSource) async{
     foto = await ImagePicker().getImage(
      source: imageSource
    );

    if(foto != null){
      producto.fotoUrl = null;
    }

    setState(() { });
  }
}
