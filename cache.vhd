library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity cache is port (
clk:in std_logic ;
address : in std_logic ;
wren : in std_logic ;
wrdata: in std_logic ;
hit:out std_logic
);
end cache ;

architecture data_flow of cache is
  component data_array is port(
    clk: in std_logic;
    address: in std_logic_vector(5 downto 0);
    wren: in std_logic;
    wrdata:in std_logic_vector(31 downto 0);
    data: out std_logic_vector(31 downto 0)
  );
  end component ;
begin
end data_flow ;
  
    