<?php
define("PGUSER", "alumnodb");
define("PGPASSWORD", "alumnodb");
define("DSN","pgsql:host=localhost;dbname=si1;options='--client_encoding=UTF8'");
?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<HTML> 
  <HEAD> 
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=utf-8"> 
    <TITLE>Ejemplo de SQL injection</TITLE> 
  </HEAD> 

  <BODY>
    <h2> Ejemplo de SQL injection: Login</h2>

    <form name="entrada" method="post" action="xLoginInjection.php">
      <table>
      <tr><td>Nombre:</td><td><input type="text" name="login" value="gatsby"></td></tr>
      <tr><td>Contraseña:</td><td><input type="text" name="pswd"></td></tr>
      </table>
      <input type="submit" value="logon"/>
    </form>

    <h3>Resultado</h3>

  <?php

    $login=$_POST["login"];
    $pswd =$_POST["pswd"];

    if (isset($login) && isset($pswd)) {
      try {
        $conn = new PDO(DSN,PGUSER,PGPASSWORD);
        $query="select * from customers where username='".$login."' and password='".$pswd."'";
        // echo "<p> $query </p>";
        $st = $conn->prepare($query);
        if ($st === FALSE) {
          echo "Error en la query: $query";
          $rc=FALSE;
        } else {
          $rc=$st->execute();
        }
        if ($rc === TRUE) {
          $resultado = $st->fetchAll();
        }
        if (isset($resultado) && count($resultado) > 0) {
          echo "<p>Login correcto</p>";
          echo "<ol>";
          foreach ($resultado as $customer) {
            echo "<li>First Name: ".$customer["firstname"]."<br>Last Name: ".$customer["lastname"]."</li>";
          }
          echo "</ol>";
        } else {
          echo "<p>Login inválido</p>";
        }
      } catch (PDOException $e) {
        print "Error!: " . $e->getMessage() . "<br/>";
      }

      $conn = null;
    }

  ?>

  </BODY>
</HTML>
