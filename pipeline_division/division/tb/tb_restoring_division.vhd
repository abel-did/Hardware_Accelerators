library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_restoring_division is 
end entity;

architecture testbench of tb_restoring_division is
  constant hp  : time := 5 ns;
  constant per : time := 2*hp;
  constant n_dividend : positive := 5; 
  constant n_divisor  : positive := 3;
  
  type test_vector is array (natural range <>) of integer;
--  constant v_divisor  : test_vector(1 to 13) := (5, 1, 2, 8, 15, 5, 1, 2, 8, 15,7,12,13);
--  constant v_dividend : test_vector(1 to 13) := (17, 17, 17, 17, 17, 22, 22, 22, 22, 22,50,2,45);
  constant v_divisor  : test_vector(1 to 18) := (3, 3, -3, -3, 3, 3, -3, -3, 3, 3, -3, -3, 3, 3, -3, -3,-4,-4);
  constant v_dividend : test_vector(1 to 18) := (15, -15, 15, -15, 14, -14, 14, -14, 13, -13, 13, -13, 12, -12, 12, -12,8,-8);
--   constant v_divisor  : test_vector(1 to 12) := (15,  1, -1, -1,    1, 14,  14, -14, -14, 3, 2352, 100);
--   constant v_dividend : test_vector(1 to 12) := (15, 15, 15, -15, -15, -14, 14, -14, 14, -13, 32000,32000);  

  signal dividend     : std_logic_vector(n_dividend-1 downto 0);
  signal divisor      : std_logic_vector(n_divisor-1  downto 0);
  signal quotient     : std_logic_vector(n_dividend-1 downto 0);
  signal remainder    : std_logic_vector(n_divisor-1  downto 0);
  
  signal clk          : std_logic :='0';
  signal resetn       : std_logic;
  
    
begin
  -- device under test
  dut : entity work.restoring_division
  generic map ( 
    N_dividend => N_dividend,
    N_divisor  => N_divisor
  )
  port map (
    clk       => clk,
    resetn    => resetn,
    dividend  => dividend,
    divisor   => divisor,
    quotient  => quotient,
    remainder => remainder
  );
  
  clk    <= not clk after hp;
  
  -- stimuli
  process is
  begin
    resetn  <= '0';    
    dividend <= std_logic_vector(to_signed(0, dividend'length));
    divisor  <=  std_logic_vector(to_signed(1, divisor'length));     
    wait until rising_edge(clk);
    resetn  <= '1';  
    wait until rising_edge(clk);
    
    for i in 1 to v_divisor'high loop
      dividend <= std_logic_vector(to_signed(v_dividend(i), dividend'length));
      divisor  <= std_logic_vector(to_signed(v_divisor(i),  divisor'length));           
      wait until rising_edge(clk);      
    end loop;             
    wait;    
  end process;  
  
  -- Verification
  process is 
    variable quo_ok  : integer;
    variable rem_ok  : integer;
    variable quo_dut : integer;
    variable rem_dut : integer; 
    variable test_ok : boolean := true;
  begin
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    wait for (N_dividend+2)*per;
    
    for i in 1 to v_divisor'high loop
      wait until rising_edge(clk);
      quo_dut := to_integer(signed(quotient));
      rem_dut := to_integer(signed(remainder));
      quo_ok  := v_dividend(i)/v_divisor(i);
      rem_ok  := v_dividend(i) rem v_divisor(i);
      if ( quo_dut /= quo_ok)  or ( rem_dut /=rem_ok ) then 
        report  integer'image(v_dividend(i)) & " / " & integer'image(v_divisor(i)) & " = "& integer'image(quo_ok) &" rem "&integer'image(rem_ok)
        & "    //    "& integer'image(quo_dut) &" rem "&integer'image(rem_dut);
        test_ok := false;
      else
        -- report  "TEST OK : "&integer'image(v_dividend(i)) & " / " & integer'image(v_divisor(i)) & " = "& integer'image(quo_ok) &" rem "&integer'image(rem_ok);       
      end if;  
      
    end loop;
    
    wait until rising_edge(clk);
    if test_ok  then 
      report "TOUS LES TESTS SONT OK.";
    else report 
      "AU MOINS UN TEST ERRONE.";
    end if;
    wait;
  end process;
  
end architecture;