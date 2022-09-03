Library IEEE;
USE IEEE.Std_logic_1164.all;


ENTITY ex_SCL is 
	port(
				SCL : out std_logic;
						
 	   	Clk_128 :in std_logic;
						
			 clk    :in  std_logic;
						
			 enable : in std_logic		
       );
END ex_SCL;
ARCHITECTURE Behavioral of ex_SCL is
 
signal  clock_delay : std_logic;
 
begin  
    process(Clk)
            begin 
                if rising_edge(clk) then
                 if (enable = '1') then
                   scl <= not clock_delay;
                 else
                   scl <= '1';
                 end if;
				   clock_delay <= clk_128;	  
                end if;
             end process;
end Behavioral; 