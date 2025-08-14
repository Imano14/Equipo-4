import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase.dart';
import 'package:inventario_project/firebase_options.dart';
import 'signup.dart';
import 'login2.dart';
import 'tabla_movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventario App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage1.id,
      routes: {
        LoginPage1.id: (context) => LoginPage1(),
        Singup.id: (context) => Singup(),
        '/tabla': (context) => TablaProductPage(),
      },
    );
  }
}
