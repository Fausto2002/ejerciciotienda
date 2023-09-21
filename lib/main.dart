import 'package:ejerciciotienda/src/bloc/provider.dart';
import 'package:ejerciciotienda/src/pages/carrito_page.dart';
import 'package:ejerciciotienda/src/pages/login_page.dart';
import 'package:ejerciciotienda/src/pages/productos_page.dart';
import 'package:ejerciciotienda/src/pages/tienda_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "login",
        routes: {
          "login": (BuildContext context) => LoginPage(),
          "tienda": (BuildContext context) => const TiendaPage(),
          "productos": (BuildContext context) => ProductoPage(),
          "carrito": (BuildContext context) => CarritoPage()
        },
      ),
    );
  }
}
