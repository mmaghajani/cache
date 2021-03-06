library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_tb is
    end cache_tb;

architecture test_bench of cache_tb is
    component cache is port (
      clk:in std_logic ;
      cpu_address : in std_logic_vector(9 downto 0 ) ;
      wren : in std_logic ;
      wrdata: in std_logic_vector(31 downto 0 ) ;
      reset:in std_logic ;
      read_cache: in std_logic ;
      invalidate:in std_logic ;
      hit:out std_logic ;
      rddata:out std_logic_vector(31 downto 0 ) ; 
      data_ready: out std_logic
    );
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal wren, reset_n : STD_LOGIC;
    signal full_address : STD_LOGIC_VECTOR(9 downto 0);
    signal wrdata : STD_LOGIC_VECTOR(31 downto 0);
    signal read_cache ,invalidate: STD_LOGIC;
    signal data: STD_LOGIC_VECTOR(31 downto 0);
    signal hit: STD_LOGIC;
    signal data_ready: STD_LOGIC;
begin
    mapping : cache port map(clk,full_address,wren,wrdata,reset_n,read_cache,invalidate,hit,data,data_ready);

    full_address <= STD_LOGIC_VECTOR(to_unsigned(0,10)) after 0 ns,
                    STD_LOGIC_VECTOR(to_unsigned(64,10)) after 6 ns,
                    STD_LOGIC_VECTOR(to_unsigned(0,10)) after 11 ns,
                    STD_LOGIC_VECTOR(to_unsigned(64,10)) after 16 ns;

    wren <= '1' after 0 ns, '0' after 10.5 ns;
    wrdata <= STD_LOGIC_VECTOR(to_unsigned(9, 32)) after 0 ns,
              STD_LOGIC_VECTOR(to_unsigned(24,32)) after 6 ns;
    reset_n <= '0' after 0 ns;
    invalidate <= '0' after 0 ns;

    read_cache <= '0' after 0 ns , '1' after 10.5 ns ;
    CLOCK:
    clk <= '1' after 10 ns when clk = '0' else
           '0' after 10 ns when clk = '1';
end test_bench;