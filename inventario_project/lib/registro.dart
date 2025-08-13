class TextfieldGeneral extends
  StatelessWidget {
final String labelText;
final String hintText;
final Funtion(String) onChanged;
final TextInputType keyboardType;
final IconData icon;
final bool obscureText;
final String? Fuction(String?)?
validator;

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
 margin: EdgeInsets.symmetric(horizotal: 30),
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
   onChanget: onChanged,
   validator: validator,
     ),
   );
 }
}

class Singup extends StatefulWidget
{
static const String id = 'Sing_up';

@override
State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
final _formKey = Globalkey<FormState>();
  String _nombre = '';
  String _descripcion = '';
  String _cantidad = '';
  String _precio= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

   backgroundColor: Color(0xFFB71C1C),
    appBar: AppBar(

   leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onpressed: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
      );
    },
   ),
  title: Text('SingUp'),
  backgroundColor: Colors.transparent,
  elevation: 0,
 ),
  body: Form(
  key: _formKey,
  child: Center(
  child: SingleChildScrollView(
  child: Column(
  crossAlignment: CrossAligment.start,
  children: [
  SizedBox(height: 10),
  Padding(
  padding: const EdgeInsets.only(left: 30.0),
  child: Text(
  "Registrate",
  style: TextSyle(
  colors: Colors.black,
  fontSize:40,
  fontWeight: FontWeight.bold, 
  fontFamily: "Impact",
    ),
   ),
 ),
Row(mainAxisAligment: MainAxisAligment.center),
SizedBox(height: 25),

_textfielnombre(),
 SizedBox(height: 15),

_textfieldescripcion()
SizedBox(height: 15),

 _textfielCantidad(),
SizedBox(height: 15),
  
 _textfielPrecio(),
SizedBox(height: 15),

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
      hintText: "Ingresa el nombre",
      icon: Icons.person_outline,
      obscureText: false,
      onChanged: (value) => _nombre = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieldescripcion() {
    return TextfieldGeneral(
      labelText: "Descripcion",
      hintText: "Ingresa una descripcion del producto",
      icon: Icons.person_outline,
       obscureText: false,
      onChanged: (value) => _usuario = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfielCantidad() {
    return TextfieldGeneral(
      labelText: "Cantidad",
      hintText: "1",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
        obscureText: false,
      onChanged: (value) => _correo = value,
      validator:
          (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _textfieldPrecio() {
    return TextfieldGeneral(
      labelText: "Precio",
      hintText: "",
      icon: Icons.lock,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: (value) => _contrasena = value,
      validator:
          (value) => value == null || 
      value.isEmpty ? 'Campo requerido' : null,
    );
  }

 Widget _buttonSingUp() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TablaInfoPage()),
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

  





  









  
                


  

      

  
      
      



  
  







     

   
       
      

 

  
  

      
      
  


