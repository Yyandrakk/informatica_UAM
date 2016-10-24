----------------------------------------------------------------------
-- Fichero: ALUMIPS.vhd
-- Descripción: Alu

-- Autores: Oscar Garcia de Lara y Patricia Anza
-- Asignatura: ARQO 
-- Grupo de Prácticas:1312
-- Grupo de Teoría: 131
-- Práctica: 1
-- Ejercicio: 2
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Alumips is
port(
       Op1 : in std_logic_vector (31 downto 0); -- Operando 1
        Op2 : in std_logic_vector (31 downto 0); -- Operando 1
        ALUControl : in std_logic_vector (2 downto 0); -- Control
        Res : out std_logic_vector (31 downto 0); --Resultado
        Z : out std_logic --Bandera de salida
        );
        end Alumips;


architecture Practica of Alumips is
 -- Señales auxiliares
    signal OP1x: signed (31 downto 0);
    signal OP2x: signed (31 downto 0);
    signal Resx: std_logic_vector (31 downto 0);
    signal Aux: std_logic_vector (31 downto 0); 
		
begin 
-- Asignacion de las señales auxiliares
    OP1x <= signed (Op1); -- OP1x recibe el valor de Op1 con signo 
    OP2x <= signed (Op2); -- y lo mismo sucede con OP2x
    Res <= Resx;
	
	 
	 
    
with ALUControl select
    
    Resx <= OP1x + OP2x when "010", -- Dependiendo del valor de ALUControl Resx asignado una
              OP1x - OP2x when "110",-- operaciones diferentes
              OP1 AND OP2 when "000",
              OP1 OR OP2  when "001",
				  OP1 XOR OP2  when "011",
				  OP1 + (OP2(15 downto 0) & x"0000") when "100",--lui
              --OP1 NOR OP2 when "101",
              Aux when others; --stli
				  
    -- Aux recibira el resultado 0x1 cuando el operando 1 sea menor que el operando dos y si 
	 -- es al contrario recibira el valor 0x0
  
    Aux <=      "00000000000000000000000000000001" when OP1x < OP2x else "00000000000000000000000000000000";
              
              
process (Resx)
begin
    if Resx = "00000000000000000000000000000000" then  -- Cuando el resultado sea 0x0 la señal de bandera
        z<='1';                                        -- recibira el valor '1' y si es distinto de 0x0
    else                                               -- recibira el vaor '0'
        z<='0';
    end if;
end process;
    
end Practica;
	 