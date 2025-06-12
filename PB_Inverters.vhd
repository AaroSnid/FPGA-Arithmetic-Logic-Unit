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
--	   Inverting The Push Buttons For Active High Signals		--
--									--
--									--
--------------------------------------------------------------------------

------------------------------ Libraries ---------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

------------------------------- Entity -----------------------------------

ENTITY PB_Inverters IS
	PORT
	(
		pb_n : IN std_logic_vector(3 downto 0);	-- Inputs for push buttons 0, 1, 2, 3
		pb : OUT std_logic_vector(3 downto 0)	-- Outputs for inverted push button signals
	);
END PB_Inverters;

----------------------------- Archetecture -------------------------------

ARCHITECTURE gates OF PB_Inverters IS

BEGIN
	pb <= not(pb_n); -- Bitwise not operation for the signal

END gates;
