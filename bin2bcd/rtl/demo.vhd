---------------------------------------------------
--           demo binary => BCD                  --
--             Nexys 4 DDR                       --
---------------------------------------------------
-- Creation     : A. Exertier, 02/2018
-- Modification : A. Exertier, 02/2024
----------------------------------------------------
-- user guide :
-- specify the binary value on the switches
-- check the BCD value on the 7-segment displays
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-------------------------------------------
--               INPUTS                  -- 
-------------------------------------------
-- clk  : main clock (100 MHz)
-- btnc : main reset 
-- sw   : switches (binary value)
-------------------------------------------
--               OUTPUTS                 --
-------------------------------------------
-- seg  : 7-segment displays
-- dp   : dot point
-- an   : 7-segment displays selection
------------------------------------------- 

entity demo is
  port (
    clk    : in  std_logic;
    btnc   : in  std_logic;
    sw     : in  std_logic_vector(16-1 downto 0);
    seg    : out std_logic_vector( 7-1 downto 0);
    dp     : out std_logic;
    an     : out std_logic_vector( 8-1 downto 0)
  );
end entity;

architecture rtl of demo is
  signal resetn     : std_logic;
  signal data_bcd   : std_logic_vector(16 downto 0);
  
begin
  resetn <= not btnc;
    
  parallele : entity work.bin2bcd
    generic map (
      N => 16
      )
    port map (
      data_in  => sw,
      data_out => data_bcd
      );
  
  disp : entity work.hexa_display_controller 
    generic map (
      f_clk  => 100_000_000.0,  
      f_scan => 100.0
      )
    port map (
      clk       => clk,
      resetn    => resetn,
      hexa0     => data_bcd( 3 downto  0)  ,
      hexa1     => data_bcd( 7 downto  4)  ,
      hexa2     => data_bcd(11 downto  8)  ,
      hexa3     => data_bcd(15 downto 12)  ,
      hexa4     => data_bcd(19 downto 16)  ,
      hexa5     => "0000"   ,
      hexa6     => "0000"   ,
      hexa7     => "0000"   ,
      dot_point => "11111111"   ,
      en        => "00011111"   ,
      seg       => seg      ,
      dp        => dp       ,
      an        => an          
    );
end architecture;
  
