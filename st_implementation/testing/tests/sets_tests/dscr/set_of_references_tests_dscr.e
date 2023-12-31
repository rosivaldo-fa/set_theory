﻿note
	description: "Test suite for {SET [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SET_OF_REFERENCES_TESTS_DSCR

inherit
	SET_TESTS [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
		rename
			some_object_a as some_separate_character_ref,
			some_immediate_set_a as some_immediate_set_of_references_dscr,
			some_set_a as some_set_of_references_dscr
		redefine
			properties,
			test_all,
			test_is_empty,
			test_any,
			test_others,
			test_eq,
			test_is_in,
			test_is_not_in,
			test_has,
			test_does_not_have,
			test_with,
			test_without,
			test_is_singleton,
			test_cardinality,
			test_equals,
			test_unequals,
			test_is_subset,
			test_is_not_subset,
			test_is_superset,
			test_is_not_superset,
			test_is_comparable,
			test_is_not_comparable,
			test_is_strict_subset,
			test_is_not_strict_subset,
			test_is_strict_superset,
			test_is_not_strict_superset,
			test_is_trivial_subset,
			test_is_trivial_superset,
			test_is_proper_subset,
			test_is_proper_superset,
			test_is_disjoint,
			test_intersects,
			test_exists,
			test_does_not_exist,
			test_exists_unique,
			test_exists_pair,
			test_does_not_exist_pair,
			test_exists_distinct_pair,
			test_for_all,
			test_for_all_pairs,
			test_for_all_distinct_pairs,
			test_filtered,
			test_complemented,
			test_intersected,
			test_united,
			test_subtracted,
			test_subtracted_symmetricaly,
			test_mapped,
			test_reduced,
			test_proper_reduced,
			object_hash_code
		end

feature -- Access

	properties: SET_PROPERTIES [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
			-- <Precursor>

feature -- Test routines (All)

	test_all
			-- Test every routine of {SET}.
		note
			testing: "covers/{SET}"
			TODO: "Distinguish indivitual tests."
		do
			Precursor {SET_TESTS}
			test_is_empty
			test_any
			test_others
			test_eq
			test_is_in
			test_is_not_in
			test_has
			test_does_not_have
			test_with
			test_without
			test_is_singleton
			test_cardinality
			test_equals
			test_unequals
			test_is_subset
			test_is_not_subset
			test_is_superset
			test_is_not_superset
			test_is_comparable
			test_is_not_comparable
			test_is_strict_subset
			test_is_not_strict_subset
			test_is_strict_superset
			test_is_not_strict_superset
			test_is_trivial_subset
			test_is_trivial_superset
			test_is_proper_subset
			test_is_proper_superset
			test_is_disjoint
			test_intersects
			test_exists
			test_does_not_exist
			test_exists_unique
			test_exists_pair
			test_does_not_exist_pair
			test_exists_distinct_pair
			test_for_all
			test_for_all_pairs
			test_for_all_distinct_pairs
			test_filtered
			test_complemented
			test_intersected
			test_united
			test_subtracted
			test_subtracted_symmetricaly
			test_mapped
			test_reduced
			test_proper_reduced
		end

feature -- Test routines (Primitive)

	test_is_empty
			-- <Precursor>
		note
			testing: "covers/{SET}.is_empty"
		do
			Precursor {SET_TESTS}
		end

	test_any
			-- <Precursor>
		note
			testing: "covers/{SET}.any"
		do
			Precursor {SET_TESTS}
		end

	test_others
			-- <Precursor>
		note
			testing: "covers/{SET}.others"
		do
			Precursor {SET_TESTS}
		end

	test_eq
			-- <Precursor>
		note
			testing: "covers/{SET}.eq"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_in"
			testing: "covers/{SET}.is_in"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_in
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_in"
			testing: "covers/{SET}.is_not_in"
		do
			Precursor {SET_TESTS}
		end

	test_has
			-- <Precursor>
		note
			testing: "covers/{SET}.has"
		do
			Precursor {SET_TESTS}
		end

	test_does_not_have
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.does_not_have"
			testing: "covers/{SET}.does_not_have"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Construction)

	test_with
			-- <Precursor>
		note
			testing: "covers/{SET}.with"
		do
			Precursor {SET_TESTS}
		end

	test_without
			-- <Precursor>
		note
			testing: "covers/{SET}.without"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Quality)

	test_is_singleton
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_singleton"
			testing: "covers/{SET}.is_singleton"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Measurement)

	test_cardinality
			-- <Precursor>
		note
			testing: "covers/{SET}.cardinality"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Comparison)

	test_equals
			-- <Precursor>
		note
			testing: "covers/{SET}.equals"
		do
			Precursor {SET_TESTS}
		end

	test_unequals
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.unequals"
			testing: "covers/{SET}.unequals"
		do
			Precursor {SET_TESTS}
		end

	test_is_subset
			-- <Precursor>
		note
			testing: "covers/{SET}.is_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_subset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_subset"
			testing: "covers/{SET}.is_not_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_superset"
			testing: "covers/{SET}.is_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_superset"
			testing: "covers/{SET}.is_not_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_comparable
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_comparable"
			testing: "covers/{SET}.is_comparable"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_comparable
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_comparable"
			testing: "covers/{SET}.is_not_comparable"
		do
			Precursor {SET_TESTS}
		end

	test_is_strict_subset
			-- <Precursor>
		note
			testing: "covers/{SET}.is_strict_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_strict_subset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_strict_subset"
			testing: "covers/{SET}.is_not_strict_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_strict_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_strict_superset"
			testing: "covers/{SET}.is_strict_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_not_strict_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_not_strict_superset"
			testing: "covers/{SET}.is_not_strict_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_trivial_subset
			-- <Precursor>
		note
			testing: "covers/{SET}.is_trivial_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_trivial_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_trivial_superset"
			testing: "covers/{SET}.is_trivial_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_proper_subset
			-- <Precursor>
		note
			testing: "covers/{SET}.is_proper_subset"
		do
			Precursor {SET_TESTS}
		end

	test_is_proper_superset
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.is_proper_superset"
			testing: "covers/{SET}.is_proper_superset"
		do
			Precursor {SET_TESTS}
		end

	test_is_disjoint
			-- <Precursor>
		note
			testing: "covers/{SET}.is_disjoint"
		do
			Precursor {SET_TESTS}
		end

	test_intersects
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.intersects"
			testing: "covers/{SET}.intersects"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Quantifier)

	test_exists
			-- <Precursor>
		note
			testing: "covers/{SET}.exists"
		do
			Precursor {SET_TESTS}
		end

	test_does_not_exist
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.does_not_exist"
			testing: "covers/{SET}.does_not_exist"
		do
			Precursor {SET_TESTS}
		end

	test_exists_unique
			-- <Precursor>
		note
			testing: "covers/{SET}.exists_unique"
		do
			Precursor {SET_TESTS}
		end

	test_exists_pair
			-- <Precursor>
		note
			testing: "covers/{SET}.exists_pair"
		do
			Precursor {SET_TESTS}
		end

	test_does_not_exist_pair
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.does_not_exist_pair"
			testing: "covers/{SET}.does_not_exist_pair"
		do
			Precursor {SET_TESTS}
		end

	test_exists_distinct_pair
			-- <Precursor>
		note
			testing: "covers/{SET}.exists_distinct_pair"
		do
			Precursor {SET_TESTS}
		end

	test_for_all
			-- <Precursor>
		note
			testing: "covers/{SET}.for_all"
		do
			Precursor {SET_TESTS}
		end

	test_for_all_pairs
			-- <Precursor>
		note
			testing: "covers/{SET}.for_all_pairs"
		do
			Precursor {SET_TESTS}
		end

	test_for_all_distinct_pairs
			-- <Precursor>
		note
			testing: "covers/{SET}.for_all_distinct_pairs"
		do
			Precursor {SET_TESTS}
		end

	test_filtered
			-- <Precursor>
		note
			testing: "covers/{SET}.filtered"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Operation)

	test_complemented
			-- <Precursor>
		note
			testing: "covers/{SET}.complemented"
		do
			Precursor {SET_TESTS}
		end

	test_intersected
			-- <Precursor>
		note
			testing: "covers/{SET}.intersected"
		do
			Precursor {SET_TESTS}
		end

	test_united
			-- <Precursor>
		note
			testing: "covers/{SET}.united"
		do
			Precursor {SET_TESTS}
		end

	test_subtracted
			-- <Precursor>
		note
			testing: "covers/{SET}.subtracted"
		do
			Precursor {SET_TESTS}
		end

	test_subtracted_symmetricaly
			-- <Precursor>
		note
			testing: "covers/{SET}.subtracted_symmetricaly"
		do
			Precursor {SET_TESTS}
		end

feature -- Test routines (Transformation)

	test_mapped
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.mapped"
			testing: "covers/{SET}.mapped"
		do
			Precursor {SET_TESTS}
		end

	test_reduced
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.reduced"
			testing: "covers/{SET}.reduced"
		do
			Precursor {SET_TESTS}
		end

	test_proper_reduced
			-- <Precursor>
		note
			testing: "covers/{STS_SET}.proper_reduced"
			testing: "covers/{SET}.proper_reduced"
		do
			Precursor {SET_TESTS}
		end

feature -- Mapping

	f_x (x: detachable separate CHARACTER_REF): detachable separate CHARACTER_REF
			-- <Precursor>
		do
			if attached x then
					check
							-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_code
						valid_character: ((x |-| Min_character + 2) \\ Max_count.as_integer_32 + Min_character.code).is_valid_character_8_code
					end
				Result := ((x |-| Min_character + 2) \\ Max_count.as_integer_32 + Min_character.code).to_character_8
			end
		end

feature -- Reduction

	f_acc_x (acc, x: detachable separate CHARACTER_REF): detachable separate CHARACTER_REF
			-- <Precursor>
		do
			if attached acc and attached x then
					check
							-- class invariant: (Min_character.natural_32_code + Max_count - 1).is_valid_character_code
						valid_character: ((acc |-| x.item).abs \\ Max_count.as_integer_32 + Min_character.code).is_valid_character_8_code
					end
				Result := ((acc |-| x.item).abs \\ Max_count.as_integer_32 + Min_character.code).to_character_8
			end
		end

feature {NONE} -- Implementation

	object_hash_code (c: detachable separate CHARACTER_REF): INTEGER
			-- Hash code of `c'.`out'; 0 if `a' is Void.
		note
			EIS: "name={(separate) A}.out inconsistent results", "protocol=URI", "src=https://support.eiffel.com/report_detail/19890", "tag=separate, bug, compiler, SCOOP"
		local
			c_item: CHARACTER
		do
			if c /= Void then
				from
					c_item := c.item
				until
					c_item /= '%U'
				loop
					c_item := c.item
				end
				Result := c_item.out.hash_code
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"

end
