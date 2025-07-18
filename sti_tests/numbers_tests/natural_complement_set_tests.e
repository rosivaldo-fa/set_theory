note
	description: "Test suite for {STI_NATURAL_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NATURAL_COMPLEMENT_SET_TESTS

inherit
	STST_NATURAL_SET_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create,
			some_set_g,
			same_natural_number,
			some_natural_set
		redefine
			test_all,
			test_extended,
			set_to_be_tested
		end

	UNARY_TESTS [STS_NATURAL_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested,
			some_object_g as some_natural_number
		redefine
			test_all,
			set_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_NATURAL_COMPLEMENT_SET}.
		note
			testing: "covers/{STI_NATURAL_COMPLEMENT_SET}"
		do
			Precursor {STST_NATURAL_SET_TESTS}
		end

--feature -- Test routines (Initialization)

--	test_default_create
--			-- Test {STI_NATURAL_SET}.default_create.
--		note
--			testing: "covers/{STI_NATURAL_SET}.default_create"
--		do
--			assert ("default_create", attached (create {like natural_set_to_be_tested}))
--		end

--	test_make_extended
--			-- Test {STI_NATURAL_SET}.make_extended.
--		note
--			testing: "covers/{STI_NATURAL_SET}.make_extended"
--		local
--			s: like some_natural_set
--		do
--			s := some_natural_set
--			assert ("make_extended", attached (create {like natural_set_to_be_tested}.make_extended (some_natural_number, s)))
--		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_NATURAL_COMPLEMENT_SET}.extended.
		note
			testing: "covers/{STI_NATURAL_COMPLEMENT_SET}.extended"
		do
			Precursor {STST_NATURAL_SET_TESTS}
		end

--feature -- Test routines (Output)

--	test_out
--			-- Test {STI_NATURAL_SET}.out.
--		note
--			testing: "covers/{STI_NATURAL_SET}.out"
--		local
--			n, m, l: like some_natural_number
--			s: like set_to_be_tested
--			s_out: STRING
--		do
--			create s
--			assert ("{}", s.out ~ "{}")

--			n := some_natural_number
--			s := s.extended (n)
--			s_out := s.out
--			assert ("{n}", s_out ~ "{} & (" + n.out + ")")

--			m := some_natural_number
--			s := s.extended (m)
--			s_out := s.out
--			assert ("{n, m}", s_out ~ "{} & (" + n.out + ") & (" + m.out + ")")

--			l := some_natural_number
--			s := s.extended (l)
--			s_out := s.out
--			assert ("{n, m, l}", s_out ~ "{} & (" + n.out + ") & (" + m.out + ") & (" + l.out + ")")

--			s := set_to_be_tested
--			assert ("out", attached s.out)
--		end

--feature -- Test routines (Status report)

--	test_debug_output
--			-- Test {STI_NATURAL_SET}.debug_output.
--		note
--			testing: "covers/{STI_NATURAL_SET}.debug_output"
--		local
--			n, m, l: like some_natural_number
--			s: like set_to_be_tested
--			s_debug_output: STRING_32
--		do
--			create s
--			assert ("{}", s.debug_output ~ {STRING_32} "{}")

--			n := some_natural_number
--			s := s.extended (n)
--			s_debug_output := s.debug_output
--			assert ("{n}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n.out) + ")")

--			m := some_natural_number
--			s := s.extended (m)
--			s_debug_output := s.debug_output
--			assert ("{n, m}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n.out) + ") & (" +
--					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (m.out) + ")")

--			l := some_natural_number
--			s := s.extended (l)
--			s_debug_output := s.debug_output
--			assert ("{n, m, l}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n.out) + ") & (" +
--					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (m.out) + ") & (" +
--					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (l.out) + ")")

--			s := set_to_be_tested
--			assert ("debug_output", attached s.debug_output)
--		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_natural_complement_set
			-- Natural complement set meant to be under tests
		do
			Result := some_immediate_natural_complement_set
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
