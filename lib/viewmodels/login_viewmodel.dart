import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_brokr/presentation/screens/confirmation_screen.dart';
import 'dart:convert';

import '../models/costumer.dart';
import '../presentation/screens/home_screen.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  String bearer_token = '4|HpKlxwsfUCcvcJnCGql5nWM7WdkrJwZTn98IDgN8';
  String base_url = 'https://staging.brokr.com/api/';

  //Login con correo y password
  Future<void> loginWithEmail(
      BuildContext context,
      String email,
      String password
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${base_url}api/auth/login'),
        headers: {'Authorization': 'Bearer $bearer_token'},
        body: {
          'email': email,
          'password': password,
          'os': 'android',
          'type': 'guest',
          'fcm_token': 'DFGKNODFIJO34U89FGKNO',
          'language': 'es',
        },
      );

      if (response.statusCode == 200) {
        //bearer_token = response.headers['Authorization']!;
        final userJson = json.decode(response.body);
        final customer = Customer.fromJson(userJson);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(usuario: customer.data.customer)), (route) => false);

      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Credenciales inválidas, intente nuevamente.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error al conectarse con API servicio de login: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ha ocurrido un error inesperado, intente de nuevo más tarde.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  //Registro de usuario
  Future<void> SignUp(
      BuildContext context,
      String name,
      String lastName,
      String birthday,
      String phoneCode,
      String phoneNumber,
      String email,
      String password
      ) async {
    try {
      final response = await http.post(
        Uri.parse('${base_url}api/auth/register'),
        headers: {'Authorization': 'Bearer $bearer_token'},
        body: {
          'name': name,
          'last_name': lastName,
          'birthdate': birthday,
          'id_country': 'US',
          'phone': phoneNumber,
          'phone_code': phoneCode,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'os': 'android',
          'type': 'guest',
          'language': 'es',
        },
      );

      if (response.statusCode == 200) {
        //bearer_token = response.headers['Authorization']!;
        final userJson = json.decode(response.body);
        print(userJson.toString());

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistroExitosoPage()), (route) => false);

      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('No se ha podido procesar la solicitud, intente nuevamente.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error al conectarse con API servicio de sign up: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ha ocurrido un error inesperado, intente de nuevo más tarde.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }




}