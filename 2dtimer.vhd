-- qynvi
-- 2/19/2011
-- 2 Digit Timer RTL

entity 2dtimer is
	generic (fclk: integer := 50_000_000); --50MHz
	port (ena, clk, rst: in bit;
		  ssdL, ssdR: out bit_vector(6 downto 0));
	end entity;

architecture tdt of 2dtimer is
	begin
		process (clk, rst, ena)
			variable ncounter: natural range 0 to fclk := 0;
			variable counterR: natural range 0 to 10 := 0;
			variable counterL: natural range 0 to 6 := 0;
		begin

			--- timer counter
			if (rst='1') then
				ncounter := 0;
				counterR := 0;
				counterL := 0;
			elsif (rst='0') then
				if (clk'event and clk='1') then
					if (ena='1' and counterL<6) then
						ncounter := ncounter + 1;
						if (ncounter=fclk) then
							ncounter := 0;
							counterR := counterR + 1;
						end if;
						if (counterR=10) then
							counterR := 0;
							counterL := counterL + 1;
						end if;
					end if;
				end if;
			end if;

			--- LCD driver
			case counterR is
				when 0 => ssdR<="0000001";
				when 1 => ssdR<="1001111";
				when 2 => ssdR<="0010010";
				when 3 => ssdR<="0000110";
				when 4 => ssdR<="1001100";
				when 5 => ssdR<="0100100";
				when 6 => ssdR<="0100000";
				when 7 => ssdR<="0001111";
				when 8 => ssdR<="0000000";
				when 9 => ssdR<="0000100";
				when others => ssdR<="0110000";
			end case;
			case counterL is
				when 0 => ssdL<="0000001";
				when 1 => ssdL<="1001111";
				when 2 => ssdL<="0010010";
				when 3 => ssdL<="0000110";
				when 4 => ssdL<="1001100";
				when 5 => ssdL<="0100100";
				when 6 => ssdL<="0100000";
				when others => ssdL<="0110000";
			end case;

		end process;
end architecture;
