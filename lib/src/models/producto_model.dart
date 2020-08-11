import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });


    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id          : json["id"],
        titulo      : json["titulo"],
        valor       : json["valor"],
        disponible  : json["disponible"],
        fotoUrl     : json["foto_url"],
    );

    Map<String, dynamic> toJson() => {
        "titulo"      : titulo,
        "valor"       : valor,
        "disponible"  : disponible,
        "foto_url"    : fotoUrl,
    };
}
