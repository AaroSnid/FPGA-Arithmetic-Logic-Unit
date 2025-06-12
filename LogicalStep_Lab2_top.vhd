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
--	    Top Level ALU Circuit Synthesis From Components		--
--									--
--									--
--------------------------------------------------------------------------


------------------------------ Libraries ---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------- Entity -----------------------------------

entity LogicalStep_Lab2_top is port (
	clkin_50		: in	std_logic;			-- Clock Signal
	pb_n			: in	std_logic_vector(3 downto 0);	-- The push button inputs
 	sw   			: in 	std_logic_vector(7 downto 0); 	-- The switch inputs
   	leds			: out	std_logic_vector(7 downto 0); 	-- for displaying the switch content
   	seg7_data 		: out	std_logic_vector(6 downto 0); 	-- 7-bit outputs to a 7-segment
	seg7_char1  		: out	std_logic;			-- seg7 digit1 selector
	seg7_char2  		: out	std_logic			-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is

--------------------------------------------------------------------
-- 			Components Used 			 ---
--------------------------------------------------------------------

component SevenSegment port (
	hex   		:  in  std_logic_vector(3 downto 0);   	-- The 4 bit data to be displayed
	sevenseg 	:  out std_logic_vector(6 downto 0)    	-- 7-bit outputs to a 7-segment
   ); 
end component;
	
component segment7_mux port (
	clk : in std_logic := '0';			-- Clock signal
	DIN2 : in std_logic_vector(6 downto 0);
	DIN1 : in std_logic_vector(6 downto 0);
	DOUT : out std_logic_vector(6 downto 0);
	DIG1 : out std_logic;
	DIG2 : out std_logic
   ); 
end component;
	
component PB_Inverters port(
	pb_n : IN std_logic_vector(3 downto 0);		-- Inputs for push buttons 0, 1, 2, 3
	pb : OUT std_logic_vector(3 downto 0)		-- Outputs for inverted push button signals
	);
end component;
	
component Logic_Processor port(
	logic_in0, logic_in1		: in std_logic_vector(3 downto 0); 	-- 2 x 4 bit inputs
	logic_select			: in std_logic_vector(1 downto 0);	-- 2 Bit gate select
	logic_out			: out std_logic_vector(3 downto 0)	-- Bitwise gate operation output
	);
end component;
	
component Full_Adder_4Bit port (
	BUS0_b0 	: IN std_logic;			-- 1st Bit of Bus0
	BUS0_b1 	: IN std_logic;			-- 1st Bit of Bus1
	BUS1_b0 	: IN std_logic;			-- 2nd Bit of Bus0
	BUS1_b1 	: IN std_logic;			-- 2nd Bit of Bus1
	BUS2_b0 	: IN std_logic;			-- 3rd Bit of Bus0
	BUS2_b1 	: IN std_logic;			-- 3rd Bit of Bus1
	BUS3_b0 	: IN std_logic;			-- 4th Bit of Bus0
	BUS3_b1 	: IN std_logic;			-- 4th Bit of Bus1
	Carry_in	: IN std_logic;			-- Carry from previous operation
			
	SUM 		: OUT std_logic_vector(3 downto 0); 	-- Total sum of the four bits excluding the carry
	Carry_Out3	: OUT std_logic 			-- Carry if overflow the 4th bit
   ); 
   end component;
	
component MUX2to1 port (
	Data_in0, Data_in1 	: IN std_logic_vector(3 downto 0); 	-- 4 bit Input signals
	Selector 		: IN std_logic;				-- 1 Bit Selector symbol
	Data_out		: OUT std_logic_vector(3 downto 0)	-- 4 Bit Output signal
   ); 
end component;
	
------------------------------------------------------------------
--			Signals					--
------------------------------------------------------------------

--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR

	signal hex_A		: std_logic_vector(3 downto 0); -- 4 Bit input from switches 3 (MSB) to 0 (LSB)
	signal hex_B		: std_logic_vector(3 downto 0); -- 4 Bit input from switches 7 (MSB) to 4 (LSB)
	
	signal seg7_A		: std_logic_vector(6 downto 0); -- Most significant 7 segment display output
	signal seg7_B		: std_logic_vector(6 downto 0); -- Least significant 7 segment display output
	
	signal pb		: std_logic_vector(3 downto 0); -- Push Button inputs
	
	signal SUM		: std_logic_vector(3 downto 0); -- Sum from the 4 bit adder
	signal Carry		: std_logic;			-- Carry from the 4 bit adder
	signal Total		: std_logic_vector(3 downto 0); -- To store 4 bit value of carry
	
	Signal MuxAOut		: std_logic_vector(3 downto 0); -- To signal for seven segment digit A selection
	Signal MuxBOut		: std_logic_vector(3 downto 0); -- To signal for seven segment digit B selection
	
------------------------------------------------------------------
-- 				Circuit 			--
------------------------------------------------------------------

begin
	hex_A <= sw(3 downto 0);	-- Gets the binary input from switches 3 to 0
	hex_B <= sw(7 downto 4);	-- Gets the binary input from switches 7 to 4
	
	Total <= "000" & Carry;		-- Concatinates the carry value into a 4 bit signal

------------------------------------------------------------------
--                    COMPONENT HOOKUP				--
------------------------------------------------------------------

	ButtonInverter: PB_Inverters port map(pb_n, pb); 					-- Invert the push button inputs for active high
	AdderModule: Full_Adder_4Bit port map(hex_B(0), hex_A(0), hex_B(1), hex_A(1), hex_B(2), hex_A(2), hex_B(3), hex_A(3), '0', SUM, Carry); -- Adds the hex_A and hex_B digits, with appropriate Sum and carry outputs

	Mux2to1A: MUX2to1 port map(hex_a, SUM, pb(2), MuxAOut);					-- Selection of digit value for digit A based on pb3 input, defaults to hex_A value
	Mux2to1B: MUX2to1 port map(hex_b, Total, pb(2), MuxBOut);				-- Selection of digit value for digit B based on pb3 input, defaults to hex_B value
	
	Digit0: SevenSegment port map(MuxAOut, seg7_A);						-- Maps the digit to the binary LED representation for the 7 segment display A
	Digit1: SevenSegment port map(MuxBOut, seg7_B);						-- Maps the digit to the binary LED representation for the 7 segment display B
	
	Display: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data(6 downto 0), seg7_char1, seg7_char2); -- To drive the display with the currently selected values
	
	Logic: Logic_Processor port map(hex_B, hex_A, pb(1 downto 0), leds(3 downto 0)); 	-- Selection for logic operation based on pb[0, 1]
	
 
end SimpleCircuit;

