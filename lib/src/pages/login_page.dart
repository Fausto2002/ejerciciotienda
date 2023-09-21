import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Datos parametrizados
  final String _paramUsername = '@Fausto';
  final String _paramPassword = 'Fausto2002';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 179, 1.0)
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, left: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
            padding: const EdgeInsets.only(top: 80.0),
            child: const Column(
              children: [
                Icon(Icons.person_pin_circle, color: Colors.white, size: 90.0),
                SizedBox(
                  height: 10.0,
                  width: double.infinity,
                ),
                Text("Fausto Torres",
                    style: TextStyle(color: Colors.white, fontSize: 20.0))
              ],
            ))
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Iniciar Sesion",
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 60.0),
                _crearUsername(),
                const SizedBox(
                  height: 30.0,
                ),
                _crearPassword(),
                const SizedBox(
                  height: 30.0,
                ),
                _crearBoton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearUsername() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _usernameController,
          decoration: const InputDecoration(
            icon: Icon(Icons.person, color: Colors.deepPurple),
            hintText: "@fausto11",
            labelText: "Usuario",
          ),
        ));
  }

  Widget _crearPassword() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock, color: Colors.deepPurple),
            labelText: "Contraseña",
          ),
        ));
  }

  Widget _crearBoton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
          textStyle: const TextStyle(color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: () {
          final username = _usernameController.text;
          final password = _passwordController.text;

          if (username == _paramUsername && password == _paramPassword) {
            Navigator.pushReplacementNamed(context, "tienda");
          } else {
            mostrarError(context, "Credenciales incorrectas.");
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text("Ingresar"),
        ));
  }

  void mostrarError(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de inicio de sesión'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
