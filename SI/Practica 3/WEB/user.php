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

			try
			{
				$db=  pg_connect("host=localhost dbname=si1 user=alumnodb password=alumnodb");
			}
			catch(Exception $e)
			{
      			echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='index.php';</script>";
			}
			$user=$_SESSION["login"];
			$resultado = pg_query_params($db, 'SELECT * FROM customers WHERE email=$1', array($user)) or die('Consulta fallida'.pg_last_error());
			$row=pg_fetch_row($resultado);


			echo "<aside>";
            		echo "<nav id=\"Barra\">";
                	echo "<ul>";
                    	echo "<li>Saldo:".$row[8]."</li>";
                	echo "</ul>";
            		echo "</nav>";
        		echo "</aside>";

		if(isset($_REQUEST['saldo']) and isset($_REQUEST['Confirmar'])){
			$nuevosaldo=$_REQUEST['saldo'];
			$saldofinal = pg_query_params($db, 'UPDATE customers SET credit=credit+ $1 WHERE $2=email', array($nuevosaldo, $user)) or die('Consulta fallida'.pg_last_error());
		        /*$xml=simplexml_load_file("./usuarios/".$_SESSION["name"]."/datos.dat");
			$nuevosaldo=$_REQUEST['saldo'];
			$xml->saldo=(string)(0+$xml->saldo)+(0+$nuevosaldo);
			$xml->asXML("./usuarios/".$_SESSION["name"]."/datos.dat");*/
                        header('Location: user.php');
			pg_free_result($saldofinal);
		}
		pg_free_result($resultado);
		/*pg_close($db);*/

		echo "<section>";
 		echo "<article>";
        echo "<form  action=\"user.php\" method=\"post\">";
		echo "<h3>Añadir saldo</h3>";
		echo "<input type=\"text\" name=\"saldo\" placeholder=\"Añadir saldo\">";
		echo "<input type=\"submit\" name=\"Confirmar\" value=\"Confirmar\" />";
		echo "</form>";
		echo "</article>";
		echo "</section>";


		$res = pg_query_params($db, 'SELECT* FROM bets NATURAL JOIN clientbets NATURAL JOIN clientorders NATURAL JOIN customers WHERE email=$1 AND betcloses IS NOT NULL', array($user)) or die('Consulta fallida'.pg_last_error());


		echo "<section id=\"historial\">";
		echo "<h1>Historial</h1>";
		echo "<table>";
		echo "<tr><td><strong>Partido</strong></td><td><strong>Fecha</strong></td><td><strong>Categoría</strong></td><td><strong>Equipo apostado</strong></td><td><strong>Dinero apostado</strong></td><td><strong>Dinero ganado</strong></td></tr>";
		while($finalId=pg_fetch_row($res)){
			$res2 = pg_query_params($db, 'SELECT optiondesc FROM options WHERE optionid=$1', array($finalId[7])) or die('Consulta fallida'.pg_last_error());
			$apostado=pg_fetch_row($res2);

			echo "<tr><td>".$finalId[5]."</td><td>".$finalId[3]."</td><td>".$finalId[4]."</td><td>".$apostado[0]."</td><td>".$finalId[8]."</td><td>".$finalId[10]."</td></tr>";


		}
		echo "</table>";

		pg_free_result($res2);
		pg_free_result($res);

		pg_close($db);
		/*$xml=simplexml_load_file("./usuarios/".$_SESSION["name"]."/historial.xml");
		$xml2=simplexml_load_file("apuestas.xml");
		$imprimir= "<section id=\"historial\">
						<h1>Historial</h1>
	 					<table>
		        			<tr><th>Partido</th><th>Fecha</th><th>Dinero</th><th>Apostado</th></tr>";
		foreach($xml2->deporte as $apuestas){
	      		$partidos=$apuestas->partidos;
	      		foreach($partidos->partido as $partido1){
				foreach($xml->partido as $partido){
					if(strcmp($partido1->id, $partido->id)==0){
						$imprimir.= "<tr><td>" .$partido1->equipo1. '-' .$partido1->equipo2."</td><td>".$partido->fecha."</td><td>".$partido->dinero."</td><td>".$partido->apuesta."</td></tr>";


					}



				}
			}
		}
	$imprimir.="</table></section>";
	echo $imprimir;*/

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
