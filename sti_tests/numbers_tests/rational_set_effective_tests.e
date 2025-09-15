note
	description: "Test suite for {STI_RATIONAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	TODO: "AutoTest may confuse {STST_RATIONAL_SET_TESTS} with {RATIONAL_SET_TESTS}."

class
	RATIONAL_SET_EFFECTIVE_TESTS

inherit
	STST_RATIONAL_SET_TESTS
		rename
			u as q,
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

	UNARY_TESTS [STS_RATIONAL_NUMBER]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested,
			some_object_g as some_rational_number,
			object_deep_twin_g as object_deep_twin_pq,
			object_standard_twin_g as object_standard_twin_pq,
			object_twin_g as object_twin_pq,
			same_object_g as same_object_pq,
			some_equality_g as some_equality_pq,
			some_immediate_set_family_g as some_immediate_set_family_pq,
			some_immediate_set_g as some_immediate_set_pq,
			some_immediate_universe_g as some_immediate_universe_pq,
			some_object_deep_equality_g as some_object_deep_equality_pq,
			some_object_equality_g as some_object_equality_pq,
			some_object_standard_equality_g as some_object_standard_equality_pq,
			some_reference_equality_g as some_reference_equality_pq,
			some_set_family_g as some_set_family_pq,
			some_set_g as some_set_pq,
			some_universe_g as some_universe_pq,
			some_equality_sg as some_equality_spq,
			some_immediate_set_sg as some_immediate_set_spq,
			some_object_deep_equality_sg as some_object_deep_equality_spq,
			some_object_equality_sg as some_object_equality_spq,
			some_object_standard_equality_sg as some_object_standard_equality_spq,
			some_reference_equality_sg as some_reference_equality_spq,
			some_set_sg as some_set_spq
		undefine
			some_set_pq,
			some_universe_pq,
			some_equality_pq,
			some_object_equality_pq,
			some_object_deep_equality_pq,
			some_reference_equality_pq,
			some_object_standard_equality_pq
		redefine
			test_all,
			set_to_be_tested,
			some_immediate_set_pq,
			some_immediate_universe_pq
		end

feature -- Access

	q: STI_RATIONAL_NUMBERS
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_RATIONAL_SET}.
		note
			testing: "covers/{STI_RATIONAL_SET}"
		do
			Precursor {STST_RATIONAL_SET_TESTS}
			test_default_create
			test_make_extended
			test_out
			test_debug_output
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {STI_RATIONAL_SET}.default_create.
		note
			testing: "covers/{STI_RATIONAL_SET}.default_create"
		do
			assert ("default_create", attached (create {like rational_set_to_be_tested}))
		end

	test_make_extended
			-- Test {STI_RATIONAL_SET}.make_extended.
		note
			testing: "covers/{STI_RATIONAL_SET}.make_extended"
		local
			s: like some_rational_set
		do
			s := some_rational_set
			assert ("make_extended", attached (create {like rational_set_to_be_tested}.make_extended (some_rational_number, s)))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STI_RATIONAL_SET}.extended.
		note
			testing: "covers/{STI_RATIONAL_SET}.extended"
		do
			Precursor {STST_RATIONAL_SET_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- Test {STI_RATIONAL_SET}.out.
		note
			testing: "covers/{STI_RATIONAL_SET}.out"
		local
			pq, pq_2, pq_3: like some_rational_number
			s: like set_to_be_tested
			pq_out, pq_2_out, pq_3_out, s_out: STRING
		do
			create s
			assert ("{}", s.out ~ "{}")

			pq := some_rational_number
			pq_out := if attached {STS_INTEGER_NUMBER} pq then
					pq.out + "/1"
				else
					pq.out
				end
			s := s.extended (pq)
			s_out := s.out
			assert ("{pq}", s_out ~ "{} & (" + pq_out + ")")

			pq_2 := some_rational_number
			pq_2_out := if attached {STS_INTEGER_NUMBER} pq_2 then
					pq_2.out + "/1"
				else
					pq_2.out
				end
			s := s.extended (pq_2)
			s_out := s.out
			assert ("{pq, pq_2}", s_out ~ "{} & (" + pq_out + ") & (" + pq_2_out + ")")

			pq_3 := some_rational_number
			pq_3_out := if attached {STS_INTEGER_NUMBER} pq_3 then
					pq_3.out + "/1"
				else
					pq_3.out
				end
			s := s.extended (pq_3)
			s_out := s.out
			assert ("{pq, pq_2, pq_3}", s_out ~ "{} & (" + pq_out + ") & (" + pq_2_out + ") & (" + pq_3_out + ")")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {STI_RATIONAL_SET}.debug_output.
		note
			testing: "covers/{STI_RATIONAL_SET}.debug_output"
		local
			pq, pq_2, pq_3: like some_rational_number
			s: like set_to_be_tested
			pq_out, pq_2_out, pq_3_out: STRING
			s_debug_output: STRING_32
		do
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			pq := some_rational_number
			pq_out := if attached {STS_INTEGER_NUMBER} pq then
					pq.out + "/1"
				else
					pq.out
				end
			s := s.extended (pq)
			s_debug_output := s.debug_output
			assert ("{pq}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_out) + ")")

			pq_2 := some_rational_number
			pq_2_out := if attached {STS_INTEGER_NUMBER} pq_2 then
					pq_2.out + "/1"
				else
					pq_2.out
				end
			s := s.extended (pq_2)
			s_debug_output := s.debug_output
			assert ("{pq, pq_2}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_2_out) + ")")

			pq_3 := some_rational_number
			pq_3_out := if attached {STS_INTEGER_NUMBER} pq_3 then
					pq_3.out + "/1"
				else
					pq_3.out
				end
			s := s.extended (pq_3)
			s_debug_output := s.debug_output
			assert ("{pq, pq_2, pq_3}", s_debug_output ~ {STRING_32} "{} & (" + {UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_2_out) + ") & (" +
					{UTF_CONVERTER}.utf_8_string_8_to_string_32 (pq_3_out) + ")")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_rational_set
			-- Natural set meant to be under tests
		do
			Result := some_immediate_rational_set
		end

feature -- Factory (rational number)

	some_immediate_set_pq: STI_SET [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				s: attached {STI_SET [STS_RATIONAL_NUMBER]} some_immediate_instance (
							agent: STI_SET [STS_RATIONAL_NUMBER]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_rational_number, some_equality_pq)
									end
								end
						) as s -- `some_immediate_instance' definition
				monomorphic: s.generating_type ~ {detachable STI_SET [STS_RATIONAL_NUMBER]}
			then
				Result := cropped_set (s)
			end
		end

	some_immediate_universe_pq: STI_UNIVERSE [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				u: attached {STI_UNIVERSE [STS_RATIONAL_NUMBER]} some_immediate_instance (
							agent: STI_UNIVERSE [STS_RATIONAL_NUMBER]
								do
									create Result
								end
						) as u -- `some_immediate_instance' definition
				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_RATIONAL_NUMBER]}
			then
				Result := u
			end
		end

feature -- Anchor

	universe_anchor: STI_UNIVERSE [STS_RATIONAL_NUMBER]
--	universe_anchor: STI_RATIONAL_NUMBERS
			-- <Precursor>
		once
			Result := q
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
