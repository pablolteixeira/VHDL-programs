library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_ula is 
	port(
		a, b: in std_logic_vector(3 downto 0);
		sel: in std_logic_vector(2 downto 0);
		over, zero, neg: out std_logic;
		c: out std_logic_vector(3 downto 0)
		);
end simple_ula;

architecture ula of simple_ula is
	signal result, addition, subtration, and_logic, or_logic, or_exclusive, negative: signed(4 downto 0);
begin
	addition <= signed(a(3) & a) + signed(b(3) & b);
	subtration <= signed(a(3) & a) - signed(b(3) & b);
	and_logic <= signed(a(3) & a) and signed(b(3) & b);
	or_logic <=	signed(a(3) & a) or signed(b(3) & b);
	or_exclusive <= signed(a(3) & a) xor signed(b(3) & b);
	negative <= not signed((a(3) & a));
	
	
	result <= addition when sel = "000" else
				 subtration when sel = "001" else
				 and_logic when sel = "010" else
				 or_logic when sel = "011" else
				 or_exclusive when sel = "100" else
				 negative when sel = "101" else
				 "00000";
	
	over <= '1' when sel = "000" and result(3) = '1' else '0';
	zero <= '1' when result = "00000" else '0';
	neg <= '1' when result < 0 else '0';
	c <= std_logic_vector(result(3 downto 0));

end ula;			 
