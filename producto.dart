class Producto {
  int id;
  String nombre;
  String descripcion;
  double precio;
  int cantidad;
  String categoria;
  DateTime fechaIngreso;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.cantidad,
    required this.categoria,
    required this.fechaIngreso,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio'].toString()),
      cantidad: json['cantidad'],
      categoria: json['categoria'],
      fechaIngreso: DateTime.parse(json['fecha_ingreso']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'cantidad': cantidad,
      'categoria': categoria,
    };
  }
}
