library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity data_array is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  wren: in std_logic;
  wrdata:in std_logic_vector(31 downto 0);
  data: out std_logic_vector(31 downto 0);
  data_array_ready: out std_logic
  );
end data_array;

architecture dataflow of data_array is

type arrayData is array ( 0 to 63 ) of std_logic_vector(31 downto 0) ;
 
signal w_array:arrayData := (others => "00000000000000000000000000000000" ) ;

begin
  data <= w_array(to_integer(unsigned(address))) ;
	process( clk )
	  begin
	   if(clk'event AND clk='1') then
	     data_array_ready <= '1' ;
	     if( wren = '1' ) then
	       w_array(to_integer(unsigned(address))) <= wrdata ;
	       data_array_ready <= '1' ;
	     end if ;
	   end if ;  
	  end process ;
	
	
end dataflow;
