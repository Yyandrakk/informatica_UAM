function mostrarOcultar(tag)
{
var ID = String(tag);
var sections=document.getElementsByTagName("section");

for(var i=0;i<sections.length;i++){
 if(sections[i].id==ID){
  //document.getElementById(ID).style.display = 'block';
  sections[i].style.display='block';
 }
  else{
    sections[i].style.display='none';
  //  document.getElementById(section[i].id).style.display = 'none';
  }
}
  /*
  var section=new Array("Futbol","Baloncesto","Tenis","Balonmano");

  for (i=0;i<section.length;i++)
  {
      if(ID==i)
      {
        document.getElementById(section[i]).style.display = 'block';
      }
      else
      {

      }
  }*/
}
function desactivar(formId){
  var formulario = document.getElementById(formId);
  for(var i=0,j=0;i<formulario.elements.length;i++){
    var campo = formulario.elements[i];
    if(campo.name=="modificar"){
      formulario.elements[i].value="Modificar";
      formulario.elements[i].setAttribute("onClick","javascript:activar("+formId+");");
      j++;
    }
    else if (campo.name=="cambiar"){
      formulario.elements[i].style.display="none";
      j++;
    }
    else if (campo.name=="saldo"){
      formulario.elements[i].readOnly=true;
      j++;
    }
    if(j==3){
      break;
    }

  }

}
function activar(formId){
  var formulario = document.getElementById(formId);
  for(var i=0, j=0 ;i < formulario.elements.length; i++){
    var campo = formulario.elements[i];
    if(campo.name=="modificar"){
      formulario.elements[i].value="Cancelar";
      formulario.elements[i].setAttribute("onClick","javascript:desactivar("+formId+");");
      j++;
    }
    else if (campo.name=="cambiar"){
      formulario.elements[i].style.display="inline-block";
      j++;
    }
    else if (campo.name=="saldo"){
      formulario.elements[i].readOnly=false;
      j++;
    }
    if(j==3){
      break;
    }

  }

}
function cargarFechayUsuarios(){
var fecha = $.ajax({
  url:'ajax.php?date=0',
  dataType: 'text',
  async: false
}).responseText;
var usuarios = $.ajax({
  url:'ajax.php?usuarios=0',
  dataType: 'text',
  async: false
}).responseText;
  document.getElementById("fecha").innerHTML = "Fecha: "+fecha;
  document.getElementById("usuarios").innerHTML ="Usuarios conectados: "+usuarios;
}
