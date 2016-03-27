library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is port (
  clk: in std_logic ;
  address: in std_logic_vector(5 downto 0) ;
  read_w0:in std_logic ;
  read: in std_logic ;
  w1_select: out std_logic
  );
end lru_array;

architecture dataflow of lru_array is
type counter_type is array (0 to 63 , 0 to 1 ) of integer ;
signal counter: counter_type := (others => (0,0));
begin
process(clk)
  begin
    if( clk'event and clk = '1' )then      
      if( read = '1' )then
        if( read_w0 = '1' )then
          counter(to_integer(unsigned(address)) , 0 ) <= counter(to_integer(unsigned(address)) , 0 ) + 1 ;
        else
          counter(to_integer(unsigned(address)) , 1 ) <= counter(to_integer(unsigned(address)) , 1 ) + 1 ;
        end if ;
      else
        if( counter(to_integer(unsigned(address)) , 1 ) > counter(to_integer(unsigned(address)) , 0 ) )then
          w1_select <= '0' ;
          counter(to_integer(unsigned(address)) , 0 ) <= 0 ;
        else
          w1_select <= '1' ;
          counter(to_integer(unsigned(address)) , 1 ) <= 0 ;
        end if ;
      end if ;
    end if ;
  end process ;
end dataflow;


