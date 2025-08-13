class TextfieIdGeneral extends
  StatelessWidget{
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
  Widget build(BuildContext context){
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal:30),
      child: TextFormField(
        keyboardType:keyboardType,
        obscureText:obscureText,
        decoration:InputDecoration(
          prefixlcon:Iconicon),
        labelText:labelText,
        hintText:hintText,
        border:OutlinelnputBorder(
          border:Radius:
          BorderRadius.circular(13.333),
          ),
        filled:true,
        fillColor:colors.white,
        ),
      onChanged: onChanged,
      validator:validator,
      ),
    );
  }
}
class Singup extends StatefulWidget{
  static const String id='Sing_up';

  @override
  State<Singup> createState()=>
  _SingupState();
}

class _SingupState  State <Singup>
{
  final _formKey = GlobalKey<FormState>();
  String _correo=";
  String _contrasena =";
  String _nombre =";
  String _usuario = ";
  String _telefono = ";

  @override
  Widget build(BuildContext context){
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
  child:Column(
  crossAxisAlignment:
  CrossAxisAlignment.start,
  children:[
  SizedBox(height: 10),
  Padding(
  padding:const
  Edgelnsets.only(left:30.0),
  child:Text(
  "Registrate",
  style:TextStyle(
  color:Colors.black,
  fontSiza:40,
  fontWeight:FontWeight.bold,
  fontFamily:"Impact",
  ),
  ),
  ),
  Row(mainAxisAlignment:
  MainAxisAlignment.center),
  SizedBox(height:25),

  _textfieldnombre(),
  SizedBox(height:15),

  _textfieldusuario(),
  SizedBox(height:15),

  _textfieldEmail().
  SizedBox(height:15),

  _textfieldPassword(),
  SizedBox(height:15),

  _textfieldtelefono(),
  SizedBox(height:15),

  _buttonSingUp(),
  SizedBox(height:35),
  ],
  ),
  ),
  ),
  ),
  ),
  }

  Widget _textfieIdnombre(){
  return TextfielIdGeneral(
  labelText:"Nombre",
  hintText:"Ingresa tu nombre",
  icon:Icons.person_outline,
  obscureText:false,
  onChanged:(value) =>_nombre=value,
  validator:
  (value)=>value == null ||
  value.isEmptY ? 'Campo requerido': null,
  );
  }

  Widget _textfiIdusuario(){
  return TextfieldGeneral(
  labelText:"Usuario",
  hintText: "Ingresa tu usuario",
  icon:Icons.person_outline,
  obscureText:false,
  onChanged:(value) => _usuario = value,
  validator:
  (value)=> value == null ||
  value.isEmpaty ? 'Campo requerido' : null,
  );
  }

    Widget _textfiIdEmail(){
  return TextfieIdGeneral(
  labelText:"Correo",
  hintText: "correo@ejemplo.com",
  icon:Icons.email_outline,
  keyboardType:
  TextImputType.emailAddress,
  obscureText: false,
  onChanged:(value) => _correo= value,
  validator:
  (value)=> value == null ||
  value.isEmpaty ? 'Campo requerido' : null,
  );
  }

     Widget _textfiIdPassword(){
  return TextfieIdGeneral(
  labelText:"Contraseña",
  hintText: "*********",
  icon:Icons.lock,
  keyboardType:
  TextImputType.visiblePassword,
  obscureText: true,
  onChanged:(value) => _contrasena= value,
  validator:
  (value)=> value == null ||
  value.isEmpaty ? 'Campo requerido' : null,
  );
  }

     Widget _textfiIdtelefono(){
  return TextfieIdGeneral(
  labelText:"Teléfono",
  hintText: "Ingresa tu número de teléfono",
  icon:Icons.phone,
  keyboardType:
  TextImputType.phone,
  obscureText: false,
  onChanged:(value) => _telefono = value,
  validator:
  (value)=> value == null ||
  value.isEmpaty ? 'Campo requerido' : null,
  );
  } 

  Widget _buttonSingUp(){
  return Center(
  child:ElevatedButton(
  onPressed:(){
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => TablaInfoPage()),
  );
  },
  child: Tect("Iniciar sesión"),
  style:ElevatedButton.styleFrom(
  backgroundColor: Colors.yellow,
  foregroundColor:Colors.black,
  textStyle:TextStyle(fontSize:20),
  padding:
  EdgeInsets.symmetric(horizontal: 40,
  vertical:15),
  ),
  ),
  );
  }
  }
