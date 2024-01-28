import 'package:flutter/material.dart';
import 'package:test_brokr/presentation/screens/login_screen.dart';
import '../../models/costumer.dart';

class HomePage extends StatelessWidget {
  final CustomerClass usuario;

  HomePage({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6863fa),
        elevation: 8.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido,',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              usuario.name,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(usuario.name.substring(0, 1)+usuario.lastName.substring(0, 1)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white,),
            onPressed: () {
              // Lógica para cerrar sesión
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Image.asset(
          'assets/images/empty_verified.png',
          width: 200.0,
        ),
      ),
    );
  }
}
