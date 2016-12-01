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
//este if evita que si recarga la pagina de error
if(isset($_REQUEST['confirmar'])){
	if(isset($_REQUEST['user']) and isset($_REQUEST['password']) and isset($_REQUEST['rpassword']) and isset($_REQUEST['e-mail']) and isset($_REQUEST['tarjeta']) and isset($_REQUEST['caducidad']) and isset($_REQUEST['saldo'])){

	$nombre=$_REQUEST['user'];
	$psw=$_REQUEST['password'];
	$cpsw=$_REQUEST['rpassword'];
	$mail=$_REQUEST['e-mail'];
	$tarjeta=$_REQUEST['tarjeta'];
	$fecha=$_REQUEST['caducidad'];
	$saldo=$_REQUEST['saldo'];



	if($psw!=$cpsw){
		echo "<script type=\"text/javascript\">alert(\"Las claves no son iguales, intente nuevamente.\");</script>";
	}else{
	//$psw=md5($psw);

	$ruta = "./usuarios/".$nombre."/";

	if(file_exists($ruta)==False)
	{
	mkdir ($ruta,0777,true);
	chmod($ruta,0777);
	chmod("./usuarios/",0777);
	// Creamos el fichero XML y su estructura
	$dom = new DomDocument("1.0", "UTF-8");
	// Defiminos el nodo persona
	$usuario = $dom->createElement('usuario');
	// Campos o nodos de persona
	$usuario->appendChild( $dom->createElement('nombre', $nombre) );
	$usuario->appendChild( $dom->createElement('contrasena', $psw) );
	$usuario->appendChild( $dom->createElement('mail', $mail) );
	$usuario->appendChild( $dom->createElement('tarjeta', $tarjeta) );
	$usuario->appendChild( $dom->createElement('fecha', $fecha) );
	$usuario->appendChild( $dom->createElement('saldo', $saldo) );
	// Insertamos el elemento persona en la raiz
	$dom->appendChild( $usuario );
	// Le damos formato (para que no lo muestre todo seguido
	// sin saltos de línea)
	$dom->formatOutput = true;

	// Guardar el xml como String...
	$strings_xml = $dom->saveXML();

	// ... e indicamos dónde queremos guardarlo (ruta)
	$dom->save($ruta.'/datos.dat');
  	chmod($ruta."/datos.dat",0777);

  $file =fopen($ruta.'/historial.xml',"w+");
  $cadena="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<historial>
</historial>";
  fwrite($file,$cadena);
  fclose($file);
  	chmod($ruta."/historial.xml",0777);
	echo "<script type=\"text/javascript\">alert(\"Se ha registrado correctamente\"); window.location.href='login.php';</script>";
	} else {

		echo "<script type=\"text/javascript\">alert(\"El usuario ".$nombre." ya existe\"); window.location.href='registro.php';</script>";

	}


	}
	}
	else{
	  //si ha recargado la pagina esto le devuelve a la pagina de registro
	header('Location: registro.php');
	}

}else{
	echo "<section id=\"apuesta\">";
		echo "<h1>Registrar nuevo usuario</h1>";
			echo "<article>";
				echo "<h4>Introduce tus datos:</h4>";
				echo "<form  action=\"registro.php\" method=\"post\">";
					echo "Nombre:";
					echo "<input type=\"text\" name=\"user\" required pattern=\"^[A-Za-z0-9_]{1,15}$\" ><br>";
					echo "Contraseña:";
					echo "<input type=\"password\" name=\"password\" required pattern=\"^[A-Za-z0-9_]{8,}$\"><br>";
					echo "Repite la contraseña:";
					echo "<input type=\"password\" name=\"rpassword\" required pattern=\"^[A-Za-z0-9_]{8,}$\"><br>";
					echo "e-Mail:";
					echo "<input type=\"email\" name=\"e-mail\" required><br>";
					echo "Tarjeta de crédito:";
					echo "<input type=\"text\" name=\"tarjeta\"required pattern=\"^[0-9]{1,16}$\"><br>";
					echo "Fecha de caducidad:";
					echo "<input type=\"date\" name=\"caducidad\" required><br>";
					echo "Saldo:";
					echo "<input type=\"text\" name=\"saldo\" required><br>";
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
