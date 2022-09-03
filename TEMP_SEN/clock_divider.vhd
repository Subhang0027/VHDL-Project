library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY CLOCK_DIVIDER is
port(
 clk_50 : in std_logic;
 
 sclk_128,sclk_64,sample_clock,clk_400hz,clk_strobe: out std_logic
 
 );
 end clock_DIVIDER;
 
Architecture rtl of clock_divider is

signal timer : 	std_logic_vector(26 downto 0) := "000000000000000000000000000";

signal RESET :    std_logic;

begin

	process(clk_50,reset)
	
 begin
 
     if (reset='0')then
        timer <= "000000000000000000000000000";
     elsif clk_50'event and clk_50='1' then 
        timer <= timer + 1;
	  end if;
 end process;


sample_clock <= timer(1);

sclk_128 <= timer(6);

sclk_64 <= timer(5);

clk_400hz <= timer(16);

clk_strobe <= timer(25);

end rtl;
	 