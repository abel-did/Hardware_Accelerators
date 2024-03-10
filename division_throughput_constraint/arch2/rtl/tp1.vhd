--------------------------------------------------------------------------
-- Author : Abel DIDOUH
-- Description : Division
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------
entity tp1 is 
  port (
    clk        : in  std_logic;
    reset      : in  std_logic;
    dividend   : in  std_logic_vector(12-1 downto 0);
    divisor    : in  std_logic_vector(12-1 downto 0);  
    quotient   : out std_logic_vector(12-1 downto 0);
    remainder  : out std_logic_vector(12-1 downto 0)
  );
end entity;
--------------------------------------------------------------------------
architecture rtl of tp1 is
	
	signal div1_dividend  : std_logic_vector(dividend'LENGTH - 1 downto 0);
	signal div1_divisor   : std_logic_vector(divisor'LENGTH - 1 downto 0);
    	signal div1_quotient  : std_logic_vector(quotient'LENGTH - 1 downto 0);
    	signal div1_remainder : std_logic_vector(remainder'LENGTH - 1 downto 0);

    	signal div2_dividend  : std_logic_vector(dividend'LENGTH - 1 downto 0);
	signal div2_divisor   : std_logic_vector(divisor'LENGTH - 1 downto 0);
    	signal div2_quotient  : std_logic_vector(quotient'LENGTH - 1 downto 0);
    	signal div2_remainder : std_logic_vector(remainder'LENGTH - 1 downto 0);

    	signal div3_dividend  : std_logic_vector(dividend'LENGTH - 1 downto 0);
	signal div3_divisor   : std_logic_vector(divisor'LENGTH - 1 downto 0);
    	signal div3_quotient  : std_logic_vector(quotient'LENGTH - 1 downto 0);
    	signal div3_remainder : std_logic_vector(remainder'LENGTH - 1 downto 0);

    	signal dividend_q     : std_logic_vector(dividend'LENGTH - 1 downto 0);
    	signal divisor_q      : std_logic_vector(divisor'LENGTH - 1 downto 0);

    	signal quotient_mux   : std_logic_vector(quotient'LENGTH - 1 downto 0);
    	signal remainder_mux  : std_logic_vector(quotient'LENGTH - 1 downto 0);
    
    	signal div1_quotient_registre, div2_quotient_registre, div3_quotient_registre :  std_logic_vector(quotient'LENGTH - 1 downto 0);
    	signal div1_remainder_registre, div2_remainder_registre, div3_remainder_registre :  std_logic_vector(quotient'LENGTH - 1 downto 0);

    	signal compteur       : std_logic_vector(2 downto 0);  
    
    	signal clk1, clk2, clk3, clk4 : std_logic;

component my_pll
port
 (-- Clock in ports
  -- Clock out ports
  clk1          : out    std_logic;
  clk2          : out    std_logic;
  clk3          : out    std_logic;
  clk4          : out    std_logic;
  clk_in1       : in     std_logic
 );
end component;

begin
	
	
    -- PROCESS DIVIDEND
    process(clk4, reset)
    begin
      if reset = '1' then
        dividend_q <= (others => '0');
      elsif rising_edge(clk4) then
        dividend_q <= dividend;
      end if;
    end process;

    -- PROCESS DIVISOR
    process(clk4, reset)
    begin
      if reset = '1' then
        divisor_q <= (others => '0');
      elsif rising_edge(clk4) then
        divisor_q <= divisor;
      end if;
    end process;

    -- PROCESS QUOTIENT
    process(clk4, reset)
    begin
      if reset = '1' then
        quotient <= (others => '0');
      elsif rising_edge(clk4) then
        quotient <= quotient_mux;
      end if;
    end process;

   

    -- PROCESS REMAINDER
    process(clk4, reset)
    begin
      if reset = '1' then
        remainder <= (others => '0');
      elsif rising_edge(clk4) then
        remainder <= remainder_mux;
      end if;
    end process;

   

    -- COMPTEUR ONE HOT
    process(clk4,reset)
    begin
      if reset = '1' then
        compteur <= "010";
      elsif rising_edge(clk4) then
        compteur <= compteur(1 downto 0) & compteur(2);
      end if;
    end process;

    -- MUX COMPTEUR
    quotient_mux <= div1_quotient_registre when compteur = "001" else
                    div2_quotient_registre when compteur = "010" else
                    div3_quotient_registre when compteur = "100" else
                    (others => '0');

    remainder_mux <=  div1_remainder_registre when compteur = "001" else
                      div2_remainder_registre when compteur = "010" else
                      div3_remainder_registre when compteur = "100" else
                      (others => '0');
    
    -- PROCESS DIV1 DIVIDEND & DIVISOR
    process(clk1, reset)
    begin
      if reset = '1' then
        div1_dividend <= (others => '0');
        div1_divisor  <= (others => '0');
      elsif rising_edge(clk1)  then
        div1_dividend <= dividend_q;
        div1_divisor  <= divisor_q;
      end if;        
    end process;

    -- PROCESS DIV2 DIVIDEND & DIVISOR
      process(clk2, reset)
      begin
        if reset = '1' then
          div2_dividend <= (others => '0');
          div2_divisor  <= (others => '0');
        elsif rising_edge(clk2)  then
          div2_dividend <= dividend_q;
          div2_divisor  <= divisor_q;
        end if;        
      end process;

    -- PROCESS DIV3 DIVIDEND & DIVISOR
      process(clk3, reset)
      begin
        if reset = '1' then
          div3_dividend <= (others => '0');
          div3_divisor  <= (others => '0');
        elsif rising_edge(clk3)  then
          div3_dividend <= dividend_q;
          div3_divisor  <= divisor_q;
        end if;        
      end process;
      
      -- PROCESS DIV1 QUOTIENT & REMAINDER
    process(clk1, reset)
    begin
      if reset = '1' then
        div1_quotient_registre      <= (others => '0');
        div1_remainder_registre     <= (others => '0');
      elsif rising_edge(clk1)  then
        div1_quotient_registre      <= div1_quotient;
        div1_remainder_registre     <= div1_remainder;
      end if;        
    end process;

    -- PROCESS DIV1 QUOTIENT & REMAINDER
      process(clk2, reset)
      begin
        if reset = '1' then
          div2_quotient_registre    <= (others => '0');
          div2_remainder_registre   <= (others => '0');
        elsif rising_edge(clk2)  then
          div2_quotient_registre    <= div2_quotient;
          div2_remainder_registre   <= div2_remainder;
        end if;        
      end process;

    -- PROCESS DIV1 QUOTIENT & REMAINDER
      process(clk3, reset)
      begin
        if reset = '1' then
          div3_quotient_registre <= (others => '0');
          div3_remainder_registre  <= (others => '0');
        elsif rising_edge(clk3)  then
          div3_quotient_registre  <= div3_quotient;
          div3_remainder_registre  <= div3_remainder;
        end if;        
      end process;
  
--------------------------------------------------------------------------
-- Inst.
--------------------------------------------------------------------------
  	div1 : entity work.non_restoring_division
    generic map(
        N_dividend => 12,
        N_divisor  => 12
    )
    port map (
        dividend   =>  div1_dividend,
        divisor    =>  div1_divisor,
        quotient   =>  div1_quotient,
        remainder  =>  div1_remainder
    );
	
  	div2 : entity work.non_restoring_division
    generic map(
        N_dividend => 12,
        N_divisor  => 12
    )
    port map (
        dividend   =>  div2_dividend,
        divisor    =>  div2_divisor,
        quotient   =>  div2_quotient,
        remainder  =>  div2_remainder
    );
  	
  	div3 : entity work.non_restoring_division
    generic map(
        N_dividend => 12,
        N_divisor  => 12
    )
    port map (
        dividend   =>  div3_dividend,
        divisor    =>  div3_divisor,
        quotient   =>  div3_quotient,
        remainder  =>  div3_remainder
    );

   tp1_pll : my_pll
   port map ( 
  -- Clock out ports  
   clk1 => clk1,
   clk2 => clk2,
   clk3 => clk3,
   clk4 => clk4,
   -- Clock in ports
   clk_in1 => clk
 );

end architecture;  
