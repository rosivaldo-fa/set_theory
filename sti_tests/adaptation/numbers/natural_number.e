note
	description: "Implementation of {STS_NATURAL_NUMBER}"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	NATURAL_NUMBER

inherit
	STI_NATURAL_NUMBER
		export {ELEMENT_TESTS}
			stored_value_mask
		end

create
	default_create,
	make

convert
	make ({NATURAL})

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
