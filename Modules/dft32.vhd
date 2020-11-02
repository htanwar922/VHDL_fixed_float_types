
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

use work.my_types.all;
use work.my_float_package.all;
use work.my_functions.all;

entity dft32 is
	generic( N : natural := 40 );
	port (
        clk : in std_logic;-- := '0';
        adc : in float32;-- := "00000000000000000000000000000000";
        Irms : out float32 := "00000000000000000000000000000000"
    );
end entity;

architecture dft32 of dft32 is
	signal C : float32_arr(0 to N-1+N/4) :=
		(
			"00000000000000000000000000000000",
            "00111110001000000011000001011000",
            "00111110100111100011011101111000",
            "00111110111010000111000101110000",
            "00111111000101100111100100011000",
            "00111111001101010000010011110010",
            "00111111010011110001101110111100",
            "00111111011001000001100100000000",
            "00111111011100110111100001110000",
            "00111111011111001101100100100100",
            "00111111100000000000000000000000",
            "00111111011111001101100100100100",
            "00111111011100110111100001110000",
            "00111111011001000001100100000000",
            "00111111010011110001101110111100",
            "00111111001101010000010011110010",
            "00111111000101100111100100011000",
            "00111110111010000111000101110000",
            "00111110100111100011011101111000",
            "00111110001000000011000001011000",
            "00000000000000000000000000000000",
            "10111110001000000011000001011000",
            "10111110100111100011011101111000",
            "10111110111010000111000101110000",
            "10111111000101100111100100011000",
            "10111111001101010000010011110010",
            "10111111010011110001101110111100",
            "10111111011001000001100100000000",
            "10111111011100110111100001110000",
            "10111111011111001101100100100100",
            "10111111100000000000000000000000",
            "10111111011111001101100100100100",
            "10111111011100110111100001110000",
            "10111111011001000001100100000000",
            "10111111010011110001101110111100",
            "10111111001101010000010011110010",
            "10111111000101100111100100011000",
            "10111110111010000111000101110000",
            "10111110100111100011011101111000",
            "10111110001000000011000001011000",
            "00000000000000000000000000000000",
            "00111110001000000011000001011000",
            "00111110100111100011011101111000",
            "00111110111010000111000101110000",
            "00111111000101100111100100011000",
            "00111111001101010000010011110010",
            "00111111010011110001101110111100",
            "00111111011001000001100100000000",
            "00111111011100110111100001110000",
            "00111111011111001101100100100100"
		);
	constant N_float   : float32 := b"0_1000_0100_0100_0000_0000_0000_0000_000";
	constant two_float : float32 := b"0_1000_0000_0000_0000_0000_0000_0000_000";
	constant zero      : float32 := b"0_0000_0000_0000_0000_0000_0000_0000_000";
	constant one       : float32 := b"0_0111_1111_0000_0000_0000_0000_0000_000";
	constant sqrt_two  : float32 := sqrt(two_float);
	signal x           : float32_arr(0 to N-1) := (others => zero);
    signal tmp         : float32 := one;
begin
	
	process_calculate_rms : process(clk)
        variable tmp_S 	: float32 := zero;
        variable tmp_C 	: float32 := zero;
        variable current : natural range 0 to N := 0;
        variable m_one : float32 := -two_float;
	begin
		if rising_edge(clk) then
		    x(current) <= adc;
		    report "current = " & integer'image(current);
			current := current + 1;
		    if(current = N) then current := 0; end if;
--		end if;
--		if falling_edge(clk) then
		    tmp_S := zero;
			tmp_C := zero;
			for i in 0 to N-1 loop
				tmp_S := tmp_S + x(i) * C(i);
				tmp_C := tmp_C + x(i) * C(i + N/4);
			end loop;
            tmp <= sqrt(sq(tmp_S) + sq(tmp_C));
            Irms <= tmp * (sqrt_two / N_float); --two_float
		end if;
	end process;
	
--	process_update_samples : process(clk)
--        variable current : natural range 0 to N := 0;
--	begin
--		if rising_edge(clk) then
--			x(current) <= adc;
--			current := current + 1;
--		    if(current = N) then current := 0; end if;
--		    report "current = " & integer'image(current);
--		end if;
--	end process;
	
end architecture;



--library ieee;
--use ieee.std_logic_1164.all;
--use std.textio.all;

--use work.my_types.all;
--use work.my_float_package.all;
--use work.my_functions.all;

--entity dft32 is
--	generic( N : natural := 40 );
--	port (
--			clk : in std_logic := '0';
--			adc : in float32 := "00111111100000000000000000000000";
--			Irms  : out float32
--		);
--end entity;

--architecture dft32 of dft32 is
--	constant C : float32_arr(0 to N-1+N/4) :=
--		(
--			"00000000000000000000000000000000",
--            "00111110001000000011000001011000",
--            "00111110100111100011011101111000",
--            "00111110111010000111000101110000",
--            "00111111000101100111100100011000",
--            "00111111001101010000010011110010",
--            "00111111010011110001101110111100",
--            "00111111011001000001100100000000",
--            "00111111011100110111100001110000",
--            "00111111011111001101100100100100",
--            "00111111100000000000000000000000",
--            "00111111011111001101100100100100",
--            "00111111011100110111100001110000",
--            "00111111011001000001100100000000",
--            "00111111010011110001101110111100",
--            "00111111001101010000010011110010",
--            "00111111000101100111100100011000",
--            "00111110111010000111000101110000",
--            "00111110100111100011011101111000",
--            "00111110001000000011000001011000",
--            "00000000000000000000000000000000",
--            "10111110001000000011000001011000",
--            "10111110100111100011011101111000",
--            "10111110111010000111000101110000",
--            "10111111000101100111100100011000",
--            "10111111001101010000010011110010",
--            "10111111010011110001101110111100",
--            "10111111011001000001100100000000",
--            "10111111011100110111100001110000",
--            "10111111011111001101100100100100",
--            "10111111100000000000000000000000",
--            "10111111011111001101100100100100",
--            "10111111011100110111100001110000",
--            "10111111011001000001100100000000",
--            "10111111010011110001101110111100",
--            "10111111001101010000010011110010",
--            "10111111000101100111100100011000",
--            "10111110111010000111000101110000",
--            "10111110100111100011011101111000",
--            "10111110001000000011000001011000",
--            "00000000000000000000000000000000",
--            "00111110001000000011000001011000",
--            "00111110100111100011011101111000",
--            "00111110111010000111000101110000",
--            "00111111000101100111100100011000",
--            "00111111001101010000010011110010",
--            "00111111010011110001101110111100",
--            "00111111011001000001100100000000",
--            "00111111011100110111100001110000",
--            "00111111011111001101100100100100"
--		);
--	constant zero       : float32 := b"00000000000000000000000000000000";
--	signal win		 	: float32_arr(0 to N-1) := (others => zero);
--	constant N_float 	: float32 := "01000010001000000000000000000000";
--	constant two_float 	: float32 := "01000000000000000000000000000000";
--begin
--	process(clk,win)
--	variable current 	: natural := 0;
--	variable count 		: natural := 0;
--	variable tmp_S	 	: float32 := zero;
--	variable tmp_C 		: float32 := zero;
--	variable tmp 		: float32 := zero;
--	begin
--		if(clk' event and  clk = '1') then
----			win(current) <= adc;
----			current := current+1;
----			if(current=N) then current := 0;
----			end if;
----			tmp_S := zero;
----			tmp_C := zero;
----			for i in 0 to N-1 loop
----				tmp_S := tmp_S + win(i) * C(i);
----				tmp_C := tmp_C + win(i) * C(i + N/4);
----			end loop;
----			tmp := sq(tmp_S)+sq(tmp_C);
----			if(count < N) then
----				count := count+1;
----				Irms <= zero;
----			else
--			    Irms <= adc * adc / zero;
----			end if;
--		end if;
--	end process;
	
--end architecture;