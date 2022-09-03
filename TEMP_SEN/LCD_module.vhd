LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

	
ENTITY LCD_MODULE IS
PORT(   
		
		CLK		: IN STD_LOGIC;
		
		RESET     : in std_logic;
		
		MSB   : in std_logic_vector(11 downto 0);
		
		LSB  : in std_logic;
		
		--LCD Control Signals
		LCD_E 	: OUT STD_LOGIC;
		
		LCD_RW 	: OUT STD_LOGIC;
		
		LCD_RS 	: OUT STD_LOGIC;
		
		LCD_ON   : OUT std_logic;
		
		LCD_BLON : OUT std_logic;
		
		--LCD Data Signals
		LCD_DATA 	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		
end LCD_MODULE;

	--Define The Architecture Of The Entity
ARCHITECTURE behave of LCD_MODULE IS
type LCD is (idle,fun_set,dis_on,dis_clear,mode_set,write_T,write_E,write_M,write_P --- 
             ,write_equal,write_MSB_1,write_MSB_2,write_MSB_3,                      --- states for the LCD DISPLAY
              write_dot,write_LSB,write_degree,write_C,return_home,drop_LCD_E,hold);--- 
signal state , next_command        : LCD;

BEGIN

PROCESS(clk,reset)

BEGIN

if (RESET='0') then
 LCD_E <= '1';
	LCD_RS <= '0';
	LCD_RW <= '0';
	LCD_ON <= '1';
	LCD_BLON <= '1';
	state <=idle;
	next_command <= idle;

elsif (clk'EVENT) AND (clk = '1') then

	
 case state is
 
------------------------------------------------------------------------------------------------------------ 
                   --IDLE STATE
								when idle =>
												LCD_E  <= '1';
												LCD_RS <= '0';
												LCD_RW <= '0';
												state<=drop_LCD_E;
								next_command <= fun_set;
					 
------------------------------------------------------------------------------------------------------------
	                --FUNCTION SET STATE
								when fun_set =>
												LCD_E  <='1';
												LCD_RS <= '0';
												LCD_RW <= '0';
												LCD_DATA <= "00111000";
												state<=drop_LCD_E;
								next_command <= dis_clear;
		
------------------------------------------------------------------------------------------------------------
                    --DISPLAY CLEAR STATE
								when dis_clear =>
													LCD_E  <= '1';
													LCD_RS <= '0';
													lcd_rw <= '0';
													LCD_DATA <= x"01"; 
													state<=drop_LCD_E;		
								next_command <= dis_on;
	  
------------------------------------------------------------------------------------------------------------	  
	  	              --DISPLAY ON STATE
								when dis_on =>
												LCD_E  <= '1';
												LCD_RS <= '0';
												LCD_RW <= '0';
												LCD_DATA<= x"0C";
												state<=drop_LCD_E;
								next_command <= mode_set;
	  
------------------------------------------------------------------------------------------------------------	  
	                  --MODE SET STATE
								when mode_set =>
													LCD_E  <= '1';
													LCD_RS <= '0';
													LCD_RW <= '0';
													LCD_DATA <="00000110";
													state<=drop_LCD_E;
								next_command <= write_T;
	 
------------------------------------------------------------------------------------------------------------ WRITING DATA TO DATA BUS
	                   
								when write_T => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <= x"54";
														state<=drop_LCD_E;
								next_command <= write_E;
	  
------------------------------------------------------------------------------------------------------------	 
	 
								when write_E => 
													LCD_E  <= '1';
													LCD_RS <= '1';
													LCD_RW <= '0';
													LCD_DATA  <= x"45";
													state<= drop_LCD_E;
								next_command <= write_M;
	
------------------------------------------------------------------------------------------------------------	 
	 
								when write_M => 
													LCD_E  <= '1';
													LCD_RS <= '1';
													LCD_RW <= '0';
													LCD_DATA  <=  x"4D";
													state<= drop_LCD_E;
								next_command <= write_P;
	
------------------------------------------------------------------------------------------------------------	 
	 
								when write_P => 
													LCD_E  <= '1';
													LCD_RS <= '1';
													LCD_RW <= '0';
													LCD_DATA  <=  x"50";
													state<= drop_LCD_E;
								next_command <= write_equal;
	 
------------------------------------------------------------------------------------------------------------	 
	 
								when write_equal => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <=  x"3D";
														state<= drop_LCD_E;
								next_command <= write_MSB_1;
	
------------------------------------------------------------------------------------------------------------	 
	 
								when write_MSB_1 => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <=  "00101011";
														state<= drop_LCD_E;
								next_command <= write_MSB_2; 
	 
------------------------------------------------------------------------------------------------------------	 
	 
								when write_MSB_2 => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <=  "0011" & msb(7 downto 4);
														state<= drop_LCD_E;
								next_command <= write_MSB_3;
	
------------------------------------------------------------------------------------------------------------	 
	
								when write_MSB_3 => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <=  "0011" & msb(3 downto 0);
														state<= drop_LCD_E;
								next_command <= write_dot; 
	
------------------------------------------------------------------------------------------------------------	 
	
								when write_dot=>
														LCD_E  <= '1';
														LCD_RS <='1';
														LCD_RW <='0';
														LCD_DATA <= x"2E";
														state <= drop_LCD_E;
								next_command <= write_LSB;
	 
------------------------------------------------------------------------------------------------------------	 
	 
								when write_LSB => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
																	if (lsb = '0') then 
																		LCD_DATA <=  x"30";
																	elsif(lsb = '1') then
																		LCD_DATA  <=  x"35";
																	end if;
														state<= drop_LCD_E;
								next_command <= write_degree;
	 
------------------------------------------------------------------------------------------------------------	  
	 
								when write_degree => 
														LCD_E  <= '1';
														LCD_RS <= '1';
														LCD_RW <= '0';
														LCD_DATA  <=   x"DF";
														state<= drop_LCD_E;
								next_command <= write_C;
	 
------------------------------------------------------------------------------------------------------------	 
	 
								when write_C => 
													LCD_E  <= '1';
													LCD_RS <= '1';
													LCD_RW <= '0';
													LCD_DATA  <= x"43";
													state<=drop_LCD_E;
								next_command <= return_home;
	 
------------------------------------------------------------------------------------------------------------	RETURN HOME 
	 
								when return_home => 
														LCD_E <= '0';
														LCD_RS <= '0';
														LCD_RW <= '0';
														LCD_DATA <= "00000010";
														state <= idle;
								next_command <= idle;
	 
------------------------------------------------------------------------------------------------------------ 
   
								when drop_LCD_E =>
														LCD_E <= '0';
														LCD_BLON <= '1';
														LCD_ON   <= '1';
														state <= hold;
														
------------------------------------------------------------------------------------------------------------ 			
    
								when hold =>
												state <= next_command;
												LCD_BLON <= '1';
												LCD_ON   <= '1';
												
------------------------------------------------------------------------------------------------------------
			
								when others => null;
	
------------------------------------------------------------------------------------------------------------	
    

   

	end case;	
end if;

end process;
	
end behave;