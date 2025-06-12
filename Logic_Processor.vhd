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
--		     Select 1 of 4 gate operations 			--
--									--
--									--
--------------------------------------------------------------------------

------------------------------ Libraries ---------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------- Entity -----------------------------------

entity Logic_Processor is
port (
	logic_in0, logic_in1		: in std_logic_vector(3 downto 0); 	-- 2 x 4 bit inputs
	logic_select			: in std_logic_vector(1 downto 0);	-- 2 Bit gate select
	logic_out			: out std_logic_vector(3 downto 0)	-- Bitwise gate operation output
);
end Logic_Processor;

----------------------------- Archetecture -------------------------------

architecture Logic_Unit of Logic_Processor is

begin

with logic_select(1 downto 0) select	-- Bitwise Gate Operations based on logic_select signal
logic_out <=	(logic_in0 AND logic_in1) 	when "00",
		(logic_in0 OR logic_in1) 	when "01",
		(logic_in0 XOR logic_in1) 	when "10",
		(logic_in0 XNOR logic_in1) 	when "11";

end Logic_Unit;
