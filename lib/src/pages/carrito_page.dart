import 'package:ejerciciotienda/src/bloc/provider.dart';
import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:flutter/material.dart';

class CarritoPage extends StatefulWidget {
  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrito de Compras'),
        ),
        body: _buildCarritoList(),
        bottomNavigationBar: _crearBoton());
  }

  Widget _buildCarritoList() {
    final carritoDeCompras = Provider.carritoDeCompras(context);
    return ListView.builder(
      itemCount: carritoDeCompras.productos.length,
      itemBuilder: (context, index) {
        final producto = carritoDeCompras.productos[index];
        return ListTile(
          title: Text(producto.title!),
          subtitle: Text('Precio: \$${producto.price!.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              eliminarProducto(carritoDeCompras, producto);
            },
          ),
        );
      },
    );
  }

  Widget _crearBoton() {
    final carritoDeCompras = Provider.carritoDeCompras(context);
    final productos = carritoDeCompras.productos;
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Total: \$${carritoDeCompras.calcularTotal().toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                final codigoFactura = generarCodigoFactura();
                mostrarFactura(context, codigoFactura, productos);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Generar Factura'),
            ),
          ],
        ),
      ),
    );
  }

  String generarCodigoFactura() {
    return 'FACT-${DateTime.now().millisecondsSinceEpoch}';
  }

  void eliminarProducto(CarritoDeCompras carrito, ProductoModel producto) {
    carrito.eliminarProducto(producto);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Producto eliminado del carrito.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void mostrarFactura(BuildContext context, String codigoFactura,
      List<ProductoModel> productos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Factura Generada'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Código de Factura: $codigoFactura'),
              const SizedBox(height: 10.0),
              const Text('Productos comprados:'),
              const SizedBox(height: 5.0),
              for (final producto in productos)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${producto.id}'),
                    Text('Título: ${producto.title}'),
                    Text('Precio: \$${producto.price!.toStringAsFixed(2)}'),
                    const Divider(),
                  ],
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
