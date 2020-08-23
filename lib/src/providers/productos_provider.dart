
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:crud_practica/src/models/producto_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

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

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';

    final respuesta = await http.put(
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

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';

    final respuesta = await http.delete(url);

    return 1;
  }

  Future<String> subirImagen( PickedFile imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dzphosfht/image/upload?upload_preset=augyhuuk');

    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0],mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo ha salido mal...');
      print(resp.body);
      return null;
    }

    final responseData = json.decode(resp.body);
      print(responseData);
      
    return responseData['secure_url'];
  }

}