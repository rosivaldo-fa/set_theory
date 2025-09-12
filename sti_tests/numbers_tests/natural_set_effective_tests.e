note
	description: "Test suite for {STI_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_NATURAL_SET_TESTS} with {NATURAL_SET_TESTS}."

class
	NATURAL_SET_EFFECTIVE_TESTS

inherit
	STST_NATURAL_SET_TESTS
		rename
			u as n,
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number
		undefine
			default_create,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number,
			some_rational_set
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
			some_object_g as some_natural_number,
			object_deep_twin_g as object_deep_twin_n,
			object_standard_twin_g as object_standard_twin_n,
			object_twin_g as object_twin_n,
			same_object_g as same_object_n,
			some_equality_g as some_equality_n,
			some_immediate_set_family_g as some_immediate_set_family_n,
			some_immediate_set_g as some_immediate_set_n,
			some_immediate_universe_g as some_immediate_universe_n,
			some_object_deep_equality_g as some_object_deep_equality_n,
			some_object_equality_g as some_object_equality_n,
			some_object_standard_equality_g as some_object_standard_equality_n,
			some_reference_equality_g as some_reference_equality_n,
			some_set_family_g as some_set_family_n,
			some_set_g as some_set_n,
			some_universe_g as some_universe_n,
			some_equality_sg as some_equality_sn,
			some_immediate_set_sg as some_immediate_set_sn,
			some_object_deep_equality_sg as some_object_deep_equality_sn,
			some_object_equality_sg as some_object_equality_sn,
			some_object_standard_equality_sg as some_object_standard_equality_sn,
			some_reference_equality_sg as some_reference_equality_sn,
			some_set_sg as some_set_sn
		undefine
			some_set_n,
			some_universe_n,
			some_equality_n,
			some_object_equality_n,
			some_object_deep_equality_n,
			some_reference_equality_n,
			some_object_standard_equality_n
		redefine
			test_all,
			set_to_be_tested,
			some_immediate_set_n,
			some_immediate_universe_n
		end

feature -- Access

	n: STI_NATURAL_NUMBERS
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_NATURAL_SET}.
		note
			testing: "covers/{STI_NATURAL_SET}"
		do
			Precursor {STST_NATURAL_SET_TESTS}
			test_default_create
			test_make_extended
			test_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_NATURAL_SET}.default_create.
		note
			testing: "covers/{STI_NATURAL_SET}.default_create"
		do
			assert ("default_create", attached (create {like natural_set_to_be_tested}))
		end

	test_make_extended
			-- Test {STI_NATURAL_SET}.make_extended.
		note
			testing: "covers/{STI_NATURAL_SET}.make_extended"
		local
			s: like some_natural_set
		do
			s := some_natural_set
			assert ("make_extended", attached (create {like natural_set_to_be_tested}.make_extended (some_natural_number, s)))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_NATURAL_SET}.extended.
		note
			testing: "covers/{STI_NATURAL_SET}.extended"
		do
			Precursor {STST_NATURAL_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_NATURAL_SET}.out.
		note
			testing: "covers/{STI_NATURAL_SET}.out"
		local
			n1, n2, n3: like some_natural_number
			s: like set_to_be_tested
			s_out: STRING
		do
			create s
			assert ("{}", s.out ~ "{}")

			n1 := some_natural_number
			s := s.extended (n1)
			s_out := s.out
			assert ("{n1}", s_out ~ "{} & (" + n1.out + ")")

			n2 := some_natural_number
			s := s.extended (n2)
			s_out := s.out
			assert ("{n1, n2}", s_out ~ "{} & (" + n1.out + ") & (" + n2.out + ")")

			n3 := some_natural_number
			s := s.extended (n3)
			s_out := s.out
			assert ("{n1, n2, n3}", s_out ~ "{} & (" + n1.out + ") & (" + n2.out + ") & (" + n3.out + ")")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_NATURAL_SET}.debug_output.
		note
			testing: "covers/{STI_NATURAL_SET}.debug_output"
		local
			n1, n2, n3: like some_natural_number
			s: like set_to_be_tested
			s_debug_output: STRING_32
		do
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			n1 := some_natural_number
			s := s.extended (n1)
			s_debug_output := s.debug_output
			assert ("{n1}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n1.out) + ")")

			n2 := some_natural_number
			s := s.extended (n2)
			s_debug_output := s.debug_output
			assert ("{n1, n2}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n1.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (n2.out) + ")")

			n3 := some_natural_number
			s := s.extended (n3)
			s_debug_output := s.debug_output
			assert ("{n1, n2, n3}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (n1.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (n2.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (n3.out) + ")")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_natural_set
			-- Natural set meant to be under tests
		do
			Result := some_immediate_natural_set
		end

feature -- Factory (natural number)

	some_immediate_set_n: STI_SET [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_NATURAL_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_NATURAL_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_natural_number, some_equality_n)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_NATURAL_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_n: STI_UNIVERSE [STS_NATURAL_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_NATURAL_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_NATURAL_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_NATURAL_NUMBER]}
			then
				Result := u
			end
		end

feature -- Anchor

	universe_anchor: STI_NATURAL_NUMBERS
			-- <Precursor>
		once
			Result := n
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
