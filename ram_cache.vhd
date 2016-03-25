library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity ram_cache is port (
clk:in std_logic ;
addr : in std_logic_vector(9 downto 0 ) ;
reset_n: in std_logic ;
read:in std_logic ;
write: in std_logic ;
wrdata:in std_logic_vector(31 downto 0 ) ;
rddata: out std_logic_vector(31 downto 0 ) ;
hit: out std_logic
);
end ram_cache ;

architecture data_flow of ram_cache is
  component cache is port (
    clk:in std_logic ;
    cpu_address : in std_logic_vector(9 downto 0 ) ;
    wren : in std_logic ;
    wrdata: in std_logic_vector(31 downto 0 ) ;
    reset:in std_logic ;
    read_cache: in std_logic ;
    read_w0: in std_logic ;
    invalidate:in std_logic ;
    hit:out std_logic ;
    rddata:out std_logic_vector(31 downto 0 );
    w0_valid:out std_logic
  );
  end component ;
  
  component ram is port (
    clk: in std_logic;
    address: in std_logic_vector(9 downto 0);
    rw: in std_logic;
    data_in: in std_logic_vector( 31 downto 0 );
    data_ready: out std_logic;
    data_out:out std_logic_vector(31 downto 0)
  );
  end component ;
  
  component controller is port(
    write_request : in std_logic ;
    read_request: in std_logic ;
    clk : in std_logic;
    ram_ready: in std_logic ;
    is_hit: in std_logic ;
    w0_valid: in std_logic ;
    invalidate: out std_logic ;
    ram_write: out std_logic ;
    ram_read: out std_logic ;
    read_w0: out std_logic ;
    read_cache: out std_logic ;
    wren: out std_logic
  );
  end component ;
  
  signal cache_rddata: std_logic_vector( 31 downto 0 ) ;
  signal ram_rddata: std_logic_vector(31 downto 0 ) ;
  signal ram_data_ready:std_logic ;
  signal w0_valid:std_logic ;
    
begin
  
  my_cache : cache port map( clk , addr , , wrdata , reset_n , , , , hit , cache_rddata , w0_valid) ;
    
  my_ram : ram port map( clk , addr , , wrdata , ram_data_ready , ram_rddata) ;
    
  my_controller : controller port map( write , read , clk , ram_data_ready , hit , w0_valid ,
    
  with hit select rddata <=
    cache_rddata when '1' ,
    ram_rddata when others ;
    
  w0_tag_valid : tag_valid_array port map( clk , cpu_address(5 downto 0 ) , w0_wren , reset , invalidate ,
     cpu_address(9 downto 6 ) , w0_tag_valid_output ) ;
  w1_tag_valid : tag_valid_array port map( clk , cpu_address(5 downto 0 ) , w1_wren , reset , invalidate ,
     cpu_address(9 downto 6 ) , w1_tag_valid_output ) ;
     
  lru : lru_array port map (clk , cpu_address(5 downto 0 ) , read_w0 , read_cache , w1_select ) ;
  
  with read_w0 select rddata <=
    w0_data_array_rddata when '1' ,
    w1_data_array_rddata when others ;

end data_flow ;
  
    
