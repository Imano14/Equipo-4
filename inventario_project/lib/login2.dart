import 'package:flutter/material.dart';
import 'package:inventario_project/signup.dart';
import 'package:inventario_project/tabla_movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextfieldGeneral extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const TextfieldGeneral({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    required this.icon,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13.333)),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.blue.withOpacity(0.3), // Azul translúcido
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.333),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.333),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.333),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class LoginPage1 extends StatefulWidget {
  static const String id = 'login_page';

  @override
  State<LoginPage1> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage1> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _correo = '';
  String _contrasena = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inventario".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    fontFamily: "MontaguSlab_24pt-Bold",
                  ),
                ),

                CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/victor.jpg',
                      height: 1000,
                      width: 1000,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                _textfieldName(),
                SizedBox(height: 7),

                _textfieldPassword(),
                SizedBox(height: 7),

                _buttomlogin(context),
                SizedBox(height: 7),

                _buttomforgot(context),
                SizedBox(height: 90),

                _buttomSingUp(context),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfieldName() {
    return SizedBox(
      width: 900,
      child: TextfieldGeneral(
        labelText: "Usuario",
        hintText: "Ingresa tu usuario",
        icon: Icons.person_outline,
        obscureText: false,
        onChanged: (value) => _nombre = value,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  Widget _textfieldPassword() {
    return SizedBox(
      width: 900,
      child: TextfieldGeneral(
        labelText: "Contraseña",
        hintText: "****",
        icon: Icons.lock,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onChanged: (value) => _contrasena = value,
        validator:
            (value) =>
                value == null || value.length < 6
                    ? 'Mínimo 6 caracteres'
                    : null,
      ),
    );
  }

  Widget _buttomlogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final usuariosRef = FirebaseFirestore.instance.collection(
              'usuarios',
            );

            // Buscar usuario en Firestore usando correo o nombre de usuario y contraseña
            final snapshot =
                await usuariosRef
                    .where('password', isEqualTo: _contrasena)
                    .where('correo', isEqualTo: _nombre)
                    .get();

            final snapshotUsername =
                await usuariosRef
                    .where('password', isEqualTo: _contrasena)
                    .where('usuario', isEqualTo: _nombre)
                    .get();

            if (snapshot.docs.isNotEmpty || snapshotUsername.docs.isNotEmpty) {
              // Login exitoso
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Login exitoso")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => TablaProductPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Usuario o contraseña incorrectos")),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error al iniciar sesión: $e")),
            );
          }
        }
      },
      child: Text("Log In"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buttomforgot(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text("Forgot Password?"),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent, // Gris metálico
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buttomSingUp(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Singup()),
        );
      },
      child: Text("Create a new account"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent.shade700, // Gris metálico
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
