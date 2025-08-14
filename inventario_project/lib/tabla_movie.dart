import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:printing/printing.dart';
import 'login2.dart';
import 'package:pdf/widgets.dart' as pw;

class InventarioProducto {
  final String id;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final double precio;

  InventarioProducto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precio': precio,
    };
  }

  factory InventarioProducto.fromMap(String id, Map<String, dynamic> map) {
    return InventarioProducto(
      id: id,
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
      cantidad: map['cantidad'] ?? 0,
      precio: (map['precio'] ?? 0).toDouble(),
    );
  }
}

class TablaProductPage extends StatefulWidget {
  @override
  _TablaProductPageState createState() => _TablaProductPageState();
}

class _TablaProductPageState extends State<TablaProductPage> {
  final CollectionReference<Map<String, dynamic>> productosRef =
      FirebaseFirestore.instance.collection('productos');

  String? selectedId;
  String filtroNombre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de Productos'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Buscar producto",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (valor) {
                            filtroNombre = valor.toLowerCase();
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Buscar"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: productosRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final productos =
                          snapshot.data!.docs
                              .map(
                                (doc) => InventarioProducto.fromMap(
                                  doc.id,
                                  doc.data(),
                                ),
                              )
                              .where(
                                (p) => p.nombre.toLowerCase().contains(
                                  filtroNombre,
                                ),
                              )
                              .toList();

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Descripción')),
                            DataColumn(label: Text('Cantidad')),
                            DataColumn(label: Text('Precio')),
                          ],
                          rows:
                              productos.map((producto) {
                                return DataRow(
                                  selected: selectedId == producto.id,
                                  onSelectChanged: (selected) {
                                    setState(() {
                                      selectedId = producto.id;
                                    });
                                  },
                                  cells: [
                                    DataCell(Text(producto.nombre)),
                                    DataCell(Text(producto.descripcion)),
                                    DataCell(
                                      Text(producto.cantidad.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        '\$${producto.precio.toStringAsFixed(2)}',
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _agregarProductoDialog(),
                  child: Text("Agregar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedId == null ? null : () => _editarProductoDialog(),
                  child: Text("Editar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedId == null ? null : () => _eliminarProducto(),
                  child: Text("Eliminar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                ElevatedButton(
                  onPressed: _exportarPDF,
                  child: Text("Exportar PDF"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent.shade700),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, LoginPage1.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tus funciones originales
  void _agregarProductoDialog() {
    String nombre = '', descripcion = '', cantidad = '', precio = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Agregar Producto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Nombre"),
                onChanged: (value) => nombre = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Descripción"),
                onChanged: (value) => descripcion = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Cantidad"),
                keyboardType: TextInputType.number,
                onChanged: (value) => cantidad = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Precio"),
                keyboardType: TextInputType.number,
                onChanged: (value) => precio = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await productosRef.add({
                    'nombre': nombre,
                    'descripcion': descripcion,
                    'cantidad': int.parse(cantidad),
                    'precio': double.parse(precio),
                  });

                  // 🔹 Resetea el filtro de búsqueda
                  filtroNombre = "";
                  setState(() {});

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto agregado correctamente')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al agregar: $e')),
                  );
                }
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void _editarProductoDialog() async {
    if (selectedId == null) return;
    final doc = await productosRef.doc(selectedId).get();
    if (!doc.exists) return;

    final producto = InventarioProducto.fromMap(doc.id, doc.data()!);

    String nombre = producto.nombre,
        descripcion = producto.descripcion,
        cantidad = producto.cantidad.toString(),
        precio = producto.precio.toStringAsFixed(2);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Producto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Nombre"),
                controller: TextEditingController(text: nombre),
                onChanged: (value) => nombre = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Descripción"),
                controller: TextEditingController(text: descripcion),
                onChanged: (value) => descripcion = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Cantidad"),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: cantidad),
                onChanged: (value) => cantidad = value,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Precio"),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: precio),
                onChanged: (value) => precio = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await productosRef.doc(selectedId).update({
                    'nombre': nombre,
                    'descripcion': descripcion,
                    'cantidad': int.parse(cantidad),
                    'precio': double.parse(precio),
                  });

                  filtroNombre = "";
                  setState(() {});

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Producto actualizado correctamente'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al actualizar: $e')),
                  );
                }
              },
              child: Text("Editar"),
            ),
          ],
        );
      },
    );
  }

  void _eliminarProducto() async {
    if (selectedId == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar Producto"),
          content: Text("¿Seguro que quieres eliminar este producto?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await productosRef.doc(selectedId).delete();

                  filtroNombre = "";
                  setState(() {});
                  selectedId = null;

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto eliminado correctamente')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar: $e')),
                  );
                }
              },
              child: Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _exportarPDF() async {
    try {
      final pdf = pw.Document();
      final snapshot = await productosRef.get();

      final productos =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return InventarioProducto.fromMap(doc.id, data);
          }).toList();

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Inventario de Productos',
                  style: pw.TextStyle(fontSize: 24),
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headers: ['Nombre', 'Descripción', 'Cantidad', 'Precio'],
                  data:
                      productos
                          .map(
                            (p) => [
                              p.nombre,
                              p.descripcion,
                              p.cantidad.toString(),
                              '\$${p.precio.toStringAsFixed(2)}',
                            ],
                          )
                          .toList(),
                ),
              ],
            );
          },
        ),
      );

      // Mostrar diálogo de impresión o guardado
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al exportar PDF: $e')));
    }
  }
}
