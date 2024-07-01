----------------------------------------------------------------------------
-- Non-restoring division, signed binary
-- Division sans restauration en code complement a 2
-- Traitement pipeline
----------------------------------------------------------------------------
-- Authors     : A. DIDOUH & F. AUDOUIN
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity restoring_division is
  generic (
    N_dividend : positive := 5;
    N_divisor  : positive := 3
  );
  port (
    clk       : in  std_logic;
    resetn    : in  std_logic;
    dividend  : in  std_logic_vector(N_dividend-1 downto 0);
    divisor   : in  std_logic_vector(N_divisor-1  downto 0);  
    quotient  : out std_logic_vector(N_dividend-1 downto 0);
    remainder : out std_logic_vector(N_divisor-1  downto 0)
  );
end entity;

architecture rtl of restoring_division is
    subtype sub_dvd   is signed(dividend'range);
    subtype sub_dvsr  is signed(divisor'range);

   
    type type_matrix_dvd        is array (natural range N_dividend downto 0) of sub_dvd;
    type type_matrix_dvsr       is array (natural range N_dividend downto 0) of sub_dvsr;
    type type_matrix_quotient   is array (natural range N_dividend downto 0) of sub_dvd;
    type type_matrix_remainder  is array (natural range N_dividend downto 0) of sub_dvsr;

    signal m_reg_dvd      : type_matrix_dvd;
    signal m_reg_dvsr     : type_matrix_dvsr;
    signal m_reg_quotient : type_matrix_quotient;
    signal m_reg_remainder: type_matrix_remainder;

    signal s_reg_remainder: std_logic_vector(divisor'range);
    signal s_reg_quotient : std_logic_vector(quotient'range);

begin

    process(resetn, clk) is
      variable v_partial_rem : signed(N_divisor downto 0);
      variable v_sum         : signed(N_divisor downto 0);

      variable v_partial_rem_final : signed(N_divisor-1 downto 0);
      variable v_sum_final         : signed(N_divisor-1 downto 0);

      variable v_partial_quo   : signed(N_dividend-1 downto 0);

    begin
      if resetn = '0' then
        v_partial_rem       := (others => '0');
        v_sum               := (others => '0');
        v_partial_rem_final := (others => '0');
        v_sum_final         := (others => '0');

        m_reg_dvd       <= (others => (others => '0'));
        m_reg_dvsr      <= (others => (others => '0'));
        m_reg_quotient  <= (others => (others => '0'));
        m_reg_remainder <= (others => (others => '0'));

        s_reg_quotient  <= (others => '0');
        s_reg_remainder <= (others => '0');

      elsif rising_edge(clk) then
       
        -- Etage N_dividend
        m_reg_dvd(N_dividend)       <= signed(dividend);
        m_reg_dvsr(N_dividend)      <= signed(divisor);
       

	    for j in N_divisor-1 downto 0 loop
  		    m_reg_remainder(N_dividend)(j) <= dividend(dividend'high);                          -- Reste partiel = (bit de signe du dividende) (boucle)
    	end loop;


        -- Etage i
        for i in N_dividend - 1 downto 0 loop                                                   -- Pour i de Ndividend-1 a  0, faire :

          v_partial_rem := signed(m_reg_remainder(i+1)&m_reg_dvd(i+1)(i));			            -- reste partiel = reste partiel<<1 & dividende(i)

          if v_partial_rem(v_partial_rem'high) = m_reg_dvsr(i+1)(N_divisor - 1) then            -- si reste partiel et diviseur sont de meme signe
              v_sum := v_partial_rem - m_reg_dvsr(i+1);              				            --    sum = reste partiel - diviseur
          else                                                                                  -- sinon
              v_sum := v_partial_rem + m_reg_dvsr(i+1);              				            --    sum = reste partiel + diviseur
          end if;

 	  m_reg_quotient(i)  <= m_reg_quotient(i+1);
          m_reg_quotient(i)(i)  <= m_reg_dvsr(i+1)(N_divisor - 1) xnor v_sum(v_sum'high);      -- quotient(i) = diviseur(MSB) xnor sum(MSB)

          if v_partial_rem(v_partial_rem'high) = v_sum(v_sum'high) then                        -- si reste partiel et sum sont de meme signe (pas de restauration)
              v_partial_rem(v_partial_rem'high-1 downto 0) := v_sum(v_sum'high-1 downto 0);    --    reste partiel = sum
          end if;

          m_reg_dvd(i)        <= m_reg_dvd(i+1);
          m_reg_dvsr(i)       <= m_reg_dvsr(i+1);
          m_reg_remainder(i)  <= v_partial_rem(v_partial_rem'high-1 downto 0);
 
 
        end loop;
       
	v_partial_rem_final := m_reg_remainder(0);
        -- Etage traitement final
        if m_reg_remainder(0)(N_divisor-1) = m_reg_dvsr(0)(N_divisor - 1) then                 -- si reste partiel et diviseur sont de meme signe
            v_sum_final := m_reg_remainder(0) - m_reg_dvsr(0);            		               --    sum = reste partiel - diviseur
        else                                                                                   -- sinon
            v_sum_final := m_reg_remainder(0) + m_reg_dvsr(0);                                 --    sum = reste partiel + diviseur
        end if;

        if v_sum_final = 0 then                                                                -- si sum = 0
            v_partial_rem_final := v_sum_final;      					                       -- reste partiel = sum
  	end if;

        if v_partial_rem_final(N_divisor-1) /= m_reg_dvsr(0)(N_divisor - 1) then               -- si reste partiel de signe opposee au diviseur
            	v_partial_quo := m_reg_quotient(0) + 1;        
	else
   		v_partial_quo := m_reg_quotient(0);                                                    --    quotient = quotient +1
        end if;

        s_reg_remainder <= std_logic_vector(v_partial_rem_final(N_divisor-1 downto 0));
        s_reg_quotient  <= std_logic_vector(v_partial_quo);  

      end if;
    end process;

    quotient <= s_reg_quotient;
    remainder<= s_reg_remainder;
end architecture;
