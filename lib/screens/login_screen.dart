import 'package:flutter/material.dart';
import '../service/api_service.dart';
import './home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
// ...

void main() {
  final apiService = ApiService(); // Instancia de ApiService
  runApp(LoginApp(apiService: apiService));
}

class LoginApp extends StatelessWidget {
  final ApiService apiService;
  const LoginApp({required this.apiService});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de inicio de sesión',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(apiService: apiService),
    );
  }
}

class LoginPage extends StatefulWidget {
  final ApiService apiService;

  const LoginPage({required this.apiService});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  get apiService => apiService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0),
          child: Padding(
            padding: EdgeInsets.all(16.0), // Padding alrededor del formulario
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50, // Color de fondo del formulario
                borderRadius: BorderRadius.circular(
                    10.0), // Bordes redondeados del formulario
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  // Envuelve el Column en un SingleChildScrollView
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(800.0), // Ajusta el valor según tu preferencia
                          child: Image.asset(
                            'assets/logo.jpeg',
                            width: 100.0, // Ajusta el tamaño de la imagen según tu necesidad
                            height: 100.0,
                            fit: BoxFit.cover, // Ajusta la forma en que la imagen se ajusta dentro del espacio asignado
                          ),
                        )


                      ),
                      Container(
                        child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Iniciar session")),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            16.0), // Padding interno del formulario
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(labelText: 'Correo electrónico'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu correo electrónico';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            16.0), // Padding interno del formulario
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Contraseña'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu contraseña';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        child: Text('Iniciar sesión'),
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            try {
                              var response = await widget.apiService
                                  .loginUser(_email, _password);

                              var message = response['message'];
                              print(message);
                              if (message == "Inicio de sesión exitoso") {
                                try{
                                  var user = response['user'];
                                  final storage = FlutterSecureStorage();
                                  await storage.write(key: 'user', value: jsonEncode(user));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                                }catch(e){
                                  print('error guadando en local storage $e');
                                }

                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error de inicio de sesión"),
                                      content:
                                          Text("El usuario es incorrecto."),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } catch (e) {
                              // Manejar errores de la solicitud a la API aquí
                              print(
                                  'Error cath durante el inicio de sesión: $e');
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
