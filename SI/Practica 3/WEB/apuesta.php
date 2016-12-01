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
        if(isset($_REQUEST['id'])){
          $apuestaid=$_REQUEST['id'];
          $apuestaid=0+$apuestaid;
          try {
            $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );

          }
          catch(PDOException $e)
          {
            echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
          }

          $query = $dbh->prepare("SELECT * FROM bets WHERE betid = :id");
          $query->bindParam(':id', $apuestaid, PDO::PARAM_INT);
          $query->execute();
          $result = $query->fetchAll();
          $write="";
          foreach($result as $row) {
            $equipos = explode('-', $row["betdesc"]);
            $write.="<section id=\"apuesta\">";
            $write.="<h1>Detalle de la apuesta</h1>";
            $write.="<article>";
            $write.="<h3>".$row["betdesc"]."</h3>";
            $write.= "<p>" .$row["betcloses"] ."</p>";
            $write.="<form action =\"carrito.php\" autocomplete=\"on\" method=\"post\">";
            $write.="<input type=\"hidden\" name=\"id\" value=\"".$row["betid"]."\">";
            $write.="<table>";
            $write.="<tr><th>Apuesta</th><th>Porcentaje</th></tr>";
            $query = $dbh->prepare("SELECT ratio,optiondesc,optionid FROM optionbet NATURAL JOIN options WHERE betid = :id");
            $query->bindParam(':id', $apuestaid, PDO::PARAM_INT);
            $query->execute();
            $result2 = $query->fetchAll();
            $primero="";
            $segundo="";
            $empate="";

            foreach($result2 as $row) {
              if(strnatcasecmp ($equipos[0] , $row["optiondesc"] )==0){
                $primero=$row["ratio"];
                $primeroId=$row["optionid"];
              }elseif (strnatcasecmp ("Empate" , $row["optiondesc"] )==0) {
                $empate=$row["ratio"];
                $empateId=$row["optionid"];
              }elseif(strnatcasecmp ($equipos[1] , $row["optiondesc"] )==0) {
                $segundo=$row["ratio"];
                $segundoId=$row["optionid"];
              }
            }
            $write.="<tr><td> <input type=\"radio\" name=\"partido\" value=\"".$primeroId."\" checked>".$equipos[0]."</td><td>".$primero."</td></tr>";
            if(empty($empate)==FALSE){
                $write.="<tr><td> <input type=\"radio\" name=\"partido\" value=\".$empateId.\" checked> X </td><td>".$empate."</td></tr>";
            }
            $write.="<tr><td> <input type=\"radio\" name=\"partido\" value=\"".$segundoId."\" checked>".$equipos[1]."</td><td>".$segundo."</td></tr>";
              $write.="</table>";
            $write.="Apuesta:<input type=\"text\" name=\"dinero\" pattern=\"([0-9]+[.]?[0-9]+)|([1-9][0-9]*)\" required>";
            $write.="<input type=\"submit\" name=\"Apostar\" value=\"Apostar\">";
            $write.="</form>";
          }
          echo $write;
          $dbh = null;






          /*
          $xml=simplexml_load_file("apuestas.xml");
          foreach($xml->deporte as $apuestas){
            $partidos=$apuestas->partidos;
            $salir=0;
            foreach($partidos->partido as $partido){
              if($partido->id==$apuestaid){
                echo "<section id=\"apuesta\">";
                echo "<h1>Detalle de la apuesta</h1>";
                echo "<article>";
                echo "<h3>" .$partido->equipo1. "-" .$partido->equipo2."</h3>";
                echo "<p>" .$partido->fecha ."</p>";
                echo "<form action =\"carrito.php\" autocomplete=\"on\" method=\"post\">";
                echo "<input type=\"hidden\" name=\"id\" value=\"".$partido->id."\">";
                echo "<table>";
                echo "<tr><th>Apuesta</th><th>Porcentaje</th></tr>";
        				echo "<tr><td> <input type=\"radio\" name=\"partido\" value=\"".$partido->equipo1."\" checked>".$partido->equipo1."</td><td>".$partido->gana1."</td></tr>";
                if((0+$partido->empata)!=-1){
                  echo "<tr><td> <input type=\"radio\" name=\"partido\" value=\"empate\" checked> X </td><td>".$partido->empata."</td></tr>";
                }
        				echo "<tr><td> <input type=\"radio\" name=\"partido\" value=\"".$partido->equipo2."\" checked>".$partido->equipo2."</td><td>".$partido->gana2."</td></tr>";
        				echo "</table>";
                echo "Apuesta:<input type=\"text\" name=\"dinero\" pattern=\"([0-9]+[.]?[0-9]+)|([1-9][0-9]*)\" required>";
                echo "<input type=\"submit\" name=\"Apostar\" value=\"Apostar\">";
                echo "</form>";
                $salir=1;
                break;
                }

              }
              if($salir==1){
                break;
              }
            }
            */
        }else{
          //si ha recargado la pagina esto le devuelve a la pagina de registro
        header('Location: index.php');
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
