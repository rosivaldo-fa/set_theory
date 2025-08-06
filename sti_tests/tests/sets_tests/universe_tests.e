note
	description: "Test suite for {STI_UNIVERSE}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNIVERSE_TESTS [G]

inherit
	STST_UNIVERSE_TESTS [G]
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number
		undefine
			default_create,
			some_set_g,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set
		redefine
			test_all,
			test_has,
			test_does_not_have,
			test_extended
		end

	UNARY_TESTS [G]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as universe_to_be_tested
		undefine
			universe_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_UNIVERSE}.
		note
			testing: "covers/{STI_UNIVERSE}"
		do
			Precursor {UNARY_TESTS}
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_UNIVERSE}.default_create.
		note
			testing: "covers/{STI_UNIVERSE}.default_create"
		do
			assert ("default_create", attached (create {like universe_to_be_tested}))
		end

feature -- Test routines (Membership)

	test_has
			-- Test {STI_UNIVERSE}.has.
		note
			testing: "covers/{STI_UNIVERSE}.has"
		local
			a: G
			l_u: like universe_to_be_tested
		do
			Precursor {STST_UNIVERSE_TESTS}
			a := some_object_g
			l_u := universe_to_be_tested
			assert ("always has", l_u ∋ a)
		end

	test_does_not_have
			-- Test {STI_UNIVERSE}.does_not_have.
		note
			testing: "covers/{STI_UNIVERSE}.does_not_have"
		local
			a: G
			l_u: like universe_to_be_tested
		do
			Precursor {STST_UNIVERSE_TESTS}
			a := some_object_g
			l_u := universe_to_be_tested
			assert ("never does_not_have", not (l_u ∌ a))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_UNIVERSE}.extended.
		note
			testing: "covers/{STI_UNIVERSE}.extended"
		local
			l_u: like universe_to_be_tested
			a: G
			eq: like some_equality_g
		do
			Precursor {STST_UNIVERSE_TESTS}
			l_u := universe_to_be_tested
			a := some_object_g
			eq := some_equality_g
			assert ("no change", l_u.extended (same_object_g (a, eq), eq) = l_u) -- TODO: Use set equality instead.
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_UNIVERSE}.out.
		note
			testing: "covers/{STI_UNIVERSE}.out"
		do
			assert ("out", attached universe_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_UNIVERSE}.debug_output.
		note
			testing: "covers/{STI_UNIVERSE}.debug_output"
		do
			assert ("debug_output", attached universe_to_be_tested.debug_output)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
