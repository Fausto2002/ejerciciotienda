import 'package:ejerciciotienda/src/bloc/productos.bloc.dart';
import 'package:ejerciciotienda/src/bloc/carrito_provider.dart';
export 'package:ejerciciotienda/src/bloc/carrito_provider.dart';
export 'package:ejerciciotienda/src/bloc/productos.bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final _productosBloc = ProductosBloc();
  final _carritoDeCompras = CarritoDeCompras();

  Provider({Key? key, Widget? child}) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()!
        ._productosBloc;
  }

  static CarritoDeCompras carritoDeCompras(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()!
        ._carritoDeCompras;
  }
}
