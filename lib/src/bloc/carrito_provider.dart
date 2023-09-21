import 'package:ejerciciotienda/src/models/productos_model.dart';

class CarritoDeCompras {
  List<ProductoModel> productos = [];

  void agregarProducto(ProductoModel producto) {
    productos.add(producto);
  }

  void eliminarProducto(ProductoModel producto) {
    productos.remove(producto);
  }

  double calcularTotal() {
    double total = 0;
    for (var producto in productos) {
      total += producto.price!;
    }
    return total;
  }

  void vaciarCarrito() {
    productos.clear();
  }
}
