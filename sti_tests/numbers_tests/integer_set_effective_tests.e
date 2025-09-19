note
	description: "Test suite for {STI_INTEGER_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_INTEGER_SET_TESTS} with {INTEGER_SET_TESTS}."

class
	INTEGER_SET_EFFECTIVE_TESTS

inherit
	STST_INTEGER_SET_TESTS
		rename
			u as z,
			some_immediate_natural_number as some_expanded_natural_number,
			some_immediate_integer_number as some_expanded_integer_number,
			some_immediate_rational_number as some_expanded_rational_number,
			some_immediate_real_number as some_expanded_real_number
		undefine
			default_create,
			same_natural_number,
			some_natural_set,
			same_integer_number,
			some_integer_set,
			same_rational_number,
			some_rational_set,
			same_real_number
		redefine
			test_all,
			test_extended,
			set_to_be_tested
		end

	UNARY_TESTS [STS_INTEGER_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested,
			some_object_g as some_integer_number,
			object_deep_twin_g as object_deep_twin_i,
			object_standard_twin_g as object_standard_twin_i,
			object_twin_g as object_twin_i,
			same_object_g as same_object_i,
			some_equality_g as some_equality_i,
			some_immediate_set_family_g as some_immediate_set_family_i,
			some_immediate_set_g as some_immediate_set_i,
			some_immediate_universe_g as some_immediate_universe_i,
			some_object_deep_equality_g as some_object_deep_equality_i,
			some_object_equality_g as some_object_equality_i,
			some_object_standard_equality_g as some_object_standard_equality_i,
			some_reference_equality_g as some_reference_equality_i,
			some_set_family_g as some_set_family_i,
			some_set_g as some_set_i,
			some_universe_g as some_universe_i,
			some_equality_sg as some_equality_si,
			some_immediate_set_sg as some_immediate_set_si,
			some_object_deep_equality_sg as some_object_deep_equality_si,
			some_object_equality_sg as some_object_equality_si,
			some_object_standard_equality_sg as some_object_standard_equality_si,
			some_reference_equality_sg as some_reference_equality_si,
			some_set_sg as some_set_si
		undefine
			some_set_i,
			some_universe_i,
			some_equality_i,
			some_object_equality_i,
			some_object_deep_equality_i,
			some_reference_equality_i,
			some_object_standard_equality_i
		redefine
			test_all,
			set_to_be_tested,
			some_immediate_set_i,
			some_immediate_universe_i
		end

feature -- Access

	z: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_INTEGER_SET}.
		note
			testing: "covers/{STI_INTEGER_SET}"
		do
			Precursor {STST_INTEGER_SET_TESTS}
			test_default_create
			test_make_extended
			test_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_INTEGER_SET}.default_create.
		note
			testing: "covers/{STI_INTEGER_SET}.default_create"
		do
			assert ("default_create", attached (create {like integer_set_to_be_tested}))
		end

	test_make_extended
			-- Test {STI_INTEGER_SET}.make_extended.
		note
			testing: "covers/{STI_INTEGER_SET}.make_extended"
		local
			s: like some_integer_set
		do
			s := some_integer_set
			assert ("make_extended", attached (create {like integer_set_to_be_tested}.make_extended (some_integer_number, s)))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_INTEGER_SET}.extended.
		note
			testing: "covers/{STI_INTEGER_SET}.extended"
		do
			Precursor {STST_INTEGER_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_INTEGER_SET}.out.
		note
			testing: "covers/{STI_INTEGER_SET}.out"
		local
			i, j, k: like some_integer_number
			s: like set_to_be_tested
			s_out: STRING
		do
			create s
			assert ("{}", s.out ~ "{}")

			i := some_integer_number
			s := s.extended (i)
			s_out := s.out
			assert ("{i}", s_out ~ "{} & (" + i.out + ")")

			j := some_integer_number
			s := s.extended (j)
			s_out := s.out
			assert ("{i, j}", s_out ~ "{} & (" + i.out + ") & (" + j.out + ")")

			k := some_integer_number
			s := s.extended (k)
			s_out := s.out
			assert ("{i, j, k}", s_out ~ "{} & (" + i.out + ") & (" + j.out + ") & (" + k.out + ")")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_INTEGER_SET}.debug_output.
		note
			testing: "covers/{STI_INTEGER_SET}.debug_output"
		local
			i, j, k: like some_integer_number
			s: like set_to_be_tested
			s_debug_output: STRING_32
		do
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			i := some_integer_number
			s := s.extended (i)
			s_debug_output := s.debug_output
			assert ("{i}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (i.out) + ")")

			j := some_integer_number
			s := s.extended (j)
			s_debug_output := s.debug_output
			assert ("{i, j}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (i.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (j.out) + ")")

			k := some_integer_number
			s := s.extended (k)
			s_debug_output := s.debug_output
			assert ("{i, j, k}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (i.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (j.out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (k.out) + ")")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_integer_set
			-- Natural set meant to be under tests
		do
			Result := some_immediate_integer_set
		end

feature -- Factory (integer number)

	some_immediate_set_i: STI_SET [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_INTEGER_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_INTEGER_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_integer_number, some_equality_i)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_INTEGER_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_i: STI_UNIVERSE [STS_INTEGER_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_INTEGER_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_INTEGER_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_INTEGER_NUMBER]}
			then
				Result := u
			end
		end

feature -- Anchor

	universe_anchor: STI_INTEGER_NUMBERS
			-- <Precursor>
		once
			Result := z
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
