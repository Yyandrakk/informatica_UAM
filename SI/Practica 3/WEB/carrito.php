<?php
/**
* @return bool
*/
function is_session_started()
{
    if ( php_sapi_name() !== 'cli' ) {
        if ( version_compare(phpversion(), '5.4.0', '>=') ) {
            return session_status() === PHP_SESSION_ACTIVE ? TRUE : FALSE;
        } else {
            return session_id() === '' ? FALSE : TRUE;
        }
    }
    return FALSE;
}

// Example
if ( is_session_started() === FALSE ) session_start();
?>

<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Pagina principal">
        <title>Apuestas Deportivas</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="jquery-ui-1.11.4/jquery-ui.min.css">
        <script src="jquery-ui-1.11.4/external/jquery/jquery.js"></script>
        <script src="jquery-ui-1.11.4/jquery-ui.min.js"></script>
        <script src="funciones.js"></script>
    <script>
      $(function() {
        $( "#slider-range" ).slider({
          range: true,
          min: 1.0,
          max: 20.0,
          values: [ 1.0, 20.0 ],
          step: 0.1,
          slide: function( event, ui ) {
            $( "#amount" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
          }
        });
        $("#slider-range").css("width","45%")
        $( "#amount" ).val( $( "#slider-range" ).slider( "values", 0 ) +
        " - " + $( "#slider-range" ).slider( "values", 1 ) );
      });
</script>

    </head>
    <body>
      <?php
      if(isset($_SESSION["name"])){
        echo "<header id=\"cabecera\">
            <p id=\"user\">Se ha registrado como ".$_SESSION["name"]."</p>
            <a id=\"logo\" href=\"index.php\">
                <span class=\"site-name\"> Apuestas Deportivas </span>
                <span class=\"site-desc\"> La página líder en apuestas mundial</span>
            </a>
            <form  action=\"buscar.php\" method=\"post\">
            <select name=\"categorias\">
            <option value=\"Todas\" >Todas</option>";
            try {
              $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
            }
            catch(PDOException $e)
            {
              echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
            }
            $barra = $dbh->prepare("SELECT category FROM bets WHERE winneropt IS NULL GROUP BY category");
            $barra->execute();
            $result = $barra->fetchAll();
            foreach ($result as $row) {
            echo"  <option value=\"".$row["category"]."\" >".$row["category"]."</option>";
            }
            $dbh=null;
          echo"</select>
                <label for=\"amount\">Price range:</label>
                  <input type=\"text\" id=\"amount\" name=\"rango\" readonly>
                <div id=\"slider-range\"></div>
                <input type=\"search\" id=\"Buscar\" name=\"Buscar\" placeholder=\"Buscar\" />
                <input type=\"submit\" value=\"Ir\" name=\"Ir\" />


            </form>
            <nav>
                <ul>
                    <li><a href=\"login.php\"> Autentificarse </a> </li>
                    <li><a href=\"registro.php\"> Registrarse </a> </li>
                    <li><a href=\"carrito.php\"> Carrito</a> </li>
                </ul>
            </nav>

        </header>";

      }else{
        echo"<header id=\"cabecera\">
            <a id=\"logo\" href=\"index.php\">
                <span class=\"site-name\"> Apuestas Deportivas </span>
                <span class=\"site-desc\"> La página líder en apuestas mundial</span>
            </a>
            <form  action=\"buscar.php\" method=\"post\">
            <select name=\"categorias\">
            <option value=\"Todas\" >Todas</option>";
            try {
              $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
            }
            catch(PDOException $e)
            {
              echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
            }
            $barra = $dbh->prepare("SELECT category FROM bets WHERE winneropt IS NULL GROUP BY category");
            $barra->execute();
            $result = $barra->fetchAll();
            foreach ($result as $row) {
            echo"  <option value=\"".$row["category"]."\" >".$row["category"]."</option>";
            }
            $dbh=null;
          echo"</select>
                <label for=\"amount\">Price range:</label>
                  <input type=\"text\" id=\"amount\" name=\"rango\" readonly>
                <div id=\"slider-range\"></div>
                <input type=\"search\" id=\"Buscar\" name=\"Buscar\" placeholder=\"Buscar\" />
                <input type=\"submit\" value=\"Ir\" name=\"Ir\" />


            </form>
            <nav>
                <ul>
                    <li><a href=\"login.php\"> Autentificarse </a> </li>
                    <li><a href=\"registro.php\"> Registrarse </a> </li>
										<li><a href=\"carrito.php\"> Carrito</a> </li>
                </ul>
            </nav>

        </header>";
      }


       ?>
        <?php
if(isset($_SESSION["name"])){


if(isset($_REQUEST['procesar'])){
  try {
    $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
  }
  catch(PDOException $e)
  {
    echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
  }
  $query = $dbh->prepare("SELECT orderid,totalamount FROM clientorders WHERE date IS NULL AND  customerid =:id");
  $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
  $query->execute();
  $result = $query->fetchAll();
  foreach ($result as $row) {
    $bet = $dbh->prepare("SELECT credit FROM customers WHERE customerid =:id");
    $bet->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
    $bet->execute();
    $saldo = $bet->fetchAll();
    foreach ($saldo as $row2) {
          if($row2["credit"]<$row["totalamount"]){

            echo "<script type=\"text/javascript\">alert(\"No tienes suficiente saldo, elimina apuestas o aumenta tu saldo.\"); </script>";
          }else{

            $dinero=$row2["credit"]-$row["totalamount"];

            $cambio = $dbh->prepare("UPDATE clientorders SET date=now() WHERE orderid=:orderid");
            $cambio->bindParam(':orderid', $row["orderid"], PDO::PARAM_INT);
            $cambio->execute();
          }
    }

  }
  $dbh=null;


  /*
    if(isset($_SESSION["name"])){
      $ruta="./usuarios/".$_SESSION["name"]."/historial.xml";
      $historial =  simplexml_load_file($ruta,'SimpleXMLElement');
      $dinero=0;
      foreach ($_SESSION['carrito'] as $elemento) {
        $partido = $historial->addChild('partido');
        $partido->addChild('id',$elemento['id']);
        $partido->addChild('fecha',$elemento['fecha']);
        $partido->addChild('apuesta',$elemento['apuesta']);
        $partido->addChild('dinero',$elemento['dinero']);
        $dinero+=0+$elemento['dinero'];
      }
      $datos="./usuarios/".$_SESSION["name"]."/datos.dat";
      $usuario = simplexml_load_file($datos,"SimpleXMLElement");

      if($dinero<=(0+$usuario->saldo)){
          $usuario->saldo=(string)(0+$usuario->saldo)-$dinero;
           $usuario->asXML($datos);
           $historial->asXML($ruta);
          unset($_SESSION["carrito"]);
      }else{
          echo "<script type=\"text/javascript\">alert(\"No tienes suficiente saldo, elimina apuestas o aumenta tu saldo.\"); </script>";
      }
    }else{
      echo "<script type=\"text/javascript\">alert(\"No esta logueado en el sistema, hagalo primero.\"); window.location.href='login.php';</script>";
    }
*/
}
if(isset($_REQUEST['eliminar'])){
  try {
    $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
  }
  catch(PDOException $e)
  {
    echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
  }
  $query = $dbh->prepare("SELECT orderid FROM clientorders WHERE date IS NULL AND  customerid =:id");
  $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
  $query->execute();
  $result = $query->fetchAll();
  foreach ($result as $row) {
    $delete = $dbh->prepare("DELETE FROM clientbets WHERE orderid=:orderid AND betid=:betid");
    $delete->bindParam(':orderid', $row["orderid"], PDO::PARAM_INT);
    $delete->bindParam(':betid', $_REQUEST['id'], PDO::PARAM_INT);
    $delete->execute();
  }
$dbh=null;
  /*
          $carrito=$_SESSION["carrito"];
          for($i=0;$i< count($carrito);$i++){
            if($carrito[$i]['id']==$_REQUEST['id']){
              $indice=$i;
              break;
            }
          }
          unset($carrito[$indice]);
          $_SESSION["carrito"]=$carrito;*/
        }
if(isset($_REQUEST['cambiar'])){
  try {
    $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
  }
  catch(PDOException $e)
  {
    echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
  }
  $query = $dbh->prepare("SELECT orderid FROM clientorders WHERE date IS NULL AND  customerid =:id");
  $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
  $query->execute();
  $result = $query->fetchAll();
  foreach ($result as $row) {
    $cambio = $dbh->prepare("UPDATE clientbets SET bet=:dinero WHERE orderid=:orderid AND betid=:betid");
    $cambio->bindParam(':orderid', $row["orderid"], PDO::PARAM_INT);
    $cambio->bindParam(':betid', $_REQUEST['id'], PDO::PARAM_INT);
    $cambio->bindParam(':dinero', $_REQUEST['saldo'], PDO::PARAM_INT);
    $cambio->execute();
  }
$dbh=null;
  /*



                  /*$carrito=$_SESSION["carrito"];
                  for($i=0;$i< count($carrito);$i++){
                    if($carrito[$i]['id']==$_REQUEST['id']){
                      $indice=$i;
                      break;
                    }
                  }
                $carrito[$indice]['dinero']=$_REQUEST['saldo'];
                  $_SESSION["carrito"]=$carrito;
                */}
if(isset($_REQUEST['Apostar'])){

    try {
      $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
    }
    catch(PDOException $e)
    {
      echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
    }
    $query = $dbh->prepare("SELECT orderid FROM clientorders WHERE date IS NULL AND  customerid =:id");
    $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
    $query->execute();
    if($query->rowCount()==0){
      $insert = $dbh->prepare("INSERT INTO clientorders (customerid) VALUES (:id)");
      $insert->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
      $insert->execute();
      $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
      $query->execute();

    }
        $result = $query->fetchAll();
        foreach ($result as $row) {
          $control = $dbh->prepare("SELECT * FROM clientbets WHERE orderid=:orderid AND betid=:betid");
          $control->bindParam(':orderid',$row["orderid"], PDO::PARAM_INT);
          $control->bindParam(':betid', $_REQUEST['id'], PDO::PARAM_INT);
          $control->execute();
            if($control->rowCount()!=0){
              $dbh = null;
              echo "<script type=\"text/javascript\">alert(\"No puedes realizar dos veces por el mismo partido \");</script>";
            }else{
              $insert = $dbh->prepare("INSERT INTO clientbets (orderid,betid,optionid,bet,ratio) VALUES (:idorder,:betid,:optionid,:bet,:ratio)");
              $insert->bindParam(':idorder',$row["orderid"], PDO::PARAM_INT);
              $insert->bindParam(':betid', $_REQUEST['id'], PDO::PARAM_INT);
              $insert->bindParam(':optionid',$_REQUEST['partido'], PDO::PARAM_INT);
              $insert->bindParam(':bet',$_REQUEST['dinero'],PDO::PARAM_INT);
              $qRatio = $dbh->prepare("SELECT ratio FROM optionbet WHERE optionid=:optionid AND betid=:betid");
              $qRatio->bindParam(':optionid',$_REQUEST['partido'], PDO::PARAM_INT);
              $qRatio->bindParam(':betid',$_REQUEST['id'],PDO::PARAM_INT);
              $qRatio->execute();
              $resultRatio = $qRatio->fetchAll();
              foreach ($resultRatio as $row2) {
                  $insert->bindParam(':ratio',$row2["ratio"],PDO::PARAM_INT);
              }
              $insert->execute();
            }

        }
        $dbh = null;
}/*
        $apuesta=array("id"=>$_REQUEST['id'],"fecha"=>date("d/m/y"),"apuesta"=>$_REQUEST['partido'],"dinero"=>$_REQUEST['dinero']);
        try {
          $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
        }
        catch(PDOException $e)
        {
          echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
        }
        $query = $dbh->prepare("SELECT optiondesc FROM  options where  optionid = :id");
        if(!isset($_SESSION["carrito"])){
            $_SESSION["carrito"]= array($apuesta);
          }else{
            $yaAposto=false;
            foreach ($_SESSION['carrito'] as $elemento) {
              if($elemento['id']==$_REQUEST['id']){
                $yaAposto=true;
                break;
              }
            }
            if($yaAposto==false){

                $_SESSION["carrito"][]=$apuesta;
            }
            else{
              echo "<script type=\"text/javascript\">alert(\"No puede apostar al mismo partido\");</script>";
            }

          }

*/

  $imprimir="<section class=\"sinBarra\"><h1>Tus apuestas</h1>";

  try {
    $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
  }
  catch(PDOException $e)
  {
    echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
  }
  $query = $dbh->prepare("SELECT betid,optiondesc,bet FROM  clientbets NATURAL JOIN options WHERE  orderid IN (SELECT orderid FROM clientorders WHERE date IS NULL AND  customerid =:id)");
  $query->bindParam(':id', $_SESSION["id_client"], PDO::PARAM_INT);
  $query->execute();

if($query->rowCount()==0){
  $imprimir=$imprimir."<p>Carrito vacio</p></section>";
}
else{
    $result = $query->fetchAll();
    foreach ($result as $row){
      $write="<form  action=\"carrito.php\" id=\"".$row["betid"]."\" method=\"post\"><table><tr><th>Apostado</th><th>Dinero</th><th>Acciones</th></tr>";
      $write=$write."<input type=\"hidden\" name=\"id\" value=\"".$row["betid"]."\">";
      $write=$write."<tr><td>".$row["optiondesc"]."</td><td><input type=\"text\" name=\"saldo\" value=\"".$row["bet"]."\" pattern=\"([0-9]+[.]?[0-9]+)|([1-9][0-9]*)\" readonly></td>
      <td> <input type=\"button\" onClick=\"javascript:activar(".$row["betid"].");\"   name=\"modificar\" value=\"modificar\" /> <input type=\"submit\" name=\"cambiar\"  class=\"cambiar\" value=\"modificar\" /> <input type=\"submit\" name=\"eliminar\" value=\"eliminar\" /></td></tr>";
      $write=$write."</table></form>";
    $imprimir=$imprimir.$write;
    }
    $imprimir=$imprimir."<form  action=\"carrito.php\"  method=\"post\"><p><input type=\"submit\" name=\"procesar\" value=\"Procesar carrito\" /></p></form></section><";


}
  echo $imprimir;
  $dbh = null;

}
else{
  echo "<script type=\"text/javascript\">alert(\"No esta logueado en el sistema, hagalo primero.\"); window.location.href='login.php';</script>";

}
      	?>
        <footer>
            <nav>
                <ul>
                    <li><a href="mailto:pagina.apuestas@apuestas.com"> Contacto</a> </li>
                    <script type="text/javascript">
                      setInterval(cargarFechayUsuarios,1000);
                    </script>
                    <li><span id="fecha"></span> </li>
                    <li><span id="usuarios"></span></li>
                </ul>
            </nav>
        </footer>
    </body>

</html>
