note
	description: "Test suite for {STS_RATIONAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	RATIONAL_SET_TESTS

inherit
	SET_TESTS [STS_RATIONAL_NUMBER]
		rename
			test_extended as test_set_extended,
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
			some_equality_sg as some_equality_si,
			some_immediate_set_sg as some_immediate_set_si,
			some_object_deep_equality_sg as some_object_deep_equality_si,
			some_object_equality_sg as some_object_equality_si,
			some_object_standard_equality_sg as some_object_standard_equality_si,
			some_reference_equality_sg as some_reference_equality_si,
			some_set_sg as some_set_si
		redefine
			test_all,
			some_set_pq,
			some_universe_pq,
			some_equality_pq,
			some_reference_equality_pq,
			some_object_standard_equality_pq,
			some_object_equality_pq,
			some_object_deep_equality_pq
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_RATIONAL_SET}.
		note
			testing: "covers/{STS_RATIONAL_SET}"
		do
			Precursor {SET_TESTS}
			test_extended
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STS_RATIONAL_SET}.extended.
		note
			testing: "covers/{STS_RATIONAL_SET}.extended"
		local
			s: like rational_set_to_be_tested
			pq: like some_rational_number
		do
			s := rational_set_to_be_tested
			pq := some_rational_number
			assert ("{pq, ...}", s.extended (same_rational_number (pq)) ∋ pq)
		end

feature {NONE} -- Factory (element to be tested)

	rational_set_to_be_tested: like some_immediate_rational_set
			-- Rational set meant to be under tests
		do
			Result := some_immediate_rational_set
		end

feature -- Factory (rational number)

	some_set_pq: STS_SET [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := some_immediate_set_pq
			when 1 then
				Result := some_universe_pq
			when 2 then
				Result := some_rational_set
			end
		end

	some_universe_pq: STS_UNIVERSE [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_universe_pq
			when 1 then
--				Result := some_rational_universe
				Result := some_immediate_universe_pq
			end
		end

	some_equality_pq: STS_EQUALITY [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality_pq
			when 1 then
				Result := some_object_standard_equality_pq
			when 2 then
				Result := some_object_equality_pq
			when 3 then
				Result := some_object_deep_equality_pq
			end
		end

	some_reference_equality_pq: STS_REFERENCE_EQUALITY [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_RATIONAL_NUMBER]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_RATIONAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_RATIONAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_pq: STS_OBJECT_STANDARD_EQUALITY [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_RATIONAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_RATIONAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_RATIONAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_equality_pq: STS_OBJECT_EQUALITY [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_RATIONAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_RATIONAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_RATIONAL_NUMBER]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_pq: STS_OBJECT_DEEP_EQUALITY [STS_RATIONAL_NUMBER]
			-- <Precursor>
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_RATIONAL_NUMBER]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_RATIONAL_NUMBER] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_RATIONAL_NUMBER]}
			then
				Result := eq
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
