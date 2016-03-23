library IEEE;
use IEEE.std_logic_1164.all;

entity controller is port(
  write_request : in std_logic ;
  read_request: in std_logic ;
  clk : in std_logic;
  ram_ready: in std_logic ;
  hit: in std_logic ;
  is_valid: in std_logic ;
  invalidate: out std_logic ;
  ram_write: out std_logic ;
  ram_read: out std_logic ;
  wren: out std_logic
  );
end controller;

architecture behavioral of controller is
  constant start: integer := 0 ;
  constant read: integer := 1 ;
  constant write: integer := 2 ;
  constant hit: integer := 3 ;
  constant miss: integer := 4 ;
  constant read_from_ram: integer := 5 ;
begin
  process(clk)
    variable state: integer range 0 to 5 := start ;
    begin
      case state is
        when start =>
          invalidate <= '0' ;
          ram_write <= '0' ;
          ram_read <= '0' ;
          wren <= '0' ;
        if(write_request = '1' and read_request = '0')then
         state := write ;
        elsif( write_request = '0' and read_request = '1')then
          state := read ;
          else
            state := start ;
        end if;
        when write =>
          invalidate <= '1' ;
          ram_write <= '1' ;
          ram_read <= '0' ;
          wren <= '0' ;
          state := start ;
        when read =>
          if( hit = '1' and is_valid = '1' )then
            state := start ;
          else
            state := miss ;
            end if;
        when miss =>
          ram_read = '1' ;
          if( ram_ready = '1' ) then
            state := read_from_ram ;
          end if ;
        when others =>
          state := start ;
      end case ;
      
      end process ;
end behavioral ;
