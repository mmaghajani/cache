library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity cache is port (
clk:in std_logic ;
address : in std_logic_vector(9 downto 0 ) ;
wren : in std_logic ;
wrdata: in std_logic_vector(31 downto 0 ) ;
reset:in std_logic ;
invalidate:in std_logic ;
hit:out std_logic ;
rddata:out std_logic_vector(31 downto 0 )
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
  
  component tag_valid_array is port(
    clk: in std_logic;
    address: in std_logic_vector(5 downto 0);
    wren: in std_logic;
    reset_n: in std_logic;
    invalidate: in std_logic;
    wrdata:in std_logic_vector(3 downto 0);
    output: out std_logic_vector( 4 downto 0 )
    );
  end component ;
  
  component miss_hit_logic is port(
    tag: in std_logic_vector( 3 downto 0);
    w0: in std_logic_vector(4 downto 0);
    w1: in std_logic_vector(4 downto 0);
    hit: out std_logic;
    w0_valid: out std_logic;
    w1_valid: out std_logic 
    );
  end component ;
  
  component lru_array is port (
    clk: in std_logic ;
    address: in std_logic_vector(5 downto 0) ;
    read_w0:in std_logic ;
    read: in std_logic ;
    w1_select: out std_logic
  );
  end component ;
begin
end data_flow ;
  
    