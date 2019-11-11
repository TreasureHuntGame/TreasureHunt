<?php

// Conexão com o BD
define('HOST', 'localhost');
define('USER', 'root');
//define('PASS', 'minhaSenha');
define('DB_NAME', 'TreasureHunt');

TRY {
    //$conexao = new PDO('mysql:host=' . HOST . ';dbname=' . DB_NAME, USER, PASS);
    $conexao = new PDO('mysql:host=' . HOST . ';dbname=' . DB_NAME, USER);
    $conexao->exec("set names utf8");
} CATCH (PDOException $e) {
    echo 'Erro ao conectar com MySQL: ' . $e->getMessage();
}

?>