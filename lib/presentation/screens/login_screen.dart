import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../viewmodels/login_viewmodel.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      // Obtener los datos del usuario
      final String email = account.email;
      final String? name = account.displayName;

      // Mostrar los datos del usuario
      print("Correo: $email");
      print("Nombre: $name");
    }
  } catch (e) {
    print(e);
  }
}


class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perfil',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Inicia sesión y empieza a planificar tu próximo viaje.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Mostrar BottomSheet para iniciar sesión
                    _showBottomSheetLogIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff6863fa),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('¿No tienes una cuenta?'),
                  TextButton(
                      onPressed: (){
                        // Mostrar BottomSheet para registro de usuario
                        _showBottomSheetSignUp(context);
                      },
                  child: Text(' Regístrate')
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }

  //Inicio de sesión con email y password
  void _showBottomSheetLogIn(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    bool _isHidden = true;
    bool _isLoading = false;



    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (context) => LoginViewModel(),
          child: Consumer<LoginViewModel>(
          builder: (context, loginViewModel, _) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.90,
                padding: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Center(
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 48),
                          // Espacio adicional para centrar el título
                        ],
                      ),
                    ),
                    Container(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            shrinkWrap: true,
                            children: [

                              //email field
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    counterText: ''
                                ),
                                maxLength: 35,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 15),

                              //password field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isHidden,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {

                                        _isHidden = !_isHidden;
                                        // Actualizar el estado para cambiar la visibilidad del campo de contraseña
                                        (context as Element).markNeedsBuild();
                                      },
                                    ),
                                    counterText: ''
                                ),
                                maxLength: 30,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 30),

                              //Button
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Lógica cuando el formulario es válido
                                      _isLoading = true;
                                      (context as Element).markNeedsBuild();

                                      // Llama al método de login
                                      await Provider.of<LoginViewModel>(
                                          context, listen: false)
                                          .loginWithEmail(
                                        context,
                                        _usernameController.text.trim(),
                                        _passwordController.text,
                                      );

                                      // Actualiza el estado después de la llamada a la API
                                      _isLoading = false;
                                      (context as Element).markNeedsBuild();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff6863fa),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  child: _isLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                    'Continue',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30),

                              // Divider personalizado con texto "Or" en el centro
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      //color: Colors.black,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'Or',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      //color: Colors.black,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 30),

                              //Google boton
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: signInWithGoogle,

                                  //     () async {
                                  //   try {
                                  //     // Lógica cuando se presiona el botón con Google
                                  //     // Obtenga el token de autenticación de Google del usuario
                                  //     final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
                                  //     final GoogleSignInAuthentication? googleAuth = await googleAccount?.authentication;
                                  //
                                  //     // Verifica si se obtuvo correctamente el objeto GoogleSignInAuthentication
                                  //     if (googleAuth != null) {
                                  //       // Decodificar el token JWT para obtener los claims
                                  //       Map<String, dynamic>? decodedToken = json.decode(
                                  //           utf8.decode(base64Url.decode(googleAuth.idToken!))
                                  //       );
                                  //
                                  //       // Imprimir los datos del usuario
                                  //       if (decodedToken != null) {
                                  //         print(decodedToken);
                                  //       } else {
                                  //         print('Error: No se pudieron obtener los detalles del usuario');
                                  //       }
                                  //     } else {
                                  //       print('Error: No se pudo obtener la autenticación de Google');
                                  //     }
                                  //   } catch (error) {
                                  //     print('Error al autenticar con Google: $error');
                                  //   }
                                  // },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.black,
                                          width: 1),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    primary: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10),
                                        child: Image.asset(
                                          'assets/images/google_logo.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                      ),
                                      Text(
                                        'Continuar con Google',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      SizedBox(width: 48),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),

              ),
            );
          }),
        );
      },
    );

  }

  //Registro completo
  void _showBottomSheetSignUp(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _birthdayController = TextEditingController();
    TextEditingController _phoneCodeController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordConfirmationController = TextEditingController();
    bool _isHiddenPassword = true;
    bool _isHiddenConfirmPassword = true;
    DateTime? _selectedDate;
    bool _isLoading = false;

    List<String> countries = [
      '🇺🇸 +1  United States',
      '🇬🇧 +44 United Kingdom',
      '🇦🇺 +61 Australia',
      '🇮🇳 +91 India',
      '🇪🇨 +593 Ecuador',
      '🇻🇪 +58 Venezuela',
    ];

    // Create a mask formatter for phone numbers
    var phoneMaskFormatter = MaskTextInputFormatter(mask: '(###) ###-####');


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
        builder: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
    child: Consumer<LoginViewModel>(
    builder: (context, loginViewModel, _) {
    return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 48), // Espacio adicional para centrar el título
                    ],
                  ),
                ),
                Container(
                  child: Divider(
                    thickness: 1,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Form(
                      key: _formKey,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          //Name field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              counterText: ''
                            ),
                            keyboardType: TextInputType.name,
                            maxLength: 30,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 15),

                          //Last name field
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              counterText: ''
                            ),
                            keyboardType: TextInputType.name,
                            maxLength: 30,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a last name';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 15),

                          //Birthday field
                          TextFormField(
                            controller: _birthdayController,
                            decoration: InputDecoration(
                              labelText: 'Birthday',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );

                                  if (selectedDate != null && selectedDate != _selectedDate) {
                                    _selectedDate = selectedDate;
                                    _birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!).toString();
                                    (context as Element).markNeedsBuild();
                                  }

                                },
                                child: Icon(Icons.calendar_today),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              if (selectedDate != null && selectedDate != _selectedDate) {
                                _selectedDate = selectedDate;
                                _birthdayController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!).toString();
                                (context as Element).markNeedsBuild();
                              }
                            },
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Please select your birthday';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 15),

                          //Country/Region field
                          DropdownButtonFormField<String>(
                            items: countries.map((String country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(country),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Country/Region',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              _phoneCodeController.text = value.toString().substring(6, 9).trim();
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a country/region';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),

                          //Phone number field
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              counterText: '',
                            ),
                            maxLength: 14,
                            inputFormatters: [phoneMaskFormatter],
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Please indicate your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),

                          //Email field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              counterText: ''
                            ),
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 35,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 15),

                          //Password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isHiddenPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_isHiddenPassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  _isHiddenPassword = !_isHiddenPassword;
                                  // Actualizar el estado para cambiar la visibilidad del campo de contraseña
                                  (context as Element).markNeedsBuild();
                                },
                              ),
                              counterText: ''
                            ),
                            maxLength: 30,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the password';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 15),

                          //Repeat password field
                          TextFormField(
                            controller: _passwordConfirmationController,
                            obscureText: _isHiddenConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Repeat password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_isHiddenConfirmPassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
                                  // Actualizar el estado para cambiar la visibilidad del campo de contraseña
                                  (context as Element).markNeedsBuild();
                                },
                              ),
                              counterText: ''
                            ),
                            maxLength: 30,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the confirm password';
                              } else if (_passwordController.text != _passwordConfirmationController.text){
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 30),

                          Text('By clicking continue you are agreeing to our  Privacy Policy and Terms & Conditions.'),
                          SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Lógica cuando el formulario es válido
                                  _isLoading = true;
                                  (context as Element).markNeedsBuild();

                                  // Llama al método de Registro
                                  await Provider.of<LoginViewModel>(
                                      context, listen: false)
                                      .SignUp(
                                    context,
                                    _nameController.text.trim(),
                                    _lastNameController.text.trim(),
                                    _birthdayController.text.trim(),
                                    _phoneCodeController.text,
                                    _phoneController.text.replaceAll(' ()-', ''),
                                    _emailController.text.trim(),
                                    _passwordController.text.trim()
                                  );
                                  // Actualiza el estado después de la llamada a la API
                                  _isLoading = false;
                                  (context as Element).markNeedsBuild();

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff6863fa),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                'Agree and continue',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ),
          );
          }),
        );
      },
    );

  }

}
