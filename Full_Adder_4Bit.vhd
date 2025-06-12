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
--	      4 Bit Full Adder Made of 1 Bit Full Adders		--
--									--
--									--
--------------------------------------------------------------------------


------------------------------ Libraries ---------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

------------------------------- Entity -----------------------------------

ENTITY Full_Adder_4Bit IS
	PORT
		(
			BUS0_b0 : IN std_logic;		-- 1st Bit of Bus0
			BUS0_b1 : IN std_logic;		-- 1st Bit of Bus1
			BUS1_b0 : IN std_logic;		-- 2nd Bit of Bus0
			BUS1_b1 : IN std_logic;		-- 2nd Bit of Bus1
			BUS2_b0 : IN std_logic;		-- 3rd Bit of Bus0
			BUS2_b1 : IN std_logic;		-- 3rd Bit of Bus1
			BUS3_b0 : IN std_logic;		-- 4th Bit of Bus0
			BUS3_b1 : IN std_logic;		-- 4th Bit of Bus1
			Carry_in: IN std_logic;		-- Carry from previous operation
			
			SUM 		: OUT std_logic_vector(3 downto 0); 	-- Total sum of the four bits excluding the carry
			Carry_Out3	: OUT std_logic 			-- Carry if overflow the 4th bit
			
		);
END Full_Adder_4Bit;

----------------------------- Archetecture -------------------------------

ARCHITECTURE FAdder_4bit OF Full_Adder_4Bit IS

----------------------------- Components ---------------------------------

	component Full_Adder_1Bit Port (		-- import 1 bit adder component to use to build the 4 bit adder
		Input_A : IN std_logic;		-- Most significant input bit
		Input_B : IN std_logic;		-- Least significant input bit
		CARRY_IN : IN std_logic;	-- Carry input bit
		Sum_Output : OUT std_logic;	-- Sum of operation
		Carry_Output : OUT std_logic	-- Carry from operation
	);
	end component;
	
--------------------------- Implementation -------------------------------	
	
	SIGNAL Carry_Out0, Carry_Out1, Carry_Out2: std_logic; -- Temporary signals to store overflow carry output from corresponding adder
BEGIN
	
	INST1 : Full_Adder_1Bit Port Map(BUS0_b0, BUS0_b1, Carry_in, Sum(0), Carry_Out0);	--1 Bit adder operation 1
	INST2 : Full_Adder_1Bit Port Map(BUS1_b0, BUS1_b1, Carry_Out0, Sum(1), Carry_Out1);	--1 Bit adder operation 2
	INST3 : Full_Adder_1Bit Port Map(BUS2_b0, BUS2_b1, Carry_Out1, Sum(2), Carry_Out2);	--1 Bit adder operation 3
	INST4 : Full_Adder_1Bit Port Map(BUS3_b0, BUS3_b1, Carry_Out2, Sum(3), Carry_Out3);	--1 Bit adder operation 4


END FAdder_4bit;
