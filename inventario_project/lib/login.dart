import 'package:flutter/material.dart';
import 'package:inventario_project/main.dart';
import 'package:inventario_project/registro_product.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.333),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class Singup extends StatefulWidget {
  static const String id = 'Sing_up';

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _formKey = GlobalKey<FormState>();
  String _correo = '';
  String _contrasena = '';
  String _nombre = '';
  String _usuario = '';
  String _telefono = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB71C1C),
      appBar: AppBar(
        title: Text('SingUp'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Registrate",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Impact",
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center),
                SizedBox(height: 25),

                _textfieldnombre(),
                SizedBox(height: 15),

                _textfieldusuario(),
                SizedBox(height: 15),

                _textfieldEmail(),
                SizedBox(height: 15),

                _textfieldPassword(),
                SizedBox(height: 15),

                _textfieltelefono(),
                SizedBox(height: 15),

                _buttonSingUp(),
                SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textfieldnombre() {
    return TextfieldGeneral(
      labelText: "Nombre",
      hintText: "Ingresa tu nombre",
      icon: Icons.person_outline,
      obscureText: false,
      onChanged: (value) => _nombre = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieldusuario() {
    return TextfieldGeneral(
      labelText: "Usuario",
      hintText: "Ingresa tu usuario",
      icon: Icons.person_outline,
      obscureText: false,
      onChanged: (value) => _usuario = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieldEmail() {
    return TextfieldGeneral(
      labelText: "Correo",
      hintText: "correo@ejemplo.com",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      onChanged: (value) => _correo = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieldPassword() {
    return TextfieldGeneral(
      labelText: "Contraseña",
      hintText: "********",
      icon: Icons.lock,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: (value) => _contrasena = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieltelefono() {
    return TextfieldGeneral(
      labelText: "Teléfono",
      hintText: "Ingresa tu número de teléfono",
      icon: Icons.phone,
      keyboardType: TextInputType.phone,
      obscureText: false,
      onChanged: (value) => _telefono = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  // ...existing code...
  Widget _buttonSingUp() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Text("Iniciar Sesion"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
      ),
    );
  }
}
