--------------------------------------------------------------------------
--								  	--
--								  	--
--			   VHDL File Created by:			--
--		     	Aaron Snider & Ada Loveless			--
--									--
--									--
--			    Date last Modified:				--
--			       June 06 2025				--
--									--
--									--
--			VHDL Component Purpose:				--
--	   MUX with 2 Selector Inputs and 4 4 bit Value inputs		--
--									--
--									--
--------------------------------------------------------------------------

-------------------------------- Library ---------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------- Entity ---------------------------------

entity hex_mux is
port (
	hex_num3, hex_num2, hex_num1, hex_num0 		: in std_logic_vector(3 downto 0);	-- 4 x 4 Bit inputs
	mux_select					: in std_logic_vector(1 downto 0);	-- 2 Bit select signal
	hex_out						: out std_logic_vector(3 downto 0)	-- 4 Bit output
);

end hex_mux;

----------------------------- Architecture ------------------------------

architecture mux_logic of hex_mux is

begin

with mux_select(1 downto 0) select -- Selects signal based on mux_select value
hex_out <= 	hex_num0 when "00",
		hex_num1 when "01",
		hex_num2 when "10",
		hex_num3 when "11";

end mux_logic;
