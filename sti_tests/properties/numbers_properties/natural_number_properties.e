note
	description: "Implementation of {STST_NATURAL_NUMBER_PROPERTIES}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_NUMBER_PROPERTIES

inherit
	STST_NATURAL_NUMBER_PROPERTIES

feature -- Access

	zero: STI_NATURAL_NUMBER
			-- <Precursor>
		once
		end

	One: STI_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {STI_NATURAL_NUMBER}.One
		ensure then
			class
		end

feature -- Properties (Conversion)

	as_integer_number_ok (n: STI_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_NATURAL_NUMBER}.as_integer?
		do
			check
				is_natural: n.as_integer_number.is_natural
			then
				Result := True
			end
		end

	as_rational_number_ok (n: STI_NATURAL_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_NATURAL_NUMBER}.as_rational?
		do
			check
				is_integer: n.as_rational_number.is_integer
				is_natural: n.as_rational_number.is_natural
			then
				Result := True
			end
		end

feature -- Anchor

	natural_anchor: STI_NATURAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	integer_anchor: STI_INTEGER_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

	rational_anchor: STI_RATIONAL_NUMBER
			-- <Precursor>
		once
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
