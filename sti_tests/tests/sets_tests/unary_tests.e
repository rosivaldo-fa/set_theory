note
	description: "Implementation of {STST_UNARY_TESTS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [G]

inherit
	STST_UNARY_TESTS [G]
		undefine
			default_create
		end

	ELEMENT_TESTS
		undefine
			test_all,
			test_is_in,
			test_is_not_in,
			some_element
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
