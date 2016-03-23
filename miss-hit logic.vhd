library IEEE;
use IEEE.std_logic_1164.all;

entity miss_hit_logic is port (
  tag: in std_logic_vector( 3 downto 0);
  w0: in std_logic_vector(4 downto 0);
  w1: in std_logic_vector(4 downto 0);
  hit: out std_logic;
  w0_valid: out std_logic;
  w1_valid: out std_logic
  );
end miss_hit_logic;

architecture dataflow of miss_hit_logic is
begin

process
	  begin
	     if( tag = w0(3 downto 0) and w0(4) = '1' ) then
	       w1_valid <= '0' ;
	       w0_valid <= '1' ;
	       hit <= '1' ;
	     elsif( tag = w1( 3 downto 0) and w1(4) = '1' ) then
	       w1_valid <= '1' ;
	       w0_valid <= '0' ;
	       hit <= '1' ;
	     else
	       w1_valid <= '0' ;
	       w0_valid <= '0' ;
	       hit <= '1' ;	     
	     end if ;  
	  end process ;
end dataflow;


