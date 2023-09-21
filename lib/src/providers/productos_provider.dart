import 'dart:convert';

import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = "https://fakestoreapi.com";

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.parse("$_url/products");

    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = Uri.parse("$_url/products");
    final resp = await http.get(url);

    final List<dynamic> decodeData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    // ignore: unnecessary_null_comparison
    if (decodeData == null) return [];

    for (var prod in decodeData) {
      final prodTemp = ProductoModel.fromJson(prod);
      productos.add(prodTemp);
    }

    return productos;
  }
}
