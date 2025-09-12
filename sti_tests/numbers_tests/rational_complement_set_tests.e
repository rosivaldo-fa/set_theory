note
	description: "Test suite for {STI_RATIONAL_COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	RATIONAL_COMPLEMENT_SET_TESTS

--inherit
--	STST_RATIONAL_SET_TESTS
--		rename
--			u as n,
--			some_immediate_natural_number as some_expanded_natural_number,
--			some_immediate_rational_number as some_expanded_rational_number,
--			some_immediate_rational_number as some_expanded_rational_number
--		undefine
--			default_create,
--			same_natural_number,
--			some_natural_set,
--			same_rational_number,
--			some_rational_set,
--			same_rational_number,
--			some_rational_set
--		redefine
--			test_all,
--			test_extended,
--			set_to_be_tested
--		end

--	UNARY_TESTS [STS_RATIONAL_NUMBER]
--		rename
--			is_not_in_ok as element_is_not_in_ok,
--			test_is_in as test_element_is_in,
--			test_is_not_in as test_element_is_not_in,
--			element_to_be_tested as set_to_be_tested,
--			some_object_g as some_rational_number,
--			object_deep_twin_g as object_deep_twin_pq,
--			object_standard_twin_g as object_standard_twin_pq,
--			object_twin_g as object_twin_pq,
--			same_object_g as same_object_pq,
--			some_equality_g as some_equality_pq,
--			some_immediate_set_family_g as some_immediate_set_family_pq,
--			some_immediate_set_g as some_immediate_set_pq,
--			some_immediate_universe_g as some_immediate_universe_pq,
--			some_object_deep_equality_g as some_object_deep_equality_pq,
--			some_object_equality_g as some_object_equality_pq,
--			some_object_standard_equality_g as some_object_standard_equality_pq,
--			some_reference_equality_g as some_reference_equality_pq,
--			some_set_family_g as some_set_family_pq,
--			some_set_g as some_set_pq,
--			some_universe_g as some_universe_pq,
--			some_equality_sg as some_equality_spq,
--			some_immediate_set_sg as some_immediate_set_spq,
--			some_object_deep_equality_sg as some_object_deep_equality_spq,
--			some_object_equality_sg as some_object_equality_spq,
--			some_object_standard_equality_sg as some_object_standard_equality_spq,
--			some_reference_equality_sg as some_reference_equality_spq,
--			some_set_sg as some_set_spq
--		undefine
--			some_set_pq,
--			some_universe_pq,
--			some_equality_pq,
--			some_reference_equality_pq,
--			some_object_standard_equality_pq,
--			some_object_equality_pq,
--			some_object_deep_equality_pq
--		redefine
--			test_all,
--			set_to_be_tested,
--			some_immediate_set_pq,
--			some_immediate_universe_pq
--		end

--feature -- Access

--	n: STI_RATIONAL_NUMBERS
--			-- <Precursor>
--		once
--			create Result
--		ensure then
--			class
--		end

--feature -- Test routines (All)

--	test_all
--			-- Test every routine of {STI_RATIONAL_COMPLEMENT_SET}.
--		note
--			testing: "covers/{STI_RATIONAL_COMPLEMENT_SET}"
--		do
--			Precursor {STST_RATIONAL_SET_TESTS}
--			test_out
--		end

--feature -- Test routines (Construction)

--	test_extended
--			-- Test {STI_RATIONAL_COMPLEMENT_SET}.extended.
--		note
--			testing: "covers/{STI_RATIONAL_COMPLEMENT_SET}.extended"
--		do
--			Precursor {STST_RATIONAL_SET_TESTS}
--		end

--feature -- Test routines (Output)

--	test_out
--			-- Test {STI_RATIONAL_COMPLEMENT_SET}.out.
--		note
--			testing: "covers/{STI_RATIONAL_COMPLEMENT_SET}.out"
--		do
--			assert ("out", attached set_to_be_tested.out)
--		end

--feature {NONE} -- Factory (element to be tested)

--	set_to_be_tested: like some_immediate_rational_complement_set
--			-- Rational complement set meant to be under tests
--		do
--			Result := some_immediate_rational_complement_set
--		end

--feature -- Factory (rational number)

--	some_immediate_set_pq: STI_SET [STS_RATIONAL_NUMBER]
--			-- <Precursor>
--		do
--			check
--				s: attached {STI_SET [STS_RATIONAL_NUMBER]} some_immediate_instance (
--							agent: STI_SET [STS_RATIONAL_NUMBER]
--								do
--									across
--										1 |..| some_count.as_integer_32 as pq
--									from
--										create Result
--									loop
--										Result := Result.extended (some_rational_number, some_equality_pq)
--									end
--								end
--						) as s -- `some_immediate_instance' definition
--				monomorphic: s.generating_type ~ {detachable STI_SET [STS_RATIONAL_NUMBER]}
--			then
--				Result := cropped_set (s)
--			end
--		end

--	some_immediate_universe_pq: STI_UNIVERSE [STS_RATIONAL_NUMBER]
--			-- <Precursor>
--		do
--			check
--				u: attached {STI_UNIVERSE [STS_RATIONAL_NUMBER]} some_immediate_instance (
--							agent: STI_UNIVERSE [STS_RATIONAL_NUMBER]
--								do
--									create Result
--								end
--						) as u -- `some_immediate_instance' definition
--				monomorphic: u.generating_type ~ {detachable STI_UNIVERSE [STS_RATIONAL_NUMBER]}
--			then
--				Result := u
--			end
--		end

--feature -- Anchor

--	universe_anchor: STI_RATIONAL_NUMBERS
--			-- <Precursor>
--		once
--			Result := n
--		ensure then
--			class
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
