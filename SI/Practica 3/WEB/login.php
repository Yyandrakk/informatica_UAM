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
if(isset($_REQUEST['confirmar'])){
	//este if evita que si recarga la pagina de error
	if(isset($_REQUEST['mail']) and isset($_REQUEST['password'])){
	  $mail=$_REQUEST['mail'];
	  $psw=$_REQUEST['password'];
    //preguntar al profesor
	try
	{
		$db=  pg_connect("host=localhost dbname=si1 user=alumnodb password=alumnodb");
	}
	catch(Exception $e)
	{
      echo "<script type=\"text/javascript\">alert(\"".$e->getMessage()."\"); window.location.href='login.php';</script>";
	}
	$result = pg_query_params($db, 'SELECT firstname,customerid FROM customers WHERE email = $1 and password = $2', array($mail,$psw));
	if(!$result){

pg_close($db);
		echo "<script type=\"text/javascript\">alert(\"Datos incorrectos\"); window.location.href='login.php';</script>";
	}
    $row = pg_fetch_row($result);
	$_SESSION["name"]=$row[0];
  $_SESSION["id_client"]=$row[1];
	$_SESSION["login"]=$mail;
pg_free_result($result);
pg_close($db);
	echo "<script type=\"text/javascript\">alert(\"Logueado correctamente\"); window.location.href='index.php';</script>";



	 /* $ruta="./usuarios/".$nombre."/";
	  if(file_exists($ruta)==False){
	       echo "<script type=\"text/javascript\">alert(\"El usuario no existe en el sistema, registrese\"); window.location.href='registro.php';</script>";
	  }else{

	    //  $psw=md5($psw);
		 // ------ LEEMOS EL XML -------
	      $doc = new DOMDocument();

	    // Cargamos el fichero XML
	    $doc->load( $ruta."datos.dat" );

	    // Obtenemos el nodo 'persona'
	    $usuarios = $doc->getElementsByTagName( "usuario" );

	foreach ($usuarios as $usuario) {
	  // Recogemos todas las etiquetas 'contrasena'
	  $contrasenas = $usuario->getElementsByTagName( "contrasena" );

	  // Recogemos el valor de la que nos interesa
	  $contrasena = $contrasenas->item(0)->nodeValue;
	}


	      if($contrasena==$psw){

		$_SESSION["name"]=$nombre;
		$_SESSION["login"]=$nombre;
		echo "<script type=\"text/javascript\">alert(\"Logueado correctamente\"); window.location.href='index.php';</script>";




	      }else{
		echo "<script type=\"text/javascript\">alert(\"La contraseña es incorrecta\"); window.location.href='registro.php';</script>";

	      }

	  }*/
	}else{
		  //si ha recargado la pagina esto le devuelve a la pagina de login
		header('Location: login.php');
	}
}else{
echo "<section id=\"apuesta\">";
	echo "<h1>Autentificarse</h1>";
	echo "<article>";
		echo "<h4>Introduce tus datos:</h4>";
		echo "<form action=\"login.php\" method=\"post\">";

    if(isset($_COOKIE["lastuser"])){
        echo "Email: <input type=\"mail\" name=\"mail\" value=\"".$_COOKIE["lastuser"]."\" required><br>";
    }else{
      	echo "Email: <input type=\"mail\" name=\"mail\" required><br>";
    }
			echo "Contraseña: <input type=\"password\" name=\"password\" required><br>";
			echo "<input type=\"submit\" name=\"confirmar\" value=\"Confirmar\"/>";
		echo "</form>";
	echo "</article>";
echo "</section>";
}
?>
        </section>
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
