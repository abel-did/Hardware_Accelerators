--------------------------------------------------------------------------
-- Authors : Abel DIDOUH
-- Description : Architecture 1 Division
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
	
	signal cptr_div : natural range 0 to 2;	

	signal div1_dividend 	: std_logic_vector(11 downto 0);
	signal div1_divisor  	: std_logic_vector(11 downto 0);
	signal div1_quotient 	: std_logic_vector(11 downto 0);
	signal div1_remainder	: std_logic_vector(11 downto 0);
	
	signal div2_dividend 	: std_logic_vector(11 downto 0);
	signal div2_divisor  	: std_logic_vector(11 downto 0);
	signal div2_quotient 	: std_logic_vector(11 downto 0);
	signal div2_remainder 	: std_logic_vector(11 downto 0);
	
	signal div3_dividend 	: std_logic_vector(11 downto 0);
	signal div3_divisor  	: std_logic_vector(11 downto 0);
	signal div3_quotient 	: std_logic_vector(11 downto 0);
	signal div3_remainder 	: std_logic_vector(11 downto 0);
	
	signal reg_dvd 		    : std_logic_vector(11 downto 0);
	signal reg_dvsr 	    : std_logic_vector(11 downto 0);
	signal reg_quotient 	: std_logic_vector(11 downto 0);
	signal reg_remainder	: std_logic_vector(11 downto 0);
	
	signal mux_quotient 	: std_logic_vector(11 downto 0);
	signal mux_remainder 	: std_logic_vector(11 downto 0);
	

	signal div1_mux_dvd 	: std_logic_vector(11 downto 0);
	signal div1_mux_dvsr 	: std_logic_vector(11 downto 0);
		
	signal div2_mux_dvd 	: std_logic_vector(11 downto 0);
	signal div2_mux_dvsr 	: std_logic_vector(11 downto 0);
	
	signal div3_mux_dvd 	: std_logic_vector(11 downto 0);
	signal div3_mux_dvsr 	: std_logic_vector(11 downto 0);
	
begin
	
	quotient  <= reg_quotient;
	remainder <= reg_remainder;
	
	-- REG DVD
	process(clk, reset) is 
	begin
		if reset = '1' then 
			reg_dvd <= (others => '0');
		elsif rising_edge(clk) then
			reg_dvd <= dividend;
		end if;
	end process;
	
	-- REG DVSR
	process(clk, reset) is 
	begin
	if reset = '1' then 
		reg_dvsr <= (others => '0');
	elsif rising_edge(clk) then
		reg_dvsr <= divisor;
	end if;
	end process;
	
	-- REG QUOTIENT
	process(clk, reset) is 
	begin
	if reset = '1' then 
		reg_quotient <= (others => '0');
	elsif rising_edge(clk) then
		reg_quotient <= mux_quotient;
	end if;
	end process;
	
	-- REG REMAINDER
	process(clk, reset) is 
	begin
	if reset = '1' then 
		reg_remainder <= (others => '0');
	elsif rising_edge(clk) then
		reg_remainder <= mux_remainder;
	end if;
	end process;
	
	-- MUX QUOTIENT
	with cptr_div select
		mux_quotient <= div1_quotient when 0,
				        div2_quotient when 1,
				        div3_quotient when 2,
				        (others => '0') when others;
	
	-- MUX REMAINDER
	with cptr_div select
		mux_remainder <=   div1_remainder when 0,
					       div2_remainder when 1,
					       div3_remainder when 2,
					       (others => '0') when others;
	
	-- DIV 1 PROCESS DVD 			
	process(clk,reset)
	begin 
		if reset = '1' then
			div1_dividend <= (others => '0');
		elsif rising_edge (clk) then
			div1_dividend <= div1_mux_dvd;
		end if;
	end process;
	
	div1_mux_dvd <= reg_dvd when cptr_div = 0 else
		    	div1_dividend;
	
	-- DIV 1 PROCESS DVSR			
	process(clk,reset)
	begin 
		if reset = '1' then
			div1_divisor  <= (others => '0');
		elsif rising_edge (clk) then
			div1_divisor  <= div1_mux_dvsr;
		end if;
	end process;
	
	div1_mux_dvsr <= reg_dvsr when cptr_div = 0 else
		    	 div1_divisor;
	
	-- DIV 2 PROCESS DVD 			
	process(clk,reset)
	begin 
		if reset = '1' then
			div2_dividend <= (others => '0');
		elsif rising_edge (clk) then
			div2_dividend <= div2_mux_dvd;
		end if;
	end process;
	
	div2_mux_dvd <= reg_dvd when cptr_div = 1 else
		    	div2_dividend;
	
	-- DIV 2 PROCESS DVSR			
	process(clk,reset)
	begin 
		if reset = '1' then
			div2_divisor <= (others => '0');
		elsif rising_edge (clk) then
			div2_divisor <= div2_mux_dvsr;
		end if;
	end process;
	
	div2_mux_dvsr <= reg_dvsr when cptr_div = 1 else
		    	div2_divisor;
	
	-- DIV 3 PROCESS DVD 			
	process(clk,reset)
	begin 
		if reset = '1' then
			div3_dividend <= (others => '0');
		elsif rising_edge (clk) then
			div3_dividend <= div3_mux_dvd;
		end if;
	end process;
	
	div3_mux_dvd <= reg_dvd when cptr_div = 2 else
		    	 div3_dividend;
	
	-- DIV 3 PROCESS DVSR			
	process(clk,reset)
	begin 
		if reset = '1' then
			div3_divisor <= (others => '0');
		elsif rising_edge (clk) then
			div3_divisor <= div3_mux_dvsr;
		end if;
	end process;
	
	div3_mux_dvsr <= reg_dvsr when cptr_div = 2 else
		    	 div3_divisor;
		    	 
	
	-- COMPTEUR MODULO 3
	process(clk,reset) is
	begin
		if reset='1' then
			cptr_div <= 0;
		elsif rising_edge(clk) then
			if cptr_div >=(2) then
				cptr_div <= 0;
			else
				cptr_div <= cptr_div+1;
			end if;
		end if;
	end process;
		    	 


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

end architecture;  
