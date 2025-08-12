class Usuario {
  int id;
  String nombre;
  String usuario;
  String correo;
  String telefono;

  Usuario({
    required this.id,
    required this.nombre,
    required this.usuario,
    required this.correo,
    required this.telefono,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      usuario: json['usuario'],
      correo: json['correo'],
      telefono: json['telefono'],
    );
  }
}
