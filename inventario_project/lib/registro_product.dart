import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class inventarioProducto {
  final int id;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final double precio;

  inventarioProducto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
  });
}

class _TablaProducto extends StatefulWidget {
  @override
  State<_TablaProducto> createState() => TablaProductPage();
}

class TablaProductPage extends State<_TablaProducto> {
  List<inventarioProducto> productos = [
    inventarioProducto(
      id: 1,
      nombre: 'paleta de la rosa',
      descripcion: 'es una paleta sabor a fresa',
      cantidad: 10,
      precio: 15.0,
    ),
    inventarioProducto(
      id: 2,
      nombre: 'picaros',
      descripcion: 'estan en forma de bolita',
      cantidad: 5,
      precio: 25.0,
    ),
    inventarioProducto(
      id: 3,
      nombre: 'pulparindo',
      descripcion: 'es plano y tiene chile',
      cantidad: 8,
      precio: 30.0,
    ),
  ];

  int? selectedRow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Descripción')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Precio')),
                ],
                rows:
                    productos.map((producto) {
                      return DataRow(
                        selected: selectedRow == producto.id,
                        onSelectChanged: (selected) {
                          setState(() {
                            selectedRow = producto.id;
                          });
                        },
                        cells: [
                          DataCell(Text(producto.id.toString())),
                          DataCell(Text(producto.nombre)),
                          DataCell(Text(producto.descripcion)),
                          DataCell(Text(producto.cantidad.toString())),
                          DataCell(
                            Text('\$${producto.precio.toStringAsFixed(2)}'),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Buscar producto logic here
                    showDialog(
                      context: context,
                      builder: (context) {
                        String buscar = '';
                        return AlertDialog(
                          title: Text("Buscar Producto"),
                          content: TextField(
                            decoration: InputDecoration(
                              hintText: "Ingrese el nombre del producto",
                            ),
                            onChanged: (value) => buscar = value,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedRow =
                                      productos
                                          .firstWhere(
                                            (p) =>
                                                p.nombre.toLowerCase() ==
                                                buscar.toLowerCase(),
                                            orElse: () => productos[0],
                                          )
                                          .id;
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Buscar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Buscar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String nombre = "",
                            descripcion = "",
                            cantidad = "",
                            precio = "";
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
                                decoration: InputDecoration(
                                  hintText: "Descripción",
                                ),
                                onChanged: (value) => descripcion = value,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Cantidad",
                                ),
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
                              onPressed: () {
                                setState(() {
                                  productos.add(
                                    inventarioProducto(
                                      id: productos.length + 1,
                                      nombre: nombre,
                                      descripcion: descripcion,
                                      cantidad: int.parse(cantidad),
                                      precio: double.parse(precio),
                                    ),
                                  );
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Agregar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Agregar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedRow == null
                          ? null
                          : () {
                            final producto = productos.firstWhere(
                              (p) => p.id == selectedRow,
                            );
                            String nombre = producto.nombre;
                            String descripcion = producto.descripcion;
                            String cantidad = producto.cantidad.toString();
                            String precio = producto.precio.toStringAsFixed(2);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Editar Producto"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "Nombre",
                                        ),
                                        controller: TextEditingController(
                                          text: nombre,
                                        ),
                                        onChanged: (value) => nombre = value,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "Descripción",
                                        ),
                                        controller: TextEditingController(
                                          text: descripcion,
                                        ),
                                        onChanged:
                                            (value) => descripcion = value,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "Cantidad",
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: TextEditingController(
                                          text: cantidad,
                                        ),
                                        onChanged: (value) => cantidad = value,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "Precio",
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: TextEditingController(
                                          text: precio,
                                        ),
                                        onChanged: (value) => precio = value,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          final index = productos.indexWhere(
                                            (p) => p.id == selectedRow,
                                          );
                                          productos[index] = inventarioProducto(
                                            id: productos[index].id,
                                            nombre: nombre,
                                            descripcion: descripcion,
                                            cantidad: int.parse(cantidad),
                                            precio: double.parse(precio),
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("Editar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                  child: Text("Editar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      selectedRow == null
                          ? null
                          : () {
                            setState(() {
                              productos.removeWhere((p) => p.id == selectedRow);
                              selectedRow = null;
                            });
                          },
                  child: Text("Eliminar Producto"),
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 50)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
