note
	description: "Test suite for {EFFECTIVE_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	EFFECTIVE_NATURAL_SET_TESTS

inherit
	NATURAL_SET_TESTS
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_NATURAL_SET}.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}"
		do
			Precursor {NATURAL_SET_TESTS}
			test_default_create
			test_make_extended
			test_given_element
			test_subset
			test_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_NATURAL_SET}.default_create.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.default_create"
		do
			assert ("default_create", attached (create {like set_to_be_tested}))
		end

	test_make_extended
			-- Test {EFFECTIVE_NATURAL_SET}.make_extended.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.make_extended"
		do
			assert (
					"make_extended",
					attached (
						create {like set_to_be_tested}.make_extended (n1, set_to_be_tested)
					)
				)
		end

feature -- Test routines (Primitive)

	test_given_element
			-- Test {EFFECTIVE_NATURAL_SET}.given_element.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.given_element"
		local
			s: like set_to_be_tested
		do
			create s
			s := s.extended (n1)
			assert ("{n1} /= {}", s.subset /= s)
			assert ("{n1}", s.given_element ≍ n1)

			s := s.extended (n2.standard_twin)
			assert ("{n1,n2} /= {}", s.subset /= s)
			assert ("{n1,n2}", s.given_element ≍ n2)

			s := s.extended (n3.twin)
			assert ("{n1,n2,n3} /= {}", s.subset /= s)
			assert ("{n1,n2,n3}", s.given_element ≍ n3)

			s := s.extended (n4.deep_twin)
			assert ("{n1,n2,n3,n4} /= {}", s.subset /= s)
			assert ("{n1,n2,n3,n4}", s.given_element ≍ n4)
		end

	test_subset
			-- Test {EFFECTIVE_NATURAL_SET}.subset.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.subset"
		local
			s: like set_to_be_tested
		do
			create s
			assert ("{}", s = s.subset)

			s := s.extended (n1)
			assert ("{n1}", s /= s.subset)
		end

feature -- Test routines (Output)

	test_out
			-- Test {EFFECTIVE_NATURAL_SET}.out.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.out"
		local
			s: like set_to_be_tested
			s_out: STRING
		do
			create s
			assert ("{}", s.out ~ "{}")

			s := s.extended (n1)
			s_out := s.out
			assert ("n1", s_out ~ "{" + n1.out + "}")

			s := s.extended (n2)
			s_out := s.out
			assert ("{n1,n2}", s_out ~ "{} & (" + n1.out + ") & (" + n2.out + ")")

			s := s.extended (n3)
			s_out := s.out
			assert ("{n1,n2,n3}", s_out ~ "{} & (" + n1.out + ") & (" + n2.out + ") & (" + n3.out + ")")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end


feature -- Test routines (Status report)

	test_debug_output
			-- Test {EFFECTIVE_NATURAL_SET}.debug_output.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.debug_output"
		local
			s: like set_to_be_tested
			s_debug_output: STRING_32
		do
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			s := s.extended (n1)
			s_debug_output := s.debug_output
			assert ("{n1}", s_debug_output ~ {STRING_32} "{" + n1.out + "}")

			s := s.extended (n2)
			s_debug_output := s.debug_output
			assert ("{n1,n2}", s_debug_output ~ {STRING_32} "{} & (" + n1.out + ") & (" + n2.out + ")")

			s := s.extended (n3)
			s_debug_output := s.debug_output
			assert ("{n1,n2,n3}", s_debug_output ~ {STRING_32} "{} & (" + n1.out + ") & (" + n2.out + ") & (" + n3.out + ")")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

feature -- Factory (element to be tested)

	set_to_be_tested: EFFECTIVE_NATURAL_SET
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Factory

	n1: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 1
		ensure then
			class
		end

	n2: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 2
		ensure then
			class
		end

	n3: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 3
		ensure then
			class
		end

	n4: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 4
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
