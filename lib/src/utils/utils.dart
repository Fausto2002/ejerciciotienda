import 'package:ejerciciotienda/src/bloc/provider.dart';
import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarDetallesYAgregarAlCarrito(
    BuildContext context, ProductoModel producto) {
  final carritoBloc = Provider.carritoDeCompras(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(producto.title!),
        content: SizedBox(
          width: 300,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Descripción: ${producto.description}"),
              Text("Categoría: ${producto.category}"),
              Text("Precio: \$${producto.price!.toStringAsFixed(2)}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              carritoBloc.agregarProducto(producto);
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Producto agregado al carrito.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Agregar al carrito'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}
