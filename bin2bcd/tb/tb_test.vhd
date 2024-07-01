----------------------------------------------------
--! Author : Abel DIDOUH
----------------------------------------------------
--! 
--! This file corresponds to the testbench.
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--------------------------------------------------------------------------
entity tb_test is
end entity;
--------------------------------------------------------------------------
architecture tb of tb_test is

    constant hp       : time := 5000 ps;   -- help period
    constant per      : time := 2*hp;      -- period
    constant t_init   : time := 1 us;      -- useful for post-implementation timing simulation
  
    signal resetn        : std_logic;          
    signal clk           : std_logic := '0';

    signal BIN : std_logic_vector(7 downto 0) := (others=>'0') ;                                                       --! Binary Vector
    signal BCD : std_logic_vector(integer(4.0 * ceil(log2(2.0 ** 8)/log2(10.0))) - 1 downto 0) := (others=>'0');        --! BCD Vector

    type binary_array is array (natural range <>) of std_logic_vector(7 downto 0);
    constant values : binary_array := (
	    "00000111",  -- 0000_0111
        "10101110",  -- 1010_1110
        "01001100",  -- 0100_1100
        "10101101",  -- 1010_1101
        "01100011"   -- 0110_0011
    );

    type bcd_array is array (natural range <>) of std_logic_vector(BCD'length-1 downto 0);
    constant bcd_values : bcd_array := (
	    "000000000111",    -- 007 en BCD
        "000101110100",-- 174 en BCD
        "000001110110",-- 076 en BCD
        "000101110011",-- 173 en BCD
        "000010011001" -- 099 en BCD
    );

    begin
 
        dut: entity work.test_bin2bcd
   		   port map(
   		        clk      => clk,
                resetn   => resetn,
        		data_in  => BIN,
        		data_out => BCD
    		);
	
	clk <= not clk after hp;

 	stimulus : process is
	begin
	   resetn      <= '0';
	   wait for t_init ;
	  
	    -- desactivation du reset
        wait until rising_edge(clk);
        resetn     <= '1';
        wait for 2*hp;
        wait until rising_edge(clk);
	   
       for i in 0 to 4 loop
            BIN <= values(i);
            wait until rising_edge(clk);  
       end loop;
       wait;
      end process;

end architecture;
