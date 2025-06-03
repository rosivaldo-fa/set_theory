note
	description: "Test suite for {STI_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	STST_SET_TESTS [G]
		undefine
			default_create
		redefine
			test_all
		end

	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			element_to_be_tested as set_to_be_tested
		undefine
			test_element_is_in,
			set_to_be_tested,
			some_element
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
			test_make_extended
			test_out
			test_element_out
		end

feature -- Test routines (Initialization)

	test_make_extended
			-- Test {STI_SET}.make_extended.
		note
			testing: "covers/{STI_SET}.make_extended"
		do
			assert ("make_extended", attached (create {STI_SET [G]}.make_extended (some_object_g, some_equality_g, some_immediate_set_g)))
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_SET}.out.
		note
			testing: "covers/{STI_SET}.out"
		local
			a, b, c: G
			s: like set_to_be_tested
		do
			create s
			assert ("{}", s.out ~ "{}")

			c := some_object_g
			s := s.extended (c, some_equality_g)
			assert ("{c}", s.out ~ "{" + s.element_out (c) + "}")

			b := some_object_g
			s := s.extended (b, some_equality_g)
			assert ("{b, c}", s.out ~ "{" + s.element_out (b) + "," + s.element_out (c) + "}")

			a := some_object_g
			s := s.extended (a, some_equality_g)
			assert ("{a, b, c}", s.out ~ "{" + s.element_out (a) + "," + s.element_out (b) + "," + s.element_out (c) + "}")

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

feature -- Factory (Set)

	some_immediate_set_g: STI_SET [G]
			-- <Precursor>
		deferred
		end

	some_immediate_set_sg: STI_SET [STS_SET [G]]
			-- <Precursor>
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
