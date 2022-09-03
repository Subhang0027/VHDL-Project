LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY I2C_MASTER is
port (
      clk : IN STD_LOGIC;
		
      rst : IN STD_LOGIC;
		
		STROBE : IN STD_LOGIC;
		
      SDA : INOUT STD_LOGIC;
		
      ENABLE : OUT STD_LOGIC;
		
      DATA_BUS : out std_LOGIC_VECTOR(15 downto 0)
		);

END I2C_MASTER ;

ARCHITECTURE BEHAVE of I2C_MASTER  is

type I2C is (Idle,START,ADDRESS,S_ACK,MSB,M_ACK,LSB,N_ACK,STOP);

signal state      : I2c;

signal SDA_out    : std_logic;

signal SDA_in     : std_logic ;

signal sda_en     :std_logic := '0';

signal scl_en     : std_logic := '0';

signal ack_err    : std_logic;

signal bit_cnt    : integer range 0 to 7  := 7;

signal data_cnt   : integer range 0 to 15 := 15;

signal addr       : std_logic_vector(6 downto 0):= "1001000";

signal addr_rw    : std_logic_vector(7 downto 0);

signal temp       : std_logic_vector (15 downto 0);

  
BEGIN

  PROCESS(clk, rst)
   BEGIN
     IF(rst = '0') THEN                 
              state <= idle;
              scl_en	<= '1';
		        sda_en <= '1';	
              sda_out <= '1';                     
              bit_cnt <= 7;
		        data_cnt <= 15;
		        addr_rw <= addr & '1';
		        temp <= "0000000000000000";
		
	elsif(clk'event and clk = '1') then
	
	case state is 
-------------------------------------------------------------------------------------------------------------------------------	
	
	when IDLE =>
	              state <= idle;
					  scl_en	<= '1';
					  sda_en <= '1';	
					  sda_out <= '1';                     
					  bit_cnt <= 7;
					  data_cnt <= 15;
					  addr_rw <= addr & '1';
					  temp <= "0000000000000000";
	         if(strobe = '0') then 
		         state <= START;
	         else
		         state <= IDLE;
	         end if;
				
-------------------------------------------------------------------------------------------------------------------------------		
	
	when START =>
	             scl_en	<= '0';
	             sda_en <= '1';
		          sda_out <= '0' ;
   state <= ADDRESS;
	
-------------------------------------------------------------------------------------------------------------------------------		
	
	when ADDRESS =>
		          sda_out <= addr_rw(bit_cnt);
		          sda_en <= '1';
		       if (bit_cnt = 0) then 
		         state <= S_ACK;
	          else
	            bit_cnt <= bit_cnt-1;
		         state <= ADDRESS;
	          end if;
				 
-------------------------------------------------------------------------------------------------------------------------------		
	
	when S_ACK =>
		          sda_out <='1';
		          sda_en <= '0';
	           if sda = '0' then 
			       state <= MSB;
	           else
	             ack_err <= '1';
	             state <= MSB;
	            end if;
					
-------------------------------------------------------------------------------------------------------------------------------		 
	 
	when MSB =>
		        sda_out  <= '1';
		        sda_en <= '0';	
		     if data_cnt = 8 then
			    state <= M_ACK;
	        else 
			   data_cnt <= data_cnt-1;
				temp(data_cnt)<=sda_in;
			    state <= MSB;
	        end if;
	         
				 
-------------------------------------------------------------------------------------------------------------------------------		 
	 
	 when M_ACK =>
	             DATA_BUS(15 downto 8) <= temp(15 downto 8);
	             sda_out <= '0';
	             sda_en <= '1';
	 state <= LSB;
	 
-------------------------------------------------------------------------------------------------------------------------------	 
	 
	 when LSB =>
				    sda_out <= '1';
				    sda_en <= '0';
					 temp(data_cnt)<= sda_in;
	         if data_cnt = 0 then
			     state <= N_ACK ;
	         else
				 
		        data_cnt <= data_cnt-1;
		        state <= LSB;
	         end if;
				 
				
-------------------------------------------------------------------------------------------------------------------------------		
	
	when N_ACK =>
	             DATA_BUS(7 downto 0) <= temp(7 downto 0);
	             sda_out <= '1';
	             sda_en <= '1';
	state <= stop;
					 
-------------------------------------------------------------------------------------------------------------------------------		
	when stop =>
	           sda_out <= '1';
	           sda_en <= '1';
	           state <= idle;
				  
-------------------------------------------------------------------------------------------------------------------------------	
	
	when others => 
		         state <= idle;
	end case;
	
-------------------------------------------------------------------------------------------------------------------------------	
	

end if;

end process;

SDA_in <= SDA;

ENABLE <= clk when (scl_en='1') else '1';

SDA <= sda_out WHEN sda_en = '1' ELSE 'Z';

end BEHAVE;