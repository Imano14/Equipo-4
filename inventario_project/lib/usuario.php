<?php
include 'conexion.php';

// Login
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'login'){
    $usuario = $conexion->real_escape_string($_POST['usuario']);
    $contraseña = $conexion->real_escape_string($_POST['contraseña']);
    
    $sql = "SELECT * FROM usuarios WHERE usuario = '$usuario'";
    $resultado = $conexion->query($sql);
    
    if($resultado->num_rows > 0){
        $usuario = $resultado->fetch_assoc();
        if(password_verify($contraseña, $usuario['contraseña'])){
            echo json_encode(array('success' => true, 'mensaje' => 'Login exitoso', 'usuario' => $usuario));
        } else {
            echo json_encode(array('success' => false, 'mensaje' => 'Contraseña incorrecta'));
        }
    } else {
        echo json_encode(array('success' => false, 'mensaje' => 'Usuario no encontrado'));
    }
    exit;
}

// Registro
if($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'registro'){
    $nombre = $conexion->real_escape_string($_POST['nombre']);
    $usuario = $conexion->real_escape_string($_POST['usuario']);
    $contraseña = password_hash($conexion->real_escape_string($_POST['contraseña']), PASSWORD_DEFAULT);
    $correo = $conexion->real_escape_string($_POST['correo']);
    $telefono = $conexion->real_escape_string($_POST['telefono']);
    
    $sql = "INSERT INTO usuarios (nombre, usuario, contraseña, correo, telefono) 
            VALUES ('$nombre', '$usuario', '$contraseña', '$correo', '$telefono')";
    
    if($conexion->query($sql)){
        echo json_encode(array('success' => true, 'mensaje' => 'Usuario registrado con éxito'));
    } else {
        echo json_encode(array('success' => false, 'mensaje' => 'Error al registrar usuario: ' . $conexion->error));
    }
    exit;
}

$conexion->close();
?>