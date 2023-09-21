import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ejerciciotienda/src/bloc/provider.dart';
import 'package:ejerciciotienda/src/models/productos_model.dart';
import 'package:ejerciciotienda/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductosBloc productosBloc;
  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  File? foto;
  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);
    final ProductoModel? prodData =
        ModalRoute.of(context)!.settings.arguments as ProductoModel?;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
              icon: const Icon(Icons.photo_size_select_actual),
              onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.camera_alt_rounded),
            onPressed: () {},
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _crearNombre(),
                  _crearPrecio(),
                  _crearBoton(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(labelText: "Producto"),
      onSaved: (value) => producto.title = value!,
      validator: (value) {
        if (value!.length < 3) {
          return "Ingrese el nombre del producto";
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.price.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(labelText: "Precio"),
      onSaved: (value) => producto.price = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return "Solo numeros";
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.save),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
      onPressed: (_guardando) ? null : _submit,
      label: const Text(
        "Guardar",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    setState(() {
      _guardando = true;
    });

    if (producto.id == null) {
      productosBloc.agregarProducto(producto);
    }

    mostrarSnackBar("Registro guardado");

    Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(
        content: Text(mensaje), duration: const Duration(milliseconds: 1500));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
