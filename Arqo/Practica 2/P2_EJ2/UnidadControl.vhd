----------------------------------------------------------------------
-- Fichero: UnidadControl.vhd
-- Descripción: Unidad de control

-- Autores: Oscar Garcia de Lara y Patricia Anza
-- Asignatura: ARQO 
-- Grupo de Prácticas:1312
-- Grupo de Teoría: 131
-- Práctica: 1
-- Ejercicio: 2
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UnidadControl is
	port (
		OPCode : in std_logic_vector(31 downto 26);
		Funct : in std_logic_vector(5 downto 0);
		MemToReg : out std_logic;
		MemWrite : out std_logic;
		ALUControl : out std_logic_vector(2 downto 0);
		ALUSrc : out std_logic;
		RegDest : out std_logic;
		RegWrite : out std_logic;
		PcSrc : out std_logic_vector(1 downto 0)
	);
end UnidadControl;


architecture Practica of UnidadControl is
begin

	process(OPCode, Funct)
	begin

	-- Cada señal tendrá un valor dependiendo de la operacion que realice,
	-- cuando OPCode vale "000000" la instruccion sera de tipo R (R-Type)
	-- y para saber la operacionq eu realiza deberemos fijarnos en  el valor 
	-- de Funct
	MemWrite <= '0'; -- R-type, para ver la operacion que realiza debemos fijarnos 
	MemToReg <= '0'; -- en el valor de Func.
	RegDest <= '0';
	ALUSrc <= '0';	
	PcSrc<="00";
	RegWrite<='0';
	ALUControl<="000";
	
	case OPCode is
	 when "000000" => RegDest <= '1';

							
			case Funct is						  
				when "100000" => ALUControl <= "010"; -- add
									  RegWrite <= '1';
									--  RegToPC <= '0';			
				when "100010" => ALUControl <= "110"; -- sub
									  RegWrite <= '1';
									 -- RegToPC <= '0';
				when "100100" => ALUControl <= "000"; -- and
									  RegWrite <= '1';
								--	  RegToPC <= '0';
				when "100101" => ALUControl <= "001"; -- or
									  RegWrite <= '1';
									--  RegToPC <= '0';
				when "100110" => ALUControl <= "011"; -- xor
									  RegWrite <= '1';
									--  RegToPC <= '0';									
				when others => ALUControl <= "000";  
									
			end case;
		
		when "100011" => 
						ALUControl <= "010"; -- lw
						MemToReg <='1';
						MemWrite <='0';
						ALUSrc   <='1';
						RegWrite <='1';
		when "101011" => 
						ALUControl <= "010"; -- sw
						MemToReg <='0';
						MemWrite <='1';
						ALUSrc   <='1';
						RegWrite <='0';
		when "000100" => 
						ALUControl <= "110"; -- beq
						MemToReg <='0';
						MemWrite <='0';
						ALUSrc   <='0';
						RegWrite <='0';
						PcSrc<= "11";
		when "000010" => 
						ALUControl <= "000"; --jump
						MemToReg <='0';
						MemWrite <='0';
						ALUSrc   <='0';
						RegWrite <='0';
					PcSrc <= "01";
		when "000101" =>
							ALUControl <= "110";--bne		
							PcSrc <="10";
		when "001010" => 
						ALUControl <= "111";  --slti
						MemToReg <='0';
						MemWrite <='0';
						ALUSrc   <='1';
						RegWrite <='1';	
		when "001111" => 
						ALUControl <= "100";  --lui
						MemToReg <='0';
						MemWrite <='0';
						ALUSrc   <='1';
						RegWrite <='1';
		when others => ALUControl <= "000"; --nop	
	end case;
end process;
end Practica;

