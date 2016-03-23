library IEEE;
use IEEE.std_logic_1164.all;

entity controller is port(
  write_request : in std_logic ;
  read_request: in std_logic ;
  clk : in std_logic;
  ram_ready: in std_logic
  ) ;
end controller;

architecture behavioral of controller is
  constant start: integer := 0 ;
  constant read: integer := 1 ;
  constant write: integer := 2 ;
  constant hit: integer := 3 ;
  constant miss: integer := 4 ;
  constant ram_read: integer := 5 ;
begin
  process(clk)
    variable state: integer range 0 to 5 := start ;
    begin
      case state is
        when start =>
        if(write_request = '1' and read_request = '0')then
         state := write ;
        elsif( write_request = '0' and read_request = '1')then
          state := read ;
          else
            state := start ;
        end if;
        when others =>
          state := start ;
      end case ;
      
      end process ;
end behavioral ;
