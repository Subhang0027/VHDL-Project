library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity temp_REG is 
port (
  temp : in std_logic_vector(15 downto 0);
  
  MSB  : out std_logic_vector(7 downto 0);
  
  LSB  : out std_logic);
end temp_reg;

Architecture behave of Temp_reg is

begin

MSB <= temp(15 downto 8);

LSB <= temp(7);

end behave;