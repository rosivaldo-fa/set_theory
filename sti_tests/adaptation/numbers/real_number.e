note
	description: "[
			Descendant of {STI_REAL_NUMBER} whose features with restricted access are available to be tested. Notice that inheriting from an expanded class is a
			non-conformant inheritance.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	REAL_NUMBER

inherit
	STI_REAL_NUMBER
		export {REAL_NUMBER_PROPERTIES, REAL_NUMBER_EFFECTIVE_TESTS}
			sign_bit_status,
			exponent_bit_pattern,
			Exponent_width,
			mantissa_bit_pattern
		end

create
	default_create,
	make,
	make_from_reference

convert
	make ({REAL}),
	make_from_reference ({STS_REAL_NUMBER, STI_REAL_NUMBER, STS_RATIONAL_NUMBER, STS_INTEGER_NUMBER, STS_NATURAL_NUMBER}),
	value: {REAL, REAL_REF, NUMERIC, COMPARABLE, HASHABLE}

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
