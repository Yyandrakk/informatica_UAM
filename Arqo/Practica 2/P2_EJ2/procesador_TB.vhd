---------------------------------------------------------------------------------------------------
--
-- Title       : Test Bench for procesador
-- Design      : practica_1
-- Author      : alumnoeps
-- Company     : EPS - UAM
--
---------------------------------------------------------------------------------------------------
--
-- File        : $DSN\src\TestBench\procesador_TB.vhd
-- From        : $DSN\src\procesador.vhd
--
---------------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

	-- Add your library and packages declaration here ...

entity procesador_tb is
end procesador_tb;

architecture TB_ARCHITECTURE of procesador_tb is
	-- Component declaration of the tested unit
	component procesador
   port(
		Clk         : in  std_logic;
		Reset       : in  std_logic;
		-- Instruction memory
		I_Addr      : out std_logic_vector(31 downto 0);
		I_DataIn    : in  std_logic_vector(31 downto 0);
		-- Data memory
		D_Addr      : out std_logic_vector(31 downto 0);
		D_WrEn     	: out std_logic;
		D_DataOut   : out std_logic_vector(31 downto 0);
		D_DataIn    : in  std_logic_vector(31 downto 0)
   );
	end component;

	component Memoria
	generic (
		C_ELF_FILENAME     : string;
		C_MEM_SIZE         : integer
	);
	port (
		Clk                : in std_logic;			 
		Reset              : in std_logic;
		Addr               : in std_logic_vector(31 downto 0);
		WrEn              : in std_logic;
		DataIn             : in std_logic_vector(31 downto 0);
		DataOut            : out std_logic_vector(31 downto 0)
	);
   end component;

	signal Clk         : std_logic;
	signal Reset       : std_logic;
   -- Instruction memory
	signal I_Addr      : std_logic_vector(31 downto 0);
	signal I_DataIn    : std_logic_vector(31 downto 0);
	-- Data memory
	signal D_Addr      : std_logic_vector(31 downto 0);
	signal D_WrEn     : std_logic;
	signal D_DataOut   : std_logic_vector(31 downto 0);
	signal D_DataIn    : std_logic_vector(31 downto 0);		  
	
	constant tper_clk  : time := 50 ns;
	constant tdelay    : time := 90 ns;

begin
	  
	-- Unit Under Test port map
	UUT : procesador
		port map (
			Clk             => Clk,
			Reset           => Reset,
			-- Instruction memory
	      I_Addr          => I_Addr,
	      I_DataIn       => I_DataIn,
	      -- Data memory
	      D_Addr          => D_Addr,
	      D_WrEn         => D_WrEn,
	      D_DataOut       => D_DataOut,
	      D_DataIn        => D_DataIn
		);

	Inst_Mem_Instr : memoria
	generic map (
	   C_ELF_FILENAME     => "instrucciones",
--	   C_TARGET_SECTION   => ".text",
 --     C_BASE_ADDRESS     => 16#00000000#,
      C_MEM_SIZE         => 1024
 --     C_WAIT_STATES      => 0
   )
	port map (
		Clk                => Clk,			 
		Reset              => Reset,
		Addr               => I_Addr,
		WrEn              => '0',
		DataIn             => x"00000000",
		DataOut            => I_DataIn
	);

	Inst_Mem_Datos : memoria
	generic map (
	   C_ELF_FILENAME     => "datos",
--	   C_TARGET_SECTION   => ".data",
 --     C_BASE_ADDRESS     => 16#00000000#,
      C_MEM_SIZE         => 1024
 --     C_WAIT_STATES      => 0
   )	
	port map(
		Clk                => Clk,			 
		Reset              => Reset,
		Addr               => D_Addr,
		WrEn              => D_WrEn,
		DataIn             => D_DataOut,
		DataOut            => D_DataIn
	);

	process	
	begin		
		Clk <= '0';
		wait for tper_clk/2;
		Clk <= '1';
		wait for tper_clk/2; 		
	end process;
	
	process
	begin
		Reset <= '1';
		wait for tdelay;
		Reset <= '0';	   
		wait;
	end process;  	 

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_procesador of procesador_tb is
	for TB_ARCHITECTURE
		for UUT : procesador
			use entity work.procesador(procesador);
		end for;
	end for;
end TESTBENCH_FOR_procesador;

