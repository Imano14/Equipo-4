import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.333),
      ),
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

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _correo = '';
  String _contrasena = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB71C1C),
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inventario \n JVK".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    fontFamily: "MontaguSlab_24pt-Bold",
                  ),
                ),
                // ...existing code...
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/inventario.png',
                      height: 1000,
                      width: 1000,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                SizedBox(height: 0),
                _textfieldName(),

                SizedBox(height: 7),
                _textfieldPassword(),
                SizedBox(height: 7),

                _buttonSingUp(context),
                SizedBox(height: 7),

                _buttomlogin(context),
                SizedBox(height: 7),
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

  Widget _buttonSingUp(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Singup()),
        );
      },
      child: Text("REGISTRARSE"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFD700), // Dorado
        foregroundColor: Color(0xFFB71C1C),
        textStyle: TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buttomlogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text("INICIAR SESIÓN"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF616161), // Gris metálico
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
