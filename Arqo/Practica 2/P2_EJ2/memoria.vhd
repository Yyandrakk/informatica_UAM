--------------------------------------------------------------
-- Modelo simplificado de Memoria. EPS-UAM
--------------------------------------------------------------
library STD;
use STD.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all;

-- Uncomment the following lines to use the declarations that are
-- provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoria is
	generic(
		C_ELF_FILENAME    : string := "programa";
		C_MEM_SIZE        : integer := 1024
	);
	Port (
		Addr : in std_logic_vector(31 downto 0);
		DataIn : in std_logic_vector(31 downto 0);
		WrEn : in std_logic ;
		Clk : in std_logic ;  
		Reset : in std_logic ; -- No se usa
		DataOut : out std_logic_vector(31 downto 0)
	);
end memoria;

architecture Behavioral of memoria is 
	
	type matriz is array(0 to (C_MEM_SIZE/4)-1) of STD_LOGIC_VECTOR(31 downto 0);
	signal memo: matriz;
	
begin
	
	process (clk)
			variable cargar : boolean := true;
			variable address : STD_LOGIC_VECTOR(31 downto 0);
			variable datum : STD_LOGIC_VECTOR(31 downto 0);
			file bin_file : text is in C_ELF_FILENAME;
			variable  current_line : line;
			variable espera : integer := 0;
	begin
		
		if cargar then 
			-- primero iniciamos la memoria con ceros
			for i in 0 to (C_MEM_SIZE/4)-1 loop
				memo(i) <= (others => '0');
			end loop; 
			
			-- luego cargamos el archivo en la misma
			while (not endfile (bin_file)) loop
				readline (bin_file, current_line);
				hread(current_line, address);
				hread(current_line, datum);
				assert CONV_INTEGER(address(31 downto 0))<C_MEM_SIZE 
					report "Direccion fuera de rango en el fichero de la memoria"
					severity failure;
				memo( CONV_INTEGER( address(31 downto 2) ) ) <= datum;
			end loop;
			
			-- por ultimo cerramos el archivo y actualizamos el flag de memoria cargada
			file_close (bin_file);
			cargar := false;
			
			assert false report "Se han cargado la memoria" severity note;
		
		elsif falling_edge(clk) then			
			if (WrEn = '1') then
				assert ( CONV_INTEGER(Addr(31 downto 0)) <C_MEM_SIZE )
					report "Direccion fuera de rango en el fichero de la memoria"
					severity failure;
				memo( CONV_INTEGER( Addr(31 downto 2) ) ) <= DataIn;
			end if;
			 
	   end if;
	end process;
	
	DataOut <= memo( CONV_INTEGER( Addr(31 downto 2) ) ) when  CONV_INTEGER(Addr(31 downto 2)) < ((C_MEM_SIZE/4)-1) else x"FABADA00";
	
end Behavioral;
