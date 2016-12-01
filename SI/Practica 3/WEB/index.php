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
    /*    <aside>
            <nav id="Barra">
                <ul>
                    <li><a href="javascript:mostrarOcultar(0);"> Fútbol</a> </li>
                    <li><a href="javascript:mostrarOcultar(1);"> Baloncesto </a> </li>
                    <li><a href="javascript:mostrarOcultar(2);"> Tenis </a> </li>
                    <li><a href="javascript:mostrarOcultar(3);"> Balonmano </a> </li>
                </ul>
            </nav>
        </aside>
    */
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
    $dbh=null;


			try
			{
				$db=  pg_connect("host=localhost dbname=si1 user=alumnodb password=alumnodb");
			}
			catch(Exception $e)
			{
      			echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
			}

			$resultado = pg_query($db, 'SELECT * FROM bets WHERE winneropt IS NULL ORDER BY category');
			$aux="";
			$cierre=0;
			while($row=pg_fetch_row($resultado)){

				if(strcmp($aux, $row[2])!=0 ){
					if($cierre!=0){
						echo "</section>";

					}
					echo "<section id=\"" .$row[2]."\">";
					echo "<h1>" .$row[2]. "</h1>";

					$aux=$row[2];
					$cierre=1;
				}

				echo "<article>";
				echo "<form  action=\"apuesta.php\" method=\"post\">";
              	echo "<input type=\"hidden\" name=\"id\" value=\"".$row[0]."\">";
      			echo "<h3>" .$row[3]."</h3>";
      			echo "<p>" .$row[1] ."</p>";
				echo "<table>";
				$equipoap=explode('-', $row[3]);
				$ratio = pg_query_params($db, 'SELECT * FROM optionbet WHERE betid=$1', array($row[0]));
				while($rowRatio=pg_fetch_row($ratio)){
					$ratioGana = pg_query_params($db, 'SELECT * FROM options WHERE optionid=$1', array($rowRatio[0]));
					$equipos=pg_fetch_row($ratioGana);
					if(strnatcasecmp($equipoap[0], $equipos[1])==0){
						echo "<tr><td>".$equipoap[0]. "</td><td>" .$rowRatio[2]. "</td></tr>";
					}else if(strnatcasecmp($equipoap[1], $equipos[1])==0){
						echo "<tr><td>".$equipoap[1]. "</td><td>" .$rowRatio[2]. "</td></tr>";
					}else{
						echo "<tr><td> X </td><td>" .$rowRatio[2]. "</td></tr>";
					}
		pg_free_result($ratioGana);

				}
pg_free_result($ratio);
      			echo "</table>";
      			echo "<input type=\"submit\" value=\"Apostar\" />";
				echo "</form>";
      			echo "</article>";
				//if($cierre==0){
			//		echo "</section>";
//$cierre=1;
//	}

			}
			pg_free_result($resultado);
			pg_close($db);
echo "</section>";
      		/*$xml=simplexml_load_file("apuestas.xml");
      		foreach($xml->deporte as $apuestas){
      			echo "<section id=\"" .$apuestas->titulo ."\">";
      			echo '<h1>' .$apuestas->titulo .'</h1>';
      			$partidos=$apuestas->partidos;
      			foreach($partidos->partido as $partido){
              echo "<article>";
              echo "<form  action=\"apuesta.php\" method=\"post\">";
              echo "<input type=\"hidden\" name=\"id\" value=\"".$partido->id."\">";
      				echo "<h3>" .$partido->equipo1. '-' .$partido->equipo2."</h3>";
      				echo "<p>" .$partido->fecha ."</p>";
      				echo "<table>";
      				echo "<tr><td>".$partido->equipo1. "</td><td>" .$partido->gana1. "</td></tr>";
              if((0+$partido->empata)!=-1)
      				echo "<tr><td> X </td><td>" .$partido->empata. "</td></tr>";
      				echo "<tr><td>".$partido->equipo2. "</td><td>" .$partido->gana2. "</td></tr>";
      				echo "</table>";
      				echo "<input type=\"submit\" value=\"Apostar\" />";
              echo "</form>";
      				echo "</article>";
      			}
      			echo "</section>";

      		}*/
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
