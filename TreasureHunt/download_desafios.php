<?php
ob_start();
@session_start();

if (!isset($_SESSION['usuario']) == true) {
	unset($_SESSION['usuario']);
	header('location:index.php');
}

$usuario = $_SESSION['usuario'];
$arquivo = "Desafios/Jogador" . $usuario . ".zip";

if (file_exists($arquivo)) {
    $nome_arquivo = basename($arquivo);
    
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="' . $nome_arquivo . '"');
    header('Content-Length: ' . filesize($arquivo));
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Expires: 0');
    
    readfile($arquivo);
    exit;
} else {
    // If the file doesn't exist, display an error
    echo "O arquivo não existe.";
}
?>
