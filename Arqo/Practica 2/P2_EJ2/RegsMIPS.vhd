----------------------------------------------------------------------
-- Fichero: RegsMIPS.vhd
-- Descripción: Unidad dee registros del procesador

-- Autores: Oscar Garcia de Lara y Patricia Anza
-- Asignatura: ARQO 
-- Grupo de Prácticas:1312
-- Grupo de Teoría: 131
-- Práctica: 1
-- Ejercicio: 2
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity RegsMIPS is
	port (
		Clk : in std_logic; -- Reloj
		Reset : in std_logic; -- Reset asíncrono a nivel bajo
		A1 : in std_logic_vector(4  downto 0); --Es la direccion para el puerto Rd1
		A2 : in std_logic_vector(4  downto 0); --Es la direccion para el puerto Rd2
		A3 : in std_logic_vector(4  downto 0); --Es la direccion para el puerto Wd3
		Rd1 : out std_logic_vector(31 downto 0); --Dato de salida Rd1
		Rd2 : out std_logic_vector(31 downto 0); --Dato de salida Rd2
		Wd3: in std_logic_vector(31 downto 0);   --Dato de entrada Wd3
		We3 : in std_logic --Habilitacion del banco de resgistros
	); 
end RegsMIPS;

architecture Practica of RegsMIPS is

	-- Tipo para almacenar los registros
	type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);

	-- Esta es la señal que contiene los registros. El acceso es de la
	-- siguiente manera: regs(i) acceso al registro i, donde i es
	-- un entero. Para convertir del tipo std_logic_vector a entero se
	-- hace de la siguiente manera: conv_integer(slv), donde
	-- slv es un elemento de tipo std_logic_vector

	-- Registros inicializados a '0' 
	signal regs : regs_t;

begin  -- PRACTICA
	

	------------------------------------------------------
	-- Escritura del registro RT
	------------------------------------------------------
	-- Creamos un proceso en cuya lista de sensibilidad se encuentran el reloj (Clk) y el reset (Reset),
	-- ya que su valor no va a variar. 
	
	E: process (Clk, Reset)
	begin
	
	-- Cuando el reset se encuentra a '0' se inicia un bucle que va recorriendo las 32 posiciones del registro 
	-- inicializabdo los valores del registro a cero.
		if Reset = '1' then
			for i in 0 to 31 loop
			regs(i) <= (OTHERS => '0');
			end loop;
	
	-- Si la condicion anterior no se cumple pasaremos directamente a esta en la que el reloj tiene el valor
	-- '1' y es de flanco ascendente. 
		elsif clk = '0' and clk'event then
		if We3 = '1' then                 --Esto se ejecuta cuando la entrada de habilitacion se encuentr a '1'
		  if A3 /= "00000" then           --Aquí se protege el registro del valor cero
		  regs(conv_integer(A3)) <= Wd3;  --Se asigna lo que entra al registro a regs de indice A3 converitdo
		  end if;                         --a número entero
		  end if;
		end if;
	end process E;	
		  
	------------------------------------------------------
	-- Lectura del registro RS
	------------------------------------------------------
	-- RsOut recibira el valor guardado en regs(conv_integer(RsAddr)), y lo que hace "conv_integer(RsAddr)"
   -- es convertir el valor  de RsAdder a un numero entero que sera el indice de "regs"
	
	
	Rd1 <= regs(conv_integer(A1)); --Aqui se sacan los valores del primer registro
	Rd2 <= regs(conv_integer(A2)); --Aqui se sacan los valores del segundo registro
	

	end Practica;