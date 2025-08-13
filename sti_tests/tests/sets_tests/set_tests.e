note
	description: "Test suite for {STI_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

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
			test_all
		end

	UNARY_TESTS [G]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		undefine
			set_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_SET}.
		note
			testing: "covers/{STI_SET}"
		do
			Precursor {STST_SET_TESTS}
			test_default_create
			test_make_extended
			test_out
			test_element_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_SET}.default_create.
		note
			testing: "covers/{STI_SET}.default_create"
		do
			assert ("default_create", attached (create {like set_to_be_tested}))
		end

	test_make_extended
			-- Test {STI_SET}.make_extended.
		note
			testing: "covers/{STI_SET}.make_extended"
		local
			s: like some_set_g
		do
			s := some_set_g
			assert ("make_extended", attached (create {like set_to_be_tested}.make_extended (some_object_g, some_equality_g, s)))
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_SET}.out.
		note
			testing: "covers/{STI_SET}.out"
		local
			a, b, c: G
			s: like set_to_be_tested
			s_out: STRING
		do
			create s
			assert ("{}", s.out ~ "{}")

			a := some_object_g
			s := s.extended (a, some_equality_g)
			s_out := s.out
			assert ("{a}", s_out ~ "{} & (" + s.element_out (a) + ")")

			b := some_object_g
			s := s.extended (b, some_equality_g)
			s_out := s.out
			assert ("{a, b}", s_out ~ "{} & (" + s.element_out (a) + ") & (" + s.element_out (b) + ")")

			c := some_object_g
			s := s.extended (c, some_equality_g)
			s_out := s.out
			assert ("{a, b, c}", s_out ~ "{} & (" + s.element_out (a) + ") & (" + s.element_out (b) + ") & (" + s.element_out (c) + ")")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end

	test_element_out
			-- Test {STI_SET}.element_out.
		note
			testing: "covers/{STI_SET}.element_out"
		local
			a: G
			s: like set_to_be_tested
		do
			a := some_object_g
			s := set_to_be_tested
			assert ("element_out", attached s.element_out (a))
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_SET}.debug_output.
		note
			testing: "covers/{STI_SET}.debug_output"
		local
			a, b, c: G
			s: like set_to_be_tested
			s_debug_output: STRING_32
		do
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			a := some_object_g
			s := s.extended (a, some_equality_g)
			s_debug_output := s.debug_output
			assert ("{a}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (a)) + ")")

			b := some_object_g
			s := s.extended (b, some_equality_g)
			s_debug_output := s.debug_output
			assert ("{a, b}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (a)) + ") & (" +
				{UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (b)) + ")")

			c := some_object_g
			s := s.extended (c, some_equality_g)
			s_debug_output := s.debug_output
			assert ("{a, b, c}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (a)) + ") & (" +
				{UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (b)) + ") & (" +
				{UTF_CONVERTER}.utf_8_string_8_to_string_32 (s.element_out (c)) + ")")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
