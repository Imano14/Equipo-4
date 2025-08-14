import 'package:flutter/material.dart';
import 'package:inventario_project/login2.dart';
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
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage1()),
            );
          },
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registrate".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    fontFamily: "MontaguSlab_24pt-Bold",
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
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              final usuariosRef = FirebaseFirestore.instance.collection(
                'usuarios',
              );

              // Verificar si el correo ya existe
              final snapshot =
                  await usuariosRef.where('correo', isEqualTo: _correo).get();

              if (snapshot.docs.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("El correo ya está registrado")),
                );
                return;
              }

              // Guardar nuevo usuario
              await usuariosRef.add({
                'nombre': _nombre,
                'usuario': _usuario,
                'correo': _correo,
                'password': _contrasena,
                'telefono': _telefono,
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Usuario registrado correctamente")),
              );

              // Redirigir al login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage1()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error al registrar usuario: $e")),
              );
            }
          }
        },
        child: Text("Registrarse"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
      ),
    );
  }
}
