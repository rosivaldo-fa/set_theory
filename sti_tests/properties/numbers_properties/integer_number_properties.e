note
	description: "Implementation of {STST_INTEGER_NUMBER_PROPERTIES}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_NUMBER_PROPERTIES

inherit
	STST_INTEGER_NUMBER_PROPERTIES

feature -- Access

	zero: STI_INTEGER_NUMBER
			-- <Precursor>
		once
		end

	One: STI_INTEGER_NUMBER
			-- <Precursor>
		once
			Result := 1
		ensure then
			class
		end

feature -- Properties (Conversion)

	as_rational_ok (i: STI_INTEGER_NUMBER): BOOLEAN
			-- Do the properties verified within number theory hold for {STI_INTEGER_NUMBER}.as_rational?
		do
			check
				is_integer: i.as_rational.is_integer
			then
				Result := True
			end
		end

feature -- Anchor

	rational_anchor: STI_RATIONAL_NUMBER
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

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
