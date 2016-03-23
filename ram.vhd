library IEEE;
use IEEE.std_logic_1164.all;

entity ram is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  rw: in std_logic;
  data_in: in std_logic_vector( 31 downto 0 );
  data_ready: out std_logic;
  data_out:out std_logic_vector(31 downto 0)
  );
end ram;

architecture dataflow of ram is
begin

end dataflow;


