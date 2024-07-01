--------------------------------------------------------------------------
-- Authors : Abel DIDOUH & François AUDOUIN
-- Description : FIR Filter
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
--------------------------------------------------------------------------
entity fir is
	generic(
		N_order : positive := 5;
		N_coeff : positive := 5;
		N_data  : positive := 8	
	);
	port(
		clk	: in std_logic;
		reset   : in std_logic;
		data_in : in std_logic_vector(N_data-1 downto 0);
		coeff 	: in std_logic_vector(N_coeff*(N_order+1) -1 downto 0);
		data_out: out std_logic_vector(N_data-1 downto 0)	
	);
end entity;
--------------------------------------------------------------------------
architecture rtl of fir is
	type t_matrix is array (natural range 0 to N_order) of signed(N_data + N_coeff downto 0);

	signal resultat_matrice 	: t_matrix;
	signal s_din   			: signed(data_in'range);
	signal s_reg_data_in		: signed(data_in'range) 			:= (others => '0') ;
	signal s_data_out 		: std_logic_vector(data_out'range) 		:= (others => '0') ;
begin

	s_din <= signed(data_in);
	
	process(clk,reset) is
	begin
		if rising_edge(clk) then 
			if reset = '1' then
				s_reg_data_in <= (others => '0');
			else
				s_reg_data_in <= s_din;
			end if;
		end if;
	end process;

	process(clk, reset) is
		variable mult_signed	: signed((N_data + N_coeff)-1 downto 0);
		variable add_signed	: signed(resultat_matrice(0)'range);
	begin
		if rising_edge(clk) then
			if reset = '1' then
				resultat_matrice	<= (others => (others => '0') );
			else 
				
				for i in N_order downto 0 loop
					if i = N_order then
						resultat_matrice(N_order) <= '0'&(s_reg_data_in * signed(coeff(coeff'high downto coeff'high-N_coeff+1)));
					else
						mult_signed := signed(coeff(i*N_coeff+N_coeff-1 downto i*N_coeff)) * s_reg_data_in;
						add_signed  := resultat_matrice(i+1) + mult_signed;
						resultat_matrice(i) <= add_signed;
					end if;
				end loop;	
				s_data_out <= std_logic_vector(resultat_matrice(0)(resultat_matrice(0)'high-2 downto resultat_matrice(0)'length - N_data-2));				
			end if;
		end if;
	end process;
	data_out <= s_data_out;
end architecture;
