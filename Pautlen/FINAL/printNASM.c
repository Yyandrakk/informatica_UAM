#include "printNASM.h"
extern FILE *yyout;
extern int etiqueta;
void escribirSegmentBss (TablaHash t)
{
  char aux[100];
  FILE *auxf=fopen("auxident.txt","r");
  fprintf(yyout, "segment .bss\n");

  while(!feof(auxf))
    {
      fscanf(auxf,"%s",aux);
    if(!feof(auxf))
      {

      if(MiembroHash (aux,t)!=0)
        {
          if(returnClaseHash (aux,t)==VECTOR)
            fprintf(yyout, "_%s resd %d\n",aux, returnTamanoHash (aux,t));
          else
            fprintf(yyout, "_%s resd 1\n",aux);
        }
    }
  }
  fclose(auxf);
}

void escribirMain()
{
    fprintf(yyout, "main:\n");
}
void escribirCabCodigo()
{
    fprintf(yyout, "segment .text\n");
    fprintf(yyout, "global main\n");
    fprintf(yyout, "extern scan_int, scan_boolean\n");
    fprintf(yyout, "extern print_int, print_boolean, print_string, print_blank, print_endofline\n\n");
}

void escribirSegmentData()
{
  fprintf(yyout, "segment .data\n");
  fprintf(yyout, "mensaje_1 db \"****Error de ejecucion: Indice fuera de rango.\" , 0\n");
  fprintf(yyout, "mensaje_2 db \"****Error de ejecucion: Division por cero.\" , 0\n");
}
void escribirErrores()
{
  fprintf(yyout,"ret\n");
  fprintf(yyout,"error_1: push dword mensaje_1\n");
  fprintf(yyout,"call print_string\n");
  fprintf(yyout,"add esp, 4\n");
  fprintf(yyout,"jmp near fin\n");
  fprintf(yyout,"error_2: push dword mensaje_2\n");
  fprintf(yyout,"call print_string\n");
  fprintf(yyout,"add esp, 4\n");
  fprintf(yyout,"jmp near fin\n");
  fprintf(yyout,"fin: ret\n");


}
void insertarIdentPila(char *cad,int linea)
{
  fprintf(yyout,";numero de linea [%d]\n",linea);
  fprintf(yyout,"\tpush dword [_%s]\n",cad);
}
void insertarConst(int valor, int linea)
{
  fprintf(yyout,";numero de linea [%d]\n",linea);
  fprintf(yyout,"push dword %d\n",valor);
}
void operacionesExp(int caso, int dir1, int dir2)
{
  switch(caso)
  {
    case SUMA:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword edx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword edx , [edx]\n");
      fprintf(yyout, "; cargar el primer operando en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la suma y dejar el resultado en eax \n");
      fprintf(yyout,"add eax, edx\n");
      fprintf(yyout, "; apilar el resultado\n");
      fprintf(yyout,"push dword eax\n");
    break;
    case RESTA:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword edx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword edx , [edx]\n");
      fprintf(yyout, "; cargar el primer operando en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la resta y dejar el resultado en eax \n");
      fprintf(yyout,"sub eax, edx\n");
      fprintf(yyout, "; apilar el resultado\n");
      fprintf(yyout,"push dword eax\n");
    break;
    case MULTI:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword ecx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword ecx , [ecx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout,";edx a 0\n");
    fprintf(yyout,"xor edx, edx\n");
    fprintf(yyout, "; realizar la multiplicacion y dejar el resultado en eax \n");
    fprintf(yyout,"imul ecx\n");
    fprintf(yyout, "; apilar el resultado\n");
    fprintf(yyout,"push dword eax\n");
    break;
    case DIV:
      fprintf(yyout, "; cargar el divisor en ecx\n");
      fprintf(yyout,"pop dword ecx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword ecx , [ecx]\n");
      fprintf(yyout,"cmp ecx, 0\n");
      fprintf(yyout,"je near error_2\n");
      fprintf(yyout, "; cargar el dividendo en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout,";Extendiendo edx:eax\n");
      fprintf(yyout,"cdq\n");
      fprintf(yyout, "; realizar la division en eax \n");
      fprintf(yyout,"idiv ecx\n");
      fprintf(yyout, "; apilar el resultado\n");
      fprintf(yyout,"push dword eax\n");
    break;
    case MENOS:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la negacion y dejar el resultado en eax \n");
      fprintf(yyout,"neg eax\n");
      fprintf(yyout, "; apilar el resultado\n");
      fprintf(yyout,"push dword eax\n");
    break;
    case AND:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword edx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword edx , [edx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la AND y dejar el resultado en eax \n");
    fprintf(yyout,"and eax, edx\n");
    fprintf(yyout, "; apilar el resultado\n");
    fprintf(yyout,"push dword eax\n");
    break;
    case OR:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword edx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword edx , [edx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la OR y dejar el resultado en eax \n");
    fprintf(yyout,"or eax, edx\n");
    fprintf(yyout, "; apilar el resultado\n");
    fprintf(yyout,"push dword eax\n");
    break;
    case NOT:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la neacion y dejar el resultado en eax \n");
    fprintf(yyout,"not al\n");
    fprintf(yyout,"sub al,11111110b\n");
    fprintf(yyout, "; apilar el resultado\n");
    fprintf(yyout,"push dword eax\n");
    break;
  }
}
void operacionesCmp (int caso, int dir1, int dir2,int etiqueta)
{
  switch(caso)
  {
    case IGUAL:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword edx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword edx , [edx]\n");
      fprintf(yyout, "; cargar el primer operando en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
      fprintf(yyout,"cmp eax, edx\n");
      fprintf(yyout,"je near igual%d\n",etiqueta);
      fprintf(yyout,"push dword 0\n");
      fprintf(yyout,"jmp near fin_igual%d\n",etiqueta);
      fprintf(yyout,"igual%d:\n push dword 1\n",etiqueta);
      fprintf(yyout,"fin_igual%d:",etiqueta);

    break;
    case DESIGUAL:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword edx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword edx , [edx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
    fprintf(yyout,"cmp eax, edx\n");
    fprintf(yyout,"jne near desigual%d\n",etiqueta);
    fprintf(yyout,"push dword 0\n");
    fprintf(yyout,"jmp near fin_desigual%d\n",etiqueta);
    fprintf(yyout,"desigual%d:\n push dword 1\n",etiqueta);
    fprintf(yyout,"fin_desigual%d:",etiqueta);
    break;
    case MAYORIGUAL:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword edx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword edx , [edx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
    fprintf(yyout,"cmp eax, edx\n");
    fprintf(yyout,"jge near mayorigual%d\n",etiqueta);
    fprintf(yyout,"push dword 0\n");
    fprintf(yyout,"jmp near fin_mayorigual%d\n",etiqueta);
    fprintf(yyout,"mayorigual%d:\n push dword 1\n",etiqueta);
    fprintf(yyout,"fin_mayorigual%d:",etiqueta);

    break;
    case MENORIGUAL:
    fprintf(yyout, "; cargar el segundo operando en edx\n");
    fprintf(yyout,"pop dword edx\n");
    if(dir2==1)
      fprintf(yyout,"mov dword edx , [edx]\n");
    fprintf(yyout, "; cargar el primer operando en eax\n");
    fprintf(yyout,"pop dword eax\n");
    if(dir1==1)
      fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
    fprintf(yyout,"cmp eax, edx\n");
    fprintf(yyout,"jle near menorigual%d\n",etiqueta);
    fprintf(yyout,"push dword 0\n");
    fprintf(yyout,"jmp near fin_menorigual%d\n",etiqueta);
    fprintf(yyout,"menorigual%d:\n push dword 1\n",etiqueta);
    fprintf(yyout,"fin_menorigual%d:",etiqueta);

    break;
    case MAYOR:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword edx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword edx , [edx]\n");
      fprintf(yyout, "; cargar el primer operando en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
      fprintf(yyout,"cmp eax, edx\n");
      fprintf(yyout,"jg near mayor%d\n",etiqueta);
      fprintf(yyout,"push dword 0\n");
      fprintf(yyout,"jmp near fin_mayor%d\n",etiqueta);
      fprintf(yyout,"mayor%d:\n push dword 1\n",etiqueta);
      fprintf(yyout,"fin_mayor%d:",etiqueta);

    break;
    case MENOR:
      fprintf(yyout, "; cargar el segundo operando en edx\n");
      fprintf(yyout,"pop dword edx\n");
      if(dir2==1)
        fprintf(yyout,"mov dword edx , [edx]\n");
      fprintf(yyout, "; cargar el primer operando en eax\n");
      fprintf(yyout,"pop dword eax\n");
      if(dir1==1)
        fprintf(yyout,"mov dword eax , [eax]\n");
      fprintf(yyout, "; realizar la comparacion y realizar el salto y apilar el resultado \n");
      fprintf(yyout,"cmp eax, edx\n");
      fprintf(yyout,"jl near menor%d\n",etiqueta);
      fprintf(yyout,"push dword 0\n");
      fprintf(yyout,"jmp near fin_menor%d\n",etiqueta);
      fprintf(yyout,"menor%d:\n push dword 1\n",etiqueta);
      fprintf(yyout,"fin_menor%d:",etiqueta);

    break;
  }

}

void escribirElemVector(int dir1,char *cad,TablaHash t)
{
  fprintf(yyout, "; cargar el indice en eax\n");
  fprintf(yyout,"pop dword eax\n");
  if(dir1==1)
    fprintf(yyout,"mov dword eax , [eax]\n");
  fprintf(yyout, "; Comprabacion si el indice esta dentro del rango\n");
  fprintf(yyout,"cmp eax, 0\n");
  fprintf(yyout, "jl error_1\n");
  fprintf(yyout,"cmp eax, %d\n",returnTamanoHash (cad,t)-1);
  fprintf(yyout, "jg error_1\n");/* PUEDE QUE SEA JL */
  fprintf(yyout,";el indice esta en rango");
  fprintf(yyout,"; Cargar en edx la dirección de inicio del vector\n");
  fprintf(yyout,"mov dword edx, _%s\n",cad);
  fprintf(yyout,"; Cargar en eax la dirección del elemento indexado\n");
  fprintf(yyout,"lea eax, [edx + eax*4]\n");
  fprintf(yyout,"; Apilar la dirección del elemento indexado\n");
  fprintf(yyout,"push dword eax\n");
}
void asignarIdent(char *cad, int dir)
{

  fprintf(yyout,"; Cargar en eax la parte derecha de la asignación\n");
  fprintf(yyout,"pop dword eax\n");
  if (dir == 1)
    fprintf(yyout,"mov dword eax , [eax]\n");
  fprintf(yyout,"; Hacer la asignación efectiva\n");
  fprintf(yyout,"mov dword [_%s] , eax\n",cad);
}
void asignarIdentLocal(int dir)
{

  fprintf(yyout,"; Cargar en eax la parte derecha de la asignación y en ebx la izquierda\n");
  fprintf(yyout,"pop dword ebx\n");
  fprintf(yyout,"pop dword eax\n");
  if (dir == 1)
    fprintf(yyout,"mov dword eax , [eax]\n");
  fprintf(yyout,"; Hacer la asignación efectiva\n");
  fprintf(yyout,"mov dword [ebx] , eax\n");
}
void asignarElem (int dir1)
{
  fprintf(yyout,"; Cargar en eax la parte derecha de la asignación\n");
  fprintf(yyout,"pop dword eax\n");
  if (dir1 == 1)
    fprintf(yyout,"mov dword eax , [eax]\n");
  fprintf(yyout,"; Cargar en edx la parte izquierda de la asignación\n");
  fprintf(yyout,"pop dword edx\n");
  fprintf(yyout,"; Hacer la asignación efectiva\n");
  fprintf(yyout,"mov dword [edx] , eax\n");
}
void escribirScanf (char * cad, int tipo)
{
  fprintf(yyout,"; Guardar en la pila el identifcador\n");
  fprintf(yyout,"push dword _%s\n",cad);
  if(tipo==INT)
    fprintf(yyout,"call scan_int\n");
  else
    fprintf(yyout,"call scan_boolean\n");
  fprintf(yyout,"add esp, 4\n");
}
void escribirScanfFuncion (int tipo)
{
  if(tipo==INT)
    fprintf(yyout,"call scan_int\n");
  else
    fprintf(yyout,"call scan_boolean\n");
  fprintf(yyout,"add esp, 4\n");
}
void escribirPrint (int dir,int tipo)
{

  fprintf(yyout,"; Acceso al valor de exp si es distinto de constante\n");
  if(dir == 1)
  {
    fprintf(yyout,"pop dword eax\n");
    fprintf(yyout,"mov dword eax , [eax]\n");
    fprintf(yyout,"push dword eax\n");
  }
  if(tipo==INT)
    fprintf(yyout,"call print_int\n");
  else
    fprintf(yyout,"call print_boolean\n");
  fprintf(yyout,"; Restauración del puntero de pila\n");
  fprintf(yyout,"add esp, 4\n");
  fprintf(yyout,"; Salto de línea\n");
  fprintf(yyout,"call print_endofline\n");
}
void escribirif(int dir, int etiqueta)
{
  fprintf(yyout,"; Cargar en eax la parte derecha de la asignación\n");
  fprintf(yyout,"pop dword eax\n");
  if (dir == 1)
    fprintf(yyout,"mov dword eax , [eax]\n");
  fprintf(yyout,"cmp eax, 0\n");
  fprintf(yyout,"je near fin_si%d\n",etiqueta);
}
void escribirifend(int etiqueta)
{
  fprintf(yyout,"fin_si%d:\n",etiqueta);
}
void escribirif_exp(int etiqueta)
{
  fprintf(yyout,"jmp near fin_sino%d\n",etiqueta);
  fprintf(yyout,"fin_si%d:\n",etiqueta);
}
void escribirelse(int etiqueta)
{
  fprintf(yyout,"fin_sino%d:\n",etiqueta);
}
void escribirwhile( int etiqueta)
{
  fprintf(yyout,"inicio_while%d:\n",etiqueta);

}
void escribirwhile_exp(int dir,int etiqueta)
{
  fprintf(yyout,"pop eax\n");
  if(dir==1)
    fprintf(yyout,"mov eax , [eax]\n");
  fprintf(yyout,"cmp eax, 0\n");
  fprintf(yyout,"je near fin_while%d\n",etiqueta);

}
void escribirwhile_fin(int etiqueta)
{
  fprintf(yyout,"jmp near inicio_while%d\n",etiqueta);
  fprintf(yyout,"fin_while%d:\n",etiqueta);
}
void escribirfuncionfirst(char *cad,int num_variable_local)
{
  fprintf(yyout,";Escribir nombre de la funcion y meter ebp en la pila y ebp=esp\n");
  fprintf(yyout,"_%s:\n",cad);
  fprintf(yyout,"push ebp\n");
  fprintf(yyout,"mov ebp, esp\n");
  fprintf(yyout,"sub esp, %d\n",4*num_variable_local);
}
void escribirfuncionend()
{
  fprintf(yyout,"mov esp, ebp\n");
  fprintf(yyout,"pop ebp\n");
  fprintf(yyout,"ret\n");
}

void escribirllamadafuncion(char *cad, int num_parametros)
{
  fprintf(yyout, "call _%s\n", cad);
  fprintf(yyout, "add esp, %d\n", 4*num_parametros);
  fprintf(yyout, "push dword eax\n");
}

void escribirIdentificador(char *cad,int 	en_explit)
{
  if (en_explit==0)
    fprintf (yyout, "push dword _%s\n", cad);
  else
    fprintf (yyout, "push dword [_%s]\n", cad);
}
void escribirRetorno (int dir)
{
  fprintf (yyout, "pop dword eax\n");
  if(dir==1)
    fprintf (yyout, "mov eax , [eax]\n");
  fprintf (yyout, "mov dword esp, ebp\n");
  fprintf (yyout, "pop dword ebp\n");
  fprintf (yyout, "ret\n");
}
void escribirIdentificadorLocal (int categoria,int num_param, int pos_param, int pos_var,int llamada_dentro_funcion)
{
  if(llamada_dentro_funcion==0)
  {
    if(categoria == PARAMETRO)
      {
        fprintf(yyout, "lea eax, [ebp+%d]\n",4+4*(num_param - pos_param));
        fprintf(yyout, "push dword eax\n");
      }
    else
      {
        fprintf(yyout, "lea eax, [ebp-%d]\n",4*pos_var);
        fprintf(yyout, "push dword eax\n");
      }
  }
  else
    {

      if(categoria == PARAMETRO)
        {
          fprintf(yyout, "lea eax, [ebp+%d]\n",4+4*(num_param - pos_param));
          fprintf(yyout, "push dword [eax]\n");
        }
      else
        {
          fprintf(yyout, "lea eax, [ebp-%d]\n",4*pos_var);
          fprintf(yyout, "push dword [eax]\n");
        }
    }
}
