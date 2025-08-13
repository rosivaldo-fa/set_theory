note
	description: "Test suite for {STI_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLEMENT_SET_TESTS [G]

inherit
	STST_SET_TESTS [G]
		rename
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number
		undefine
			default_create,
			some_set_g,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number
		redefine
			test_all,
			set_to_be_tested
		end

	UNARY_TESTS [G]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		redefine
			test_all,
			set_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_COMPLEMENT_SET}.
		note
			testing: "covers/{STI_COMPLEMENT_SET}"
		do
			Precursor {STST_SET_TESTS}
			test_make
			test_out
		end

feature -- Test routines (Initialization)

	test_make
			-- Test {STI_COMPLEMENT_SET}.make.
		note
			testing: "covers/{STI_COMPLEMENT_SET}.make"
		do
			assert ("make", attached (create {like set_to_be_tested}.make (some_set_g)))
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_COMPLEMENT_SET}.out.
		note
			testing: "covers/{STI_COMPLEMENT_SET}.out"
		do
			assert ("out", attached set_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_COMPLEMENT_SET}.debug_output.
		note
			testing: "covers/{STI_COMPLEMENT_SET}.debug_output"
		do
			assert ("debug_output", attached set_to_be_tested.debug_output)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_complement_set_g
			-- Set meant to be under tests
		do
			Result := some_immediate_complement_set_g
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
