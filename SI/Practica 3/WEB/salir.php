<?php
function crear_cookie($valor){
  setcookie("lastuser",$valor,time()+(60*60*24*100),"/");
}
?>
<?php
session_start();
crear_cookie($_SESSION["login"]);
//creamos la cookie que tenga el nombre de usuario y de tiempo le damos 100 dias (60 segundos *60 minutos * 24 horas * 100 dias)
//  con / le indicamos que valga para todo el dominio
unset($_SESSION["login"]);
unset($_SESSION["name"]);
unset($_SESSION["id_client"]);
header('Location: index.php');
?>
