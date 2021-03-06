library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is port (
  clk: in std_logic;
  address: in std_logic_vector(9 downto 0);
  rw: in std_logic;
  data_in: in std_logic_vector( 31 downto 0 );
  data_ready: out std_logic;
  data_out:out std_logic_vector(31 downto 0)
  );
end ram;

architecture dataflow of ram is
type data_array_type is array ( 0 to 1023 ) of std_logic_vector(31 downto 0) ;
 
signal data_array:data_array_type := ( others => "11111111111111111111111111111111" );

begin
  data_out <= data_array(to_integer(unsigned(address))) ;
process(clk)
  begin
    if( clk'event and clk = '1' )then
      data_ready <= '0' ;
      if( rw = '1' )then
        data_array(to_integer(unsigned(address))) <= data_in ;
        data_ready <= '1' ;
      else
        data_ready <= '1' ;
      end if ;
    end if ;
  end process ;
end dataflow;


