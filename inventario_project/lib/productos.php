<?php
include 'conexion.php';

// Obtener todos los productos
if($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'obtener'){
    $sql = "SELECT * FROM productos";
    $resultado = $conexion->query($sql);
    
    $productos = array();
    while($fila = $resultado->fetch_assoc()){
        $productos[] = $fila;
    }
    
    echo json_encode($productos);
    exit;
}

// Agregar producto
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'agregar'){
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $descripcion = $conexion->real_escape_string($_POST['descripcion']);
    $precio = $conexion->real_escape_string($_POST['precio']);
    $cantidad = $conexion->real_escape_string($_POST['cantidad']);
    $categoria = $conexion->real_escape_string($_POST['categoria']);
    
    $sql = "INSERT INTO productos (nombre, descripcion, precio, cantidad, categoria) 
            VALUES ('$nombre', '$descripcion', $precio, $cantidad, '$categoria')";
    
    if($conexion->query($sql)){
        echo json_encode(array('success' => true, 'mensaje' => 'Producto agregado con éxito'));
    } else {
        echo json_encode(array('success' => false, 'mensaje' => 'Error al agregar producto: ' . $conexion->error));
    }
    exit;
}

// Actualizar producto
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'actualizar'){
    $id = $conexion->real_escape_string($_POST['id']);
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $descripcion = $conexion->real_escape_string($_POST['descripcion']);
    $precio = $conexion->real_escape_string($_POST['precio']);
    $cantidad = $conexion->real_escape_string($_POST['cantidad']);
    $categoria = $conexion->real_escape_string($_POST['categoria']);
    
    $sql = "UPDATE productos SET 
            nombre = '$nombre', 
            descripcion = '$descripcion', 
            precio = $precio, 
            cantidad = $cantidad, 
            categoria = '$categoria' 
            WHERE id = $id";
    
    if($conexion->query($sql)){
        echo json_encode(array('success' => true, 'mensaje' => 'Producto actualizado con éxito'));
    } else {
        echo json_encode(array('success' => false, 'mensaje' => 'Error al actualizar producto: ' . $conexion->error));
    }
    exit;
}

// Eliminar producto
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'eliminar'){
    $id = $conexion->real_escape_string($_POST['id']);
    
    $sql = "DELETE FROM productos WHERE id = $id";
    
    if($conexion->query($sql)){
        echo json_encode(array('success' => true, 'mensaje' => 'Producto eliminado con éxito'));
    } else {
        echo json_encode(array('success' => false, 'mensaje' => 'Error al eliminar producto: ' . $conexion->error));
    }
    exit;
}

// Buscar producto
if($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'buscar'){
    $termino = $conexion->real_escape_string($_GET['termino']);
    
    $sql = "SELECT * FROM productos WHERE 
            nombre LIKE '%$termino%' OR 
            descripcion LIKE '%$termino%' OR 
            categoria LIKE '%$termino%'";
    
    $resultado = $conexion->query($sql);
    
    $productos = array();
    while($fila = $resultado->fetch_assoc()){
        $productos[] = $fila;
    }
    
    echo json_encode($productos);
    exit;
}

$conexion->close();
?>