----------------------------------------------------------------------
-- Fichero: MicroMIPS.vhd
-- Descripción: procesador

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
use ieee.std_logic_arith.all;

entity procesador is
port(
		Clk : in std_logic; -- Reloj
		Reset : in std_logic; -- Reset activo a nivel bajo
		I_Addr : out std_logic_vector(31 downto 0); -- Dirección para la memoria de programa
		I_DataIn : in std_logic_vector(31 downto 0); -- Código de operación
		D_Addr : out std_logic_vector(31 downto 0); -- Dirección para la memoria de datos
		D_DataIn : in std_logic_vector(31 downto 0); -- Dato a leer en la memoria de datos
		D_DataOut : out std_logic_vector(31 downto 0); -- Dato a guardar en la memoria de datos
		D_WrEn : out std_logic --Habilita la escritura de datos
	  );
end procesador;

architecture procesador_arq of procesador is

-- Componente ALUMIPS.
component ALUMIPS is 
port(
	Op1 : in std_logic_vector (31 downto 0);
	Op2 : in std_logic_vector (31 downto 0);
	ALUControl : in std_logic_vector (2 downto 0);
	Res : out std_logic_vector (31 downto 0);
	Z : out std_logic
     );
end component;

-- Componente RegsMIPS.
component RegsMIPS is
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
end component;

-- Componente UnidadControl.
component UnidadControl is
	port (
	OPCode : in std_logic_vector(31 downto 26); --OPcode
	Funct : in std_logic_vector(5 downto 0); --Funct (Funcion)
	MemToReg : out std_logic; --De la memoria al registro
	MemWrite : out std_logic; --Escritura en la memoria
	ALUControl : out std_logic_vector(2 downto 0); --Operaciones de la ALU
	ALUSrc : out std_logic; --Selecciona operaciones de la ALU
	RegDest : out std_logic; --Registro destino
	RegWrite : out std_logic; --Escritura en el registro
	PcSrc: out std_logic_vector (1 downto 0)
	);
end component;

-- Señales internas.
signal xI_DataIn : std_logic_vector (31 downto 0); 
signal xI_Addr : std_logic_vector (31 downto 0);
signal xRd1 : std_logic_vector (31 downto 0); 
signal xRd2 : std_logic_vector (31 downto 0); 
signal xRes : std_logic_vector (31 downto 0); 
signal xALUControl : std_logic_vector (2 downto 0); 
signal muxMemToReg : std_logic; 
signal muxMemWrite : std_logic;  
signal xBranch : std_logic; 
signal muxALUsrc : std_logic; 
signal muxRegDest : std_logic; 
signal xRegWrite : std_logic; 
signal muxRegToPC : std_logic; 
signal muxExtCero : std_logic; 
signal muxJump : std_logic; 
signal muxPCToReg : std_logic; 
signal xExtSigno : std_logic_vector (31 downto 0); 
signal ExtensorSigno : std_logic_vector (31 downto 0); 
signal xSrc : std_logic_vector (31 downto 0); 
signal xJump: std_logic_vector (31 downto 0);
signal xNum : std_logic_vector (31 downto 0); 
signal xMemToReg : std_logic_vector (31 downto 0);
signal xPCToReg : std_logic_vector(31 downto 0);
signal rtPC : std_logic_vector(31 downto 0);
signal qTemp : std_logic_vector (31 downto 0);
signal muxPCSrc : std_logic; 
signal xNumPCSrc : std_logic_vector (31 downto 0); 
signal ExtensorCero : std_logic_vector (31 downto 0); 
signal xsuma : std_logic_vector (31 downto 0); 
signal xJoin : std_logic_vector (31 downto 0); 
signal xZ : std_logic; 
signal xReg : std_logic_vector(4 downto 0);
signal xA3 : std_logic_vector (4 downto 0);
--NUEVAS
signal salto : std_logic_vector (31 downto 0); 
signal xSalto : std_logic; 
signal xPcSrc: std_logic_vector (1 downto 0); 
signal xD_DataIn : std_logic_vector (31 downto 0); 
-- SEG IF/ID
signal xqTemp_if : std_logic_vector (31 downto 0);
signal xI_DataIn_if: std_logic_vector (31 downto 0);

signal muxALUsrc_id : std_logic; 
signal xALUControl_id : std_logic_vector (2 downto 0); 
signal muxRegDest_id : std_logic; 
signal muxMemToReg_id : std_logic; 
signal muxMemWrite_id : std_logic;
signal ExtensorSigno_id : std_logic_vector (31 downto 0);
signal xI_DataIn_id: std_logic_vector (31 downto 0);
signal xRd1_id : std_logic_vector (31 downto 0); 
signal xRd2_id : std_logic_vector (31 downto 0);
signal xRegWrite_id : std_logic;

signal xRegWrite_ex : std_logic;
signal muxMemToReg_ex : std_logic; 
signal muxMemWrite_ex : std_logic;
signal xRes_ex: std_logic_vector (31 downto 0); 
signal xRd2_ex : std_logic_vector (31 downto 0);
signal xA3_ex : std_logic_vector (4 downto 0);

signal xRegWrite_mem : std_logic;
signal muxMemToReg_mem : std_logic;
signal xRes_mem: std_logic_vector (31 downto 0); 
signal xA3_mem : std_logic_vector (4 downto 0);
signal xD_DataIn_mem : std_logic_vector (31 downto 0); 
--Practica 2
signal xPCenable : std_logic; 
signal xIf_Id_enable: std_logic; 
signal xBubble : std_logic; 
signal xFlagAdelantarR1: std_logic_vector(1 downto 0);
signal xFlagAdelantarR2: std_logic_vector(1 downto 0);
signal xRd1_adel : std_logic_vector (31 downto 0);
signal xRd2_adel : std_logic_vector (31 downto 0);
begin

-- Asignación de las señales.
xALUMIPS: ALUMIPS
	port map(
	Op1 => xRd1_adel,
	Op2 => xSrc, 
	ALUControl => xALUControl_id,
	Res => xRes,
	Z => xZ
	);
	   
xRegsMIPS: RegsMIPS
	port map(
	Clk => Clk,
	Reset => Reset,
	A1 => xI_DataIn_if(25 downto 21),
	Rd1 => xRd1,
	A2 => xI_DataIn_if(20 downto 16),
	Rd2 => xRd2,
	A3 => xA3_mem,
	Wd3 => xPCToReg,
	We3 => xRegWrite_mem
   );
			
xUnidadControl: UnidadControl
	port map(
	OPCode => xI_DataIn_if(31 downto 26),
	Funct => xI_DataIn_if(5 downto 0),
	MemToReg => muxMemToReg,
	MemWrite => muxMemWrite, 
	ALUControl => xALUcontrol,
	ALUSrc => muxALUsrc,
	RegDest => muxRegDest,
	RegWrite => xRegWrite,
	PcSrc => xPcSrc
	);
  	
D_WrEn <= muxMemWrite_ex;
D_DataOut <= xRd2_ex;
D_Addr <= xRes_ex;
I_Addr <= xI_Addr ;
xI_DataIn<= I_DataIn;
xD_DataIn<=D_DataIn;

pro_ExtensorSigno: process(xI_DataIn_if) -- Extenderá el signo del número, o bien positivo o bien negativo.
	begin     
		if xI_DataIn_if(15) = '0' then 
			Extensorsigno <= x"0000" & xI_DataIn_if(15 downto 0); -- Número positivo.
		else 
			Extensorsigno <= x"ffff" & xI_DataIn_if(15 downto 0); -- Número negativo.
		end if;
   end process; 
 
pro_ExtCero_ALUSrc : process (muxALUsrc_id ,ExtensorSigno_id, xRd2_adel) --ACTUALIZADO
	begin                             -- Este proceso es para el multiplexor de ALUSrc, cuando sea cero entra el  
		if muxALUsrc_id = '0' then        -- el valor del registro 2 sino, la extension de cero.En este multiplexor  
			xSrc <= xRd2_adel;               -- hemos incluido el multiplexor de ExtCero.
		else
			xSrc <= ExtensorSigno_id;
		end if;

	end process;
	
pro_MemToReg: process (muxMemToReg_mem, xD_DataIn_mem, xRes_mem) --ACTUALIZACION
	begin                              -- Este multiplexor es el que se encarga de MemToReg, si es 1 
		if muxMemToReg_mem = '1' then       -- entra el dato leido de la memoria, si es cero entra el resultado de la ALU.
			xPCToReg <= xD_DataIn_mem; -- el valor se guardará en xMEmToReg
		else
			xPCToReg <= xRes_mem;
		end if;
	end process;
	
pro_RegDest: process (muxRegDest_id, xI_DataIn_id) --ACTUALIZADO
	begin                                        -- Este es el multiplexor de RegDest, si recibe 1, xReg guardara xI_DataIn(15 downto 11)
		if muxRegDest_id = '1' then                  -- pero si recibe un cero xReg guardará xI_DataIn(20 downto 16).
			xA3 <= xI_DataIn_id(15 downto 11);		--ACT: Cambiamos xReg por xA3 
		else
			xA3 <= xI_DataIn_id(20 downto 16);
		end if;	
	end process;
	
xJoin <= xqTemp_if (31 downto 28) & xI_DataIn_if(25 downto 0) & "00";
 		
pro_salto: process (salto)
	begin
	if salto = x"0000" then 
		xSalto <= '0';
	else	
		xSalto <= '1';
	end if;
end process;	

pro_PcSrc_mux: process (xPcSrc, xSalto,qTemp,xsuma,xJoin)	
			begin
			if xPcSrc = "00" then
				rtPC<=qTemp;
			elsif xPcSrc = "01" then 
				rtPC<=xJoin;
			elsif xPcSrc = "10" and xSalto='1' then
				rtPC<=xsuma;
			elsif xPcSrc = "11" and xSalto='0' then 
				rtPC <=xsuma;
			else
				rtPC <= qTemp;
			end if;
end process;			
xExtSigno <= ExtensorSigno (29 downto 0) & "00";   --Esta linea asigna a xExtSigno el valor de ExtensorSigno (29 downto 0) y 
                                                   -- luego concatena 2 ceros al final, es un desplazador.
xsuma <= xExtSigno + xqTemp_if; -- Realiza la suma entre en valor de xExtSigno y qTemp

-- Contador 
pro_Contador: process (Clk, Reset) 
	begin
		if Reset = '1' then
			xI_Addr  <= (OTHERS => '0');
		elsif Clk='1' and Clk'event and xPCenable = '1' then
			xI_Addr  <= rtPC;
		end if;
   end process;
	
qTemp <=  xI_Addr  + 4;

-- Calculo BNE/BEQ 

 salto <= xRd1 - xRd2;
--SEGMENTACION
pro_IF_ID: process(Clk,Reset)
	begin
		if Reset = '1' then
			xqTemp_if <= (others => '0');
			xI_DataIn_if<= (others => '0');
		elsif rising_edge(clk) and xIf_Id_enable = '1'	then 
			xqTemp_if <= qTemp;
			xI_DataIn_if<= xI_DataIn;
		end if;
	
end process;

pro_ID_EX: process(Clk,Reset, xBubble)
	begin
		if Reset = '1' then
			muxALUsrc_id <= '0';
			xALUControl_id<= (others => '0');
			muxRegDest_id <= '0';
			muxMemToReg_id<= '0';
			muxMemWrite_id<= '0';
			xI_DataIn_id<= (others => '0');
			ExtensorSigno_id<= (others => '0');
			xRd1_id<= (others => '0');
			xRd2_id<= (others => '0');
			xRegWrite_id <= '0';
		elsif rising_edge(clk) then 
			if xBubble='0' then
				xI_DataIn_id<= xI_DataIn_if;
				xRegWrite_id <= xRegWrite;
				muxALUsrc_id <=muxALUsrc;
				xALUControl_id<= xALUControl;
				muxRegDest_id <= muxRegDest;
				muxMemToReg_id<= muxMemToReg;
				muxMemWrite_id<= muxMemWrite;
				ExtensorSigno_id<= ExtensorSigno;
				xRd1_id<= xRd1;
				xRd2_id<= xRd2;
			else
				muxALUsrc_id <= '0';
				xALUControl_id<= (others => '0');
				muxRegDest_id <= '0';
				muxMemToReg_id<= '0';
				muxMemWrite_id<= '0';
				xI_DataIn_id<= (others => '0');
				ExtensorSigno_id<= (others => '0');
				xRd1_id<= (others => '0');
				xRd2_id<= (others => '0');
				xRegWrite_id <= '0';
			end if;
		end if;
	
end process;

pro_EX_MEM: process(Clk,Reset)
	begin
		if Reset = '1' then
			xRegWrite_ex <= '0';
			muxMemToReg_ex<= '0';
			muxMemWrite_ex <= '0';
			xRes_ex<= (others => '0');
			xRd2_ex<= (others => '0');
			xA3_ex<= (others => '0');
		elsif rising_edge(clk)	then 
			xRegWrite_ex <= xRegWrite_id;
			muxMemToReg_ex<= muxMemToReg_id;
			muxMemWrite_ex <= muxMemWrite_id;
			xRes_ex<= xRes;
			xRd2_ex<= xRd2_adel;
			xA3_ex<= xA3;
		end if;
	
end process;

pro_MEM_WB: process(Clk,Reset)
	begin
		if Reset = '1' then
			xRegWrite_mem <= '0';
			muxMemToReg_mem<= '0';
			xRes_mem <= (others => '0');
			xA3_mem<= (others => '0');
			xD_DataIn_mem<= (others => '0');
		elsif rising_edge(clk)	then 
			xRegWrite_mem <= xRegWrite_ex;
			muxMemToReg_mem<= muxMemToReg_ex;
			xRes_mem <= xRes_ex;
			xA3_mem<= xA3_ex;
			xD_DataIn_mem<= xD_DataIn;
		end if;
	
end process;

riesgo_lw:	process(xI_DataIn_if, xRegWrite_ex, xA3,xI_DataIn_id)
		begin
			if xI_DataIn_id(31 downto 26)="100011" and xRegWrite_id= '1' and xA3/= "00000" and xA3 = xI_DataIn_if(25 downto 21)  then
				xPCenable <= '0';	
				xIf_Id_enable <= '0';
				xBubble <= '1';
			elsif xI_DataIn_id(31 downto 26)="100011" and xRegWrite_id = '1' and xA3/= "00000" and xA3 = xI_DataIn_if(20 downto 16) then
				xPCenable <= '0';	
				xIf_Id_enable <= '0';
				xBubble <= '1';	
			else
				xPCenable <= '1';	
				xIf_Id_enable <= '1';
				xBubble <= '0';
			end if;
	end process;	

adelatamiento: process(xRegWrite_ex, xA3_ex,xI_DataIn_id,xRegWrite_mem,xA3_mem)
	begin

		if xRegWrite_ex = '1' and xA3_ex/= "0000"  and xA3_ex = xI_DataIn_id(25 downto 21) then
					xFlagAdelantarR1<="01";
		elsif xRegWrite_mem = '1' and xA3_mem/= "0000"  and xA3_mem = xI_DataIn_id(25 downto 21) then
					xFlagAdelantarR1<="10";
		else 
			xFlagAdelantarR1<="00";			
		end if;			
		if xRegWrite_ex = '1' and xA3_ex/= "0000"  and xA3_ex = xI_DataIn_id(20 downto 16) then
					xFlagAdelantarR2<="01";
		elsif xRegWrite_mem = '1' and xA3_mem/= "0000"  and xA3_mem = xI_DataIn_id(20 downto 16) then
					xFlagAdelantarR2<="10";			
		else 
			xFlagAdelantarR2<="00";
		end if;			

end process;

mux_adelantar_r1:process(xFlagAdelantarR1,xRd1_id,xRes_ex,xRes_mem)
	begin
			if xFlagAdelantarR1 = "00" then
				xRd1_adel<=xRd1_id;
			elsif xFlagAdelantarR1 = "01" then 
				xRd1_adel<=xRes_ex;
			elsif xFlagAdelantarR1 = "10" then
				xRd1_adel<=xPCToReg;
			else
				xRd1_adel <= xRd1_id;
			end if;
end process;

mux_adelantar_r2:process(xFlagAdelantarR2,xRd2_id,xRes_ex,xRes_mem)
	begin
			if xFlagAdelantarR2 = "00" then
				xRd2_adel<=xRd2_id;
			elsif xFlagAdelantarR2 = "01" then 
				xRd2_adel<=xRes_ex;
			elsif xFlagAdelantarR2 = "10" then
				xRd2_adel<=xPCToReg;
			else
				xRd2_adel <= xRd2_id;
			end if;
end process;
end procesador_arq;
