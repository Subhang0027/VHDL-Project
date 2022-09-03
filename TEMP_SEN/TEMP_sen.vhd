-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
-- CREATED		"Wed May 11 22:23:06 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY TEMP_sen IS 
	PORT
	(
		reset :  IN  STD_LOGIC;
		clk_50 :  IN  STD_LOGIC;
		SDA :  INOUT  STD_LOGIC;
		SCL :  OUT  STD_LOGIC;
		LCD_E :  OUT  STD_LOGIC;
		LCD_RW :  OUT  STD_LOGIC;
		LCD_RS :  OUT  STD_LOGIC;
		LCD_ON :  OUT  STD_LOGIC;
		LCD_BLON :  OUT  STD_LOGIC;
		sample_clock :  OUT  STD_LOGIC;
		LCD_DATA :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END TEMP_sen;

ARCHITECTURE bdf_type OF TEMP_sen IS 

COMPONENT i2c_master
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 SDA : INOUT STD_LOGIC;
		 ENABLE : OUT STD_LOGIC;
		 DATA_BUS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lcd_module
	PORT(CLK : IN STD_LOGIC;
		 RESET : IN STD_LOGIC;
		 LSB : IN STD_LOGIC;
		 MSB : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 LCD_E : OUT STD_LOGIC;
		 LCD_RW : OUT STD_LOGIC;
		 LCD_RS : OUT STD_LOGIC;
		 LCD_ON : OUT STD_LOGIC;
		 LCD_BLON : OUT STD_LOGIC;
		 LCD_DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT bin8bcd
	PORT(bin : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 bcd : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT clock_divider
	PORT(clk_50 : IN STD_LOGIC;
		 sclk_128 : OUT STD_LOGIC;
		 sclk_64 : OUT STD_LOGIC;
		 sample_clock : OUT STD_LOGIC;
		 clk_400hz : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ex_scl
	PORT(Clk_128 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 SCL : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT temp_reg
	PORT(temp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 LSB : OUT STD_LOGIC;
		 MSB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_inst : i2c_master
PORT MAP(clk => SYNTHESIZED_WIRE_9,
		 rst => reset,
		 SDA => SDA,
		 ENABLE => SYNTHESIZED_WIRE_7,
		 DATA_BUS => SYNTHESIZED_WIRE_8);


b2v_inst1 : lcd_module
PORT MAP(CLK => SYNTHESIZED_WIRE_1,
		 RESET => reset,
		 LSB => SYNTHESIZED_WIRE_2,
		 MSB => SYNTHESIZED_WIRE_3,
		 LCD_E => LCD_E,
		 LCD_RW => LCD_RW,
		 LCD_RS => LCD_RS,
		 LCD_ON => LCD_ON,
		 LCD_BLON => LCD_BLON,
		 LCD_DATA => LCD_DATA);


b2v_inst2 : bin8bcd
PORT MAP(bin => SYNTHESIZED_WIRE_4,
		 bcd => SYNTHESIZED_WIRE_3);


b2v_inst3 : clock_divider
PORT MAP(clk_50 => clk_50,
		 sclk_128 => SYNTHESIZED_WIRE_9,
		 sclk_64 => SYNTHESIZED_WIRE_6,
		 sample_clock => sample_clock,
		 clk_400hz => SYNTHESIZED_WIRE_1);


b2v_inst4 : ex_scl
PORT MAP(Clk_128 => SYNTHESIZED_WIRE_9,
		 clk => SYNTHESIZED_WIRE_6,
		 enable => SYNTHESIZED_WIRE_7,
		 SCL => SCL);


b2v_inst5 : temp_reg
PORT MAP(temp => SYNTHESIZED_WIRE_8,
		 LSB => SYNTHESIZED_WIRE_2,
		 MSB => SYNTHESIZED_WIRE_4);


END bdf_type;