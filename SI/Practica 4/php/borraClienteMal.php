<?php
define("PGUSER", "alumnodb");
define("PGPASSWORD", "alumnodb");
define("DSN","pgsql:host=localhost;dbname=si1;options='--client_encoding=UTF8'");
?>

<html>
  <head>
    <title>Borrar clientes</title>
      <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	  <style type="text/css">
        table {
                border-style: none;
                border-collapse: collapse;
        }
        table th {
                border-width: 1px;
                padding: 1px;
                border-style: solid;
                border-color: gray;
                background-color: rgb(230, 230, 220);
        }
        table td {
                border-width: 1px;
                padding: 1px;
                border-style: solid;
                border-color: gray;
                background-color: rgb(255, 255, 240);
        }
      </style>
  </head>
  <body>


    <?php 
      if (!isset($_REQUEST['id_cliente'])) { 
    
  		echo"<h2>Introduce el id que desea borrar</h2> <form action=\"borraClienteMal.php\" method=\"get\">
		<input type=\"text\" pattern=\"([1-9])+\" name=\"id_cliente\" REQUIRED >
		<input type=\"submit\" value=\"ir\">
    		</form>";
      } else {
        try {
		  $id=0+$_REQUEST['id_cliente'];
          $db = new PDO(DSN,PGUSER,PGPASSWORD);
	 	  $db->beginTransaction();
	  	 /* $sql= "SELECT COUNT(*) FROM customers WHERE actor_id=$id";
          $result= $db->query($sql);
		  if($result===FALSE or $result->fetchColumn()==0){
				echo "Ese id no existe, introduzca otro  <a href=\"borraClienteMal.php\">pinche aqui para volver</a> ";
				$db->commit();
		   }
	  	  else{*/

				echo"Eliminando client customers<p>";
	 			$delCustomers="DELETE FROM customers WHERE customerid=$id";
		 		$result = $db->exec($delCustomers);
				if($result===FALSE ){
										echo "Error detectado en DELETE customers<p>";
					$sql="SELECT COUNT(*) as num_customer FROM customers WHERE customerid=$id";
					$query=$db->query($sql);
					$row= $query->fetch(PDO::FETCH_ASSOC);
				  	echo "Antes del rollBack tenemos ".$row["num_customer"]." rows";
					
					$db->rollBack();
					$sql="SELECT COUNT(*) as num_customer FROM customers WHERE customerid=$id";
						foreach ($db->query($sql) as $row){
					  		echo "Despues del rollBack tenemos ".$row["num_customer"]." rows";
						}
					die();
				}
				
				echo"Eliminando apuestas clientbets<p>";
				$delClientBets="DELETE FROM clientbets WHERE orderid IN (SELECT orderid FROM clientorders WHERE customerid=$id)";
		 		$result = $db->exec($delClientBets);
				if($result===FALSE ){
					echo "Error detectado en DELETE clientsbets<p>";
					$sql="SELECT COUNT(*) as num_bets FROM clientbets WHERE orderid IN (SELECT orderid FROM clientorders WHERE customerid=$id) GROUP BY orderid";
					foreach ($db->query($sql) as $row){
				  		echo "Antes del rollBack tenemos".$row["num_bets"]."rows";
					}
					
					$db->rollBack();
					$sql="SELECT COUNT(*) as num_bets FROM clientbets WHERE orderid IN (SELECT orderid FROM clientorders WHERE customerid=$id) GROUP BY  orderid";
						foreach ($db->query($sql) as $row){
					  		echo "Despues del rollBack tenemos".$row["num_bets"]."rows<p>";
						}
					die();
				}
				echo"Eliminando carritos clientorders<p>";
				$delClientOrders="DELETE FROM clientorders WHERE customerid=$id";
		 		$result = $db->exec($delClientOrders);
			
		        if($result===FALSE ){
									echo "Error detectado en DELETE clientsorders<p>";
					$sql="SELECT COUNT(*) as num_orders FROM clientorders  WHERE customerid=$id GROUP BY customerid";
					foreach ($db->query($sql) as $row){
				  		echo "Antes del rollBack tenemos".$row["num_orders"]."rows";
					}
					
					$db->rollBack();
					$sql="SELECT COUNT(*) as num_orders FROM clientorders  WHERE customerid=$id  GROUP BY customerid";
						foreach ($db->query($sql) as $row){
					  		echo "Despues del rollBack tenemos".$row["num_orders"]."rows";
						}
					die();
				}
				
	 			

		   	   $db->commit();
				echo "Eliminado el cliente, <a href=\"borraClienteMal.php\">pinche aqui para volver</a> ";
			/*}*/	
        } catch (PDOException $e) {
          print "Error!: " . $e->getMessage() . "<br/>";
        }
         
        $db = null;
      }
    ?>
  </body>
</html>

