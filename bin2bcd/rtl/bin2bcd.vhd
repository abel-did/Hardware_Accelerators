----------------------------------------------------
--    Binary => BCD  : parallel  architecture     --
----------------------------------------------------
--! Author : Abel DIDOUH
----------------------------------------------------

----------------------------------------------------
--      GENERIC PARAMETER
----------------------------------------------------
-- N : number of bits
----------------------------------------------------
--            INPUT
----------------------------------------------------
-- data_in : binary input (N bits)
----------------------------------------------------
--            OUTPUT
----------------------------------------------------
-- data_out : bcd output (4*log2(2**N)/log2(10) bits)
----------------------------------------------------
--! 
--! Binary to Binary Coded Decimal
--! 
--! The aim is to design a combinatorial architecture 
--! that converts a data_in representing a natural binary 
--! code of N bits into a BCD data_out using the double 
--! dabble algorithm.   
----------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
----------------------------------------------------
entity bin2bcd is
  generic
  (
    N : positive := 10 --! Number of bits
  );
  port
  (
    data_in  : in std_logic_vector(N - 1 downto 0); --! Binary input (N bits)
    data_out : out std_logic_vector(integer(4.0 * ceil(log2(2.0 ** N)/log2(10.0))) - 1 downto 0) --! BCD output (4*log2(2**N)/log2(10) bits)
  );
end entity;
--------------------------------------------------------------------------
architecture rtl of bin2bcd is

  constant SIZE_BCD     : positive := integer(4.0 * ceil(log2(2.0 ** N)/log2(10.0))); --! Size BCD Vector
  constant NUMBER_BLOCK : natural  := integer(floor(real(SIZE_BCD - 1)/4.0)); --! Number of elementary cell
  constant SIZE_BIN_EXT : natural  := integer((real(NUMBER_BLOCK) - 1.0) * 4.0 + real(N) + 1.0); --! Size Binary Extended 
  constant DEPTH_C      : natural  := N-4; --! Depth of the architecture

  signal bin_extended : std_logic_vector(SIZE_BIN_EXT + 2 downto 0) := (others => '0'); --! Signal Binary Extended

begin

  bin_extended(data_in'range) <= data_in;

  --! This process has two loops to place the right number of blocks on each line corresponding to the depth of the architecture.
  process_bin2bcd : process (bin_extended) is
    variable tmp : unsigned(SIZE_BIN_EXT + 2 downto 0);
  begin
    tmp := unsigned(bin_extended);

        depth : for d in 0 to DEPTH_C loop --! Loop iterate on depth
          bloc  : for b in 0 to NUMBER_BLOCK - 1 loop --! Loop iterate on bloc
            if tmp(SIZE_BIN_EXT - 1 - (4 * b) - d downto SIZE_BIN_EXT - 1 - (4 * b) - d - 3) > 4 then
              tmp(SIZE_BIN_EXT - 1 - (4 * b) - d downto SIZE_BIN_EXT - 1 - (4 * b) - d - 3) := tmp(SIZE_BIN_EXT - 1 - (4 * b) - d downto SIZE_BIN_EXT - 1 - (4 * b) - d - 3) + 3;
            end if;
          end loop bloc;
        end loop depth;
        data_out <= std_logic_vector(tmp(data_out'length - 1 downto 0));
  end process;
end architecture;
