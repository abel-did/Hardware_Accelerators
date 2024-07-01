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
entity tb_bin2bcd is
    generic
    (
      N : positive := 8                             		                                       --! Number of bits
    );
end entity;
--------------------------------------------------------------------------
architecture testbench of tb_bin2bcd is

    constant NUMBER_LOOP_STIMULIS : positive := N;

    signal BIN : std_logic_vector(N-1 downto 0);                                                       --! Binary Vector
    signal BCD : std_logic_vector(integer(4.0 * ceil(log2(2.0 ** N)/log2(10.0))) - 1 downto 0);        --! BCD Vector
       
    begin
	


        stimulus : process is
	variable bin_test : unsigned(BCD'length-1 downto 0) := (others => '0');
	variable bcd_test : unsigned(BCD'length-1 downto 0) := (others => '0');
	begin
          for i in 0 to 10 loop
            BIN <= std_logic_vector(to_unsigned(integer(i),BIN'length));
            
            BIN_test(BIN'length-1 downto 0) := unsigned(BIN);
	    BCD_test:= unsigned(BCD);
            
	    if integer'image(to_integer(BIN_test)) /= integer'image(to_integer(BCD_test)) then
            	report "Test not OK" severity warning;
            	report "Resultat attendu : 0x"& integer'image(to_integer(BIN_test));
            	report "Resultat obtenu : 0d"& integer'image(to_integer(BCD_test));
            else
		report "Test OK" severity warning;
       		report "Resultat obtenu : 0x"& to_hex_string(BCD);
            end if; 
            
            wait for 10 ns;
          end loop;
          wait;
        end process;
        
        --! Device Under Test : bin2bcd 
        dut: entity work.bin2bcd
    		generic map(
        		N => N
    		)
   		port map(
        		data_in  => BIN,
        		data_out => BCD
    		);

end architecture;
