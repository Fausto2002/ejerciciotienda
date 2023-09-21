import 'package:flutter/material.dart';
import 'package:ejerciciotienda/src/bloc/provider.dart';
import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:ejerciciotienda/src/utils/utils.dart';

class TiendaPage extends StatelessWidget {
  const TiendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tienda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, "carrito");
            },
          ),
        ],
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, "productos"),
        child: const Icon(Icons.add));
  }

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
        stream: productosBloc.productosStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoModel>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            return ListView.builder(
              itemCount: productos!.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, productos[i], productosBloc),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context, ProductoModel producto,
      ProductosBloc productosBloc) {
    return Container(
      key: UniqueKey(),
      child: Card(
        child: Column(
          children: [
            if (producto.image != null)
              Image.network(
                producto.image!,
                height: 250.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ListTile(
              title: Text("${producto.title} - ${producto.price}"),
              subtitle: Text(producto.id.toString()),
              onTap: () {
                mostrarDetallesYAgregarAlCarrito(context, producto);
              },
            )
          ],
        ),
      ),
    );
  }
}
