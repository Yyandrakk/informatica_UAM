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

    try {
      $dbh = new PDO("pgsql:dbname=si1 host=localhost", "alumnodb", "alumnodb" );
    }
    catch(PDOException $e)
    {
      echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
    }
    $write="<aside><nav id=\"Barra\"><ul>";
    $barra = $dbh->prepare("SELECT category FROM bets WHERE winneropt IS NULL GROUP BY category");
    $barra->execute();
    $result = $barra->fetchAll();
    foreach ($result as $row) {
      $write.="<li><a href=\"javascript:mostrarOcultar('".$row["category"]."');\"> ".$row["category"]."</a> </li>";
    }
    $write.=  "</ul></nav></aside>";
    echo $write;





          if(isset($_REQUEST['Ir'])){
            $busqueda="";
            //Es como strtok, divide la variable en dos tokens
            $rango = explode(' - ', $_POST['rango']);
            //Lo paso a int
            $rango[0]=0+$rango[0];
             $rango[1]=0+$rango[1];

            if($_REQUEST['categorias']=="Todas"){
              if(empty($_REQUEST['Buscar'])==true){
              $query= $dbh->prepare("SELECT * FROM bets NATURAL JOIN optionbet NATURAL JOIN options WHERE winneropt IS NULL AND ratio>=:minimo AND ratio <=:maximo ORDER BY category,betid");
              $query->bindParam(':minimo', $rango[0], PDO::PARAM_INT);
              $query->bindParam(':maximo',  $rango[1], PDO::PARAM_INT);
              }else{
                $query= $dbh->prepare("SELECT * FROM bets NATURAL JOIN optionbet NATURAL JOIN options WHERE winneropt IS NULL AND ratio>=:minimo AND ratio <=:maximo AND lower(betdesc) LIKE :buscar ORDER BY category,betid");
                $busqueda=strtolower($_REQUEST['Buscar']);
                $busqueda="%".$busqueda."%";
                $query->bindParam(':buscar', $busqueda, PDO::PARAM_STR);
                $query->bindParam(':minimo', $rango[0], PDO::PARAM_INT);
                $query->bindParam(':maximo',  $rango[1], PDO::PARAM_INT);
              }
            }else{
              if(empty($_REQUEST['Buscar'])==true){
                $query= $dbh->prepare("SELECT * FROM bets NATURAL JOIN optionbet NATURAL JOIN options WHERE winneropt IS NULL AND category=:categoria AND ratio>=:minimo AND ratio <=:maximo ORDER BY category,betid");
                $query->bindParam(':minimo', $rango[0], PDO::PARAM_INT);
                $query->bindParam(':maximo',  $rango[1], PDO::PARAM_INT);
                $query->bindParam(':categoria', $_REQUEST['categorias'] ,PDO::PARAM_STR);
              }else{
                $query= $dbh->prepare("SELECT * FROM bets NATURAL JOIN optionbet NATURAL JOIN options WHERE winneropt IS NULL AND category=:categoria AND ratio>=:minimo AND ratio <=:maximo AND lower(betdesc) LIKE :buscar ORDER BY category,betid");
                $busqueda=strtolower($_REQUEST['Buscar']);
                $busqueda="%".$busqueda."%";
                $query->bindParam(':categoria', $_REQUEST['categorias'], PDO::PARAM_STR);
                $query->bindParam(':buscar', $busqueda, PDO::PARAM_STR);
                $query->bindParam(':minimo', $rango[0], PDO::PARAM_INT);
                $query->bindParam(':maximo',  $rango[1], PDO::PARAM_INT);
              }
            }
            $query->execute();
             $aux="";
             $auxId=-1;
             $cierre=0;
              $cerrado=1;
             $result = $query->fetchAll();
             foreach ($result as $row) {
               if(strcmp($aux, $row["category"])!=0 ){

                 if($cierre!=0){
                   echo "</table>";
                   echo "<input type=\"submit\" value=\"Apostar\" />";
                   echo "</form>";
                   echo "</article>";
                   echo "</section>";
                   $cerrado=1;
                 }
                 echo "<section id=\"".$row["category"]."\">";
                 echo "<h1>" .$row["category"]."</h1>";

                 $aux=$row["category"];
                 $cierre=1;
               }
               if($auxId!=$row["betid"]){
                 if($auxId!=-1 and $cerrado==0){
                      echo "</table>";
                      echo "<input type=\"submit\" value=\"Apostar\" />";
                      echo "</form>";
                      echo "</article>";
                    }
                 echo "<article>";
                 echo "<form  action=\"apuesta.php\" method=\"post\">";
                 echo "<input type=\"hidden\" name=\"id\" value=\"".$row["betid"]."\">";
                 echo "<h3>" .$row["betdesc"]."</h3>";
                 echo "<p>" .$row["betcloses"] ."</p>";
                 echo "<table>";
                $auxId=$row["betid"];
                $cerrado=0;
               }
                   echo "<tr><td>".$row["optiondesc"]. "</td><td>" .$row["ratio"]. "</td></tr>";
             }

             $dbh=null;
             echo "</section>";


          /*	$xml=simplexml_load_file("apuestas.xml");

              //Recoremos todo el xml
        		foreach($xml->deporte as $apuestas){
              //Miramos si quiere todos los deportes o solo algunos especificos
              if($_REQUEST['categorias']=="Todas" or $_REQUEST['categorias']==$apuestas->titulo ){

            			$partidos=$apuestas->partidos;
                   $bus="";
                   //flag para saber si ha entrado en algun partido
                   $write=0;
                			foreach($partidos->partido as $partido){
                        //Si el campo esta vacio solo miramos el rango, si no miramos que si contiene la cadena de buscar y esta entre los rangos
          if ((empty($_REQUEST['Buscar'])==true and (((0+$partido->gana1)>=$rango[0] and(0+$partido->gana1)<=$rango[1])or ($partido->empata>=$rango[0] and $partido->empata<=$rango[1])or($partido->gana2>=$rango[0] and $partido->gana2<=$rango[1])))
          or (empty($_REQUEST['Buscar'])==false and false!==stripos( $partido->equipo1,$_REQUEST['Buscar']) and (0+$partido->gana1)>=$rango[0] and(0+$partido->gana1)<=$rango[1])
          or (empty($_REQUEST['Buscar'])==false and false!==stripos( $partido->equipo2,$_REQUEST['Buscar']) and (0+$partido->gana2)>=$rango[0] and (0+$partido->gana2)<=$rango[1] ))
                            {

                                $bus=$bus."<article>";
                                $bus=$bus."<form  action=\"apuesta.php\" method=\"post\">";
                                $bus=$bus."<input type=\"hidden\" name=\"id\" value=\"".$partido->id."\">";
                        				$bus=$bus."<h3>" .$partido->equipo1. '-' .$partido->equipo2."</h3>";
                        				$bus=$bus."<p>" .$partido->fecha ."</p>";
                        				$bus=$bus."<table>";
                        				$bus=$bus."<tr><td>".$partido->equipo1. "</td><td>" .$partido->gana1. "</td></tr>";
                                if((0+$partido->empata)!=-1){
                                  	$bus.="<tr><td> X </td><td>" .$partido->empata. "</td></tr>";
                                }
                        				$bus=$bus."<tr><td>".$partido->equipo2. "</td><td>" .$partido->gana2. "</td></tr>";
                        				$bus=$bus."</table>";
                        				$bus=$bus."<input type=\"submit\" value=\"Apostar\" />";
                                $bus=$bus."</form>";
                        				$bus=$bus."</article>";
                                $write=1;
                          }
                			}
                      if($write==1){
                        $busqueda=$busqueda."<section id=\"" .$apuestas->titulo ."\">";
                    			$busqueda=$busqueda."<h1>" .$apuestas->titulo ."</h1>";
                          $busqueda=$busqueda.$bus;
                          $busqueda=$busqueda."</section>";

                      }

                                    }
            		}
            echo $busqueda;*/
        }else{
          //si recarga la pagina evita que de error
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
