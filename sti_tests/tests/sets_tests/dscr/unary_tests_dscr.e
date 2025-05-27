note
	description: "{STST_UNARY_TESTS}, derived for {detachable separate CHARACTER_REF} generic parameter."
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_TESTS_DSCR

inherit
	STST_UNARY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_object_g as some_separate_character_ref,
			some_immediate_set_g as some_immediate_set_dscr
		undefine
			default_create
		end

	ELEMENT_TESTS
		undefine
			test_all,
			test_is_in,
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
