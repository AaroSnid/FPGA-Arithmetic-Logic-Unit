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
--		     Full adder with 1 bit inputs			--
--									--
--									--
--------------------------------------------------------------------------


------------------------------ Libraries ---------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

------------------------------- Entity -----------------------------------

ENTITY Full_Adder_1Bit IS
	PORT
		(
			Input_A : IN std_logic;		-- Most significant input bit
			Input_B : IN std_logic;		-- Least significant input bit
			CARRY_IN : IN std_logic;	-- Carry input bit
			Sum_Output : OUT std_logic;	-- Sum of operation
			Carry_Output : OUT std_logic	-- Carry from operation
	
		);
END Full_Adder_1Bit;

----------------------------- Archetecture -------------------------------

ARCHITECTURE FAdder_1bit OF Full_Adder_1Bit IS
	SIGNAL HalfSum, HalfCarry, Full : std_logic;	-- Internal signals
							-- Half Sum & Carry: Carry signal from internal half adder
							-- Full: Temporary for AND of the carry
BEGIN

	-- Half Adder
	HalfSum <= (Input_A AND Input_B);
	HalfCarry <= (Input_A XOR Input_B);
	
	-- Full Adder Expansion
	Full <= (HalfCarry AND CARRY_IN);
	Sum_Output <= (HalfCarry XOR CARRY_IN);
	Carry_Output <= (Full OR HalfSum);

END FAdder_1bit;
