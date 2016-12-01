<?php

if(isset($_REQUEST["date"])){
 echo date("d-m-Y H:i:s");
}
if (isset($_REQUEST["usuarios"])) {
  echo mt_rand(100,10000);
}
 ?>
