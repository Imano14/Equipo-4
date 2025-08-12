<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$servidor = "localhost";
$usuario = "root";
$password = "";
$basedatos = "inventario_tienda";

$conexion = new mysqli($servidor, $usuario, $password, $basedatos);

if($conexion->connect_error){
    die("Error de conexión: " . $conexion->connect_error);
}
?>