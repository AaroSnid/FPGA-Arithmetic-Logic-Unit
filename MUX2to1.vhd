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
--		   2:1 Multiplexer with 4 bit inputs			--
--									--
--									--
--------------------------------------------------------------------------

------------------------------ Libraries ---------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

------------------------------- Entity -----------------------------------

ENTITY MUX2to1 IS
	PORT
		(
			Data_in0, Data_in1 	: IN std_logic_vector(3 downto 0); 	-- 4 bit Input signals
			Selector 		: IN std_logic;				-- 1 Bit Selector symbol
			Data_out		: OUT std_logic_vector(3 downto 0)	-- 4 Bit Output signal
		);
END MUX2to1;

----------------------------- Archetecture -------------------------------

ARCHITECTURE Muxer OF MUX2to1 IS

BEGIN

with Selector select	-- Outputs data based on selector value
Data_out <=		Data_in0 when '0',
			Data_in1 when '1';


END Muxer;
