library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_ram_tb is
    end entity;

architecture test_bench of cache_ram_tb is
    component ram_cache is port (
    clk:in std_logic ;
    addr : in std_logic_vector(9 downto 0 ) ;
    reset_n: in std_logic ;
    read:in std_logic ;
    write: in std_logic ;
    wrdata:in std_logic_vector(31 downto 0 ) ;
    rddata: out std_logic_vector(31 downto 0 ) ;
    hit: out std_logic
    );
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset_n, read, write : STD_LOGIC;
    signal addr: STD_LOGIC_VECTOR(9 downto 0);
    signal wrdata,rddata : STD_LOGIC_VECTOR(31 downto 0);
    signal hit : STD_LOGIC;

begin
    mapping : ram_cache port map (clk , addr , reset_n, read, write , wrdata,
    rddata, hit);

    addr <= STD_LOGIC_VECTOR(to_unsigned(0,10)),
            STD_LOGIC_VECTOR(to_unsigned(13,10)) after 500 ns;
            

    wrdata <= STD_LOGIC_VECTOR(to_unsigned(56,32)),
              STD_LOGIC_VECTOR(to_unsigned(98,32)) after 500 ns;
    write <= '0', '1' after 210 ns , '0' after 260 ns;
    read <= '1', '0' after 85 ns;
    reset_n <= '0';

    CLOCK:
    clk <= '1' after 25 ns when clk = '0' else
           '0' after 25 ns when clk = '1';
end test_bench;
