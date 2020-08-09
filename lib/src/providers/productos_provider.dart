
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud_practica/src/models/producto_model.dart';

class ProductosProvider {
  
  final String _url = 'https://flutter-practicas-5f178.firebaseio.com';


  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final respuesta = await http.post(
      url,
      body: productoModelToJson(producto)
    );

    final decodedData = json.decode(respuesta.body);
    
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final respuesta = await http.get(url);
    final List<ProductoModel> productos = new List();

    final Map<String,dynamic> decodedData = json.decode(respuesta.body);

    if(decodedData == null) return [];

    decodedData.forEach((id, producto) { 
      final prodTmp = ProductoModel.fromJson(producto);
      prodTmp.id = id;
      productos.add(prodTmp);
    });

    return productos;
  }

}