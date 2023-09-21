import 'package:rxdart/rxdart.dart';
import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:ejerciciotienda/src/providers/productos_provider.dart';

class ProductosBloc {
  final _productosController = BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = BehaviorSubject<bool>();

  final _productosProvider = ProductosProvider();

  Stream<List<ProductoModel>> get productosStream => _productosController;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  dispose() {
    _productosController.close();
    _cargandoController.close();
  }
}
