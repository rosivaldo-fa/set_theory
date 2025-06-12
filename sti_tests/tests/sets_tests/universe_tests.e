note
	description: "Test suite for {STI_UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNIVERSE_TESTS [G]

inherit
	STST_UNIVERSE_TESTS [G]
		undefine
			default_create,
			some_set_g
		redefine
			test_has
		end

	UNARY_TESTS [G]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as universe_to_be_tested
		undefine
			test_all,
			universe_to_be_tested
		end

feature -- Test routines (Membership)

	test_has
			-- Test {STS_SET}.has.
		note
			testing: "covers/{STS_SET}.has"
		local
			a: G
			u: like universe_to_be_tested
		do
			Precursor {STST_UNIVERSE_TESTS}
			a := some_object_g
			u := universe_to_be_tested
			assert ("always has", u ∋ a)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
