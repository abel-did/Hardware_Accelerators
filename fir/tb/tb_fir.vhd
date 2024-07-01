-----------------------------------------------------
-- testbench Filtre FIR
-----------------------------------------------------
-- Auteur : Anne Exertier
-- Date   : fevrier 2023
------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_fir is
end tb_fir;

architecture testbench of tb_fir is
  -- Nb de bits du filtre
  constant N_data  : positive := 16;
  constant N_coeff : positive := 12;
  constant N_order : positive := 10;
  
  -- horloge systeme
  constant fclk : real := 10.0E6;     -- 10 MHz
  constant Tclk : real := 1.0E9/fclk; -- 10 MHz
  constant hp   : time := (1.0/fclk)/2.0* 1 sec;    --demi periode
  constant per  : time := 2*hp;
  
  -- coefficients du filtre
  type t_coeff_real is array (natural range <>) of real ;
  subtype t_coeff_bin is std_logic_vector(N_coeff*(N_order+1)-1 downto 0) ;
  
-- constant coeff_real : t_coeff_real(N_order downto 0) :=(
--    3.8490644028E-02,
--    5.8736879080E-02 ,
--    7.0933303943E-02 ,
--    9.5754693981E-02 ,
--    2.2893489719E-01 ,
--    3.0537582259E-01 ,
--    2.2893489719E-01 ,
--    9.5754693981E-02 ,
--    7.0933303943E-02 ,
--    5.8736879080E-02 ,
--    3.8490644028E-02
--  );


  constant coeff_real : t_coeff_real(N_order downto 0) :=(
    3.8490644028E-02,
    5.8736879080E-02 ,
    7.0933303943E-02 ,
    -9.5754693981E-02 ,
    -2.2893489719E-01 ,
    3.0537582259E-01 ,
    -2.2893489719E-01 ,
    -9.5754693981E-02 ,
    7.0933303943E-02 ,
    5.8736879080E-02 ,
    3.8490644028E-02
  );
  

  function real2bin_coeff(coeff_in : t_coeff_real)  return t_coeff_bin is
    variable tmp : t_coeff_bin ;
  begin
    for i in coeff_in'range loop
      tmp(N_coeff*i+ N_coeff -1 downto N_coeff*i) := std_logic_vector(to_signed(integer(2.0**(N_coeff-1)*coeff_in(i)),N_coeff));
    end loop; 
    return tmp;
  end function;  
   
  constant coeff      : t_coeff_bin := real2bin_coeff(coeff_real);
    
  signal clk        : std_logic := '0';
  signal reset      : std_logic;
  signal data_in    : std_logic_vector (N_data-1 downto 0);
  signal data_out   : std_logic_vector (N_data-1 downto 0);
  signal data_pulse : std_logic_vector(data_in'range);
  
  signal impulse    : boolean := true;
  
  -- sine generation
  signal sinus      : real;
  signal ampl_sinus : real := 0.95;
  signal f_sinus    : real := 1.0;
  signal data_sinus : std_logic_vector(data_in'range);
  signal ctr        : real := 0.0;


begin


  dut : entity work.fir 
    generic map (
      N_order  => N_order   ,
      N_data   => N_data    ,
      N_coeff  => N_coeff   
    )
    port map (
      clk      => clk, 
      reset    => reset , 
      data_in  => data_in ,
      data_out => data_out,
      coeff    => coeff 
    );
  
  data_in <=  data_pulse when impulse 
    else data_sinus;
   
  --clock
  clk     <= not clk after hp;
  
  sitmuli : process is
  begin
    reset      <= '1';
    data_pulse <= (others => '0');
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    reset      <= '0';
    wait until rising_edge(clk) ;
    wait until rising_edge(clk);
    data_pulse(data_pulse'high -1) <= '1';
    wait until rising_edge(clk);
    data_pulse(data_pulse'high -1) <= '0';
    for i in 1 to 2*N_order loop
      wait until rising_edge(clk);
    end loop;
    impulse <= false;
    wait;
  end process;
  
  
  -- sine generation
  
  ampl_sinus  <= 0.5;
  sinus       <= ampl_sinus * (2.0**(N_data-1))* sin(math_2_pi * f_sinus/fclk*ctr);  
  data_sinus  <= std_logic_vector(to_signed(integer(sinus),N_data));
  process(clk)
  begin
    if rising_edge(clk) then  
      if reset = '1' then
        ctr <= 0.0;
      else 
        ctr <= ctr + 1.0;  
      end if;    
    end if;  
  end process;
  
  freq : process is
  begin
    f_sinus     <= fclk/128.0;
    wait for 10 us;
    f_sinus     <= fclk/64.0;
    wait for 10 us;
    f_sinus     <= fclk/32.0;
    wait for 5 us;
    f_sinus     <= fclk/16.0;
    wait for 5 us;
    f_sinus     <= fclk/8.0;
    wait for 5 us;
    f_sinus     <= fclk/4.0;
    wait;
  end process;
end;
