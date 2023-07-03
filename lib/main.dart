import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'service/api_service.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login':(context) => LoginApp(apiService: ApiService()),
      '/home': (context) => HomePage(),
    },
  ));
}
