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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/11/2022 13:29:53"
                                                            
-- Vhdl Test Bench template for design  :  TEMP_sen
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY TEMP_sen_vhd_tst IS
END TEMP_sen_vhd_tst;
ARCHITECTURE TEMP_sen_arch OF TEMP_sen_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_50 : STD_LOGIC;
SIGNAL LCD_BLON : STD_LOGIC;
SIGNAL LCD_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL LCD_E : STD_LOGIC;
SIGNAL LCD_ON : STD_LOGIC;
SIGNAL LCD_RS : STD_LOGIC;
SIGNAL LCD_RW : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL sample_clock : STD_LOGIC;
SIGNAL SCL : STD_LOGIC;
SIGNAL SDA : STD_LOGIC;
COMPONENT TEMP_sen
	PORT (
	clk_50 : IN STD_LOGIC;
	LCD_BLON : OUT STD_LOGIC;
	LCD_DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	LCD_E : OUT STD_LOGIC;
	LCD_ON : OUT STD_LOGIC;
	LCD_RS : OUT STD_LOGIC;
	LCD_RW : OUT STD_LOGIC;
	reset : IN STD_LOGIC;
	sample_clock : OUT STD_LOGIC;
	SCL : OUT STD_LOGIC;
	SDA : INOUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : TEMP_sen
	PORT MAP (
-- list connections between master ports and signals
	clk_50 => clk_50,
	LCD_BLON => LCD_BLON,
	LCD_DATA => LCD_DATA,
	LCD_E => LCD_E,
	LCD_ON => LCD_ON,
	LCD_RS => LCD_RS,
	LCD_RW => LCD_RW,
	reset => reset,
	sample_clock => sample_clock,
	SCL => SCL,
	SDA => SDA
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
  clk_50 <= '1';
  wait for 10 ns;
clk_50 <= '0';
 wait for 10 ns;
end process;
stim :process
begin
reset <='1';
sda <='0';
wait for 10 ns;
sda <= 'Z';
wait for 200 ns;



                    
                                                       
END PROCESS ;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END TEMP_sen_arch;
