note
	description: "Test suite for {STI_SET_FAMILY [detachable separate CHARACTER_REF]}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SET_FAMILY_TESTS_DSCR

inherit
	SET_FAMILY_TESTS [detachable separate CHARACTER_REF]
		rename
			some_set_g as some_set_dscr,
			same_set_g as same_set_dscr,
			set_standard_twin_g as set_standard_twin_dscr,
			set_twin_g as set_twin_dscr,
			set_deep_twin_g as set_deep_twin_dscr,

			some_equality_sg as some_equality_sdscr,
			some_reference_equality_sg as some_reference_equality_sdscr,
			some_object_standard_equality_sg as some_object_standard_equality_sdscr,
			some_object_equality_sg as some_object_equality_sdscr,
			some_object_deep_equality_sg as some_object_deep_equality_sdscr,
			some_equality_ssg as some_equality_ssdscr,
			some_reference_equality_ssg as some_reference_equality_ssdscr,
			some_object_standard_equality_ssg as some_object_standard_equality_ssdscr,
			some_object_equality_ssg as some_object_equality_ssdscr,
			some_object_deep_equality_ssg as some_object_deep_equality_ssdscr,

			some_set_sg as some_set_sdscr,
			some_immediate_set_sg as some_immediate_set_sdscr,
			some_set_ssg as some_set_ssdscr,
			some_immediate_set_ssg as some_immediate_set_ssdscr,
			some_set_family_sg as some_set_family_sdscr,
			some_immediate_set_family_sg as some_immediate_set_family_sdscr,

			some_set_family_g as some_set_family_dscr,
			some_immediate_set_family_g as some_immediate_set_family_dscr
		redefine
			test_all,
			test_make_extended
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_SET_FAMILY}.
		note
			testing: "covers/{STI_SET_FAMILY}"
		do
			Precursor {SET_FAMILY_TESTS}
		end

feature -- Test routines (Initialization)

	test_make_extended
			-- Test {STI_SET_FAMILY}.make_extended.
		note
			testing: "covers/{STI_SET_FAMILY}.make_extended"
		do
			assert ("make_extended", attached (create {like set_family_to_be_tested}.make_extended (some_set_dscr, some_equality_sdscr, some_set_family_dscr)))
		end

feature -- Factory (Set)

	some_set_dscr: STS_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched set of separate character references
		do
			Result := resources_dscr.some_set_dscr
		end

	some_immediate_set_sdscr: STI_SET [STS_SET [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic set of sets of separate character references
		do
			Result := resources_dscr.some_immediate_set_sdscr
		end

	some_immediate_set_ssdscr: STI_SET [STS_SET [STS_SET [detachable separate CHARACTER_REF]]]
			-- Randomly-fetched monomorphic set of sets of sets of separate character references
		do
			check
				ss: attached {STI_SET [STS_SET [STS_SET [detachable separate CHARACTER_REF]]]} some_immediate_instance (
							agent: STI_SET [STS_SET [STS_SET [detachable separate CHARACTER_REF]]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_set_sdscr, some_equality_ssdscr)
									end
								end
						) as ss -- `some_immediate_instance' definition
				monomorphic: ss.generating_type ~ {detachable STI_SET [STS_SET [STS_SET [detachable separate CHARACTER_REF]]]}
			then
				Result := cropped_set (ss)
			end
		end

	some_immediate_set_family_sdscr: STI_SET_FAMILY [STS_SET [detachable separate CHARACTER_REF]]
			-- Randomly-fetched monomorphic family of sets of sets of separate character references
		do
			check
				sf: attached {STI_SET_FAMILY [STS_SET [detachable separate CHARACTER_REF]]} some_immediate_instance (
							agent: STI_SET_FAMILY [STS_SET [detachable separate CHARACTER_REF]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result
									loop
										Result := Result.extended (some_set_sdscr, some_equality_ssdscr)
									end
								end
						) as sf -- `some_immediate_instance' definition
				monomorphic: sf.generating_type ~ {detachable STI_SET_FAMILY [STS_SET [detachable separate CHARACTER_REF]]}
			then
				Result := cropped_set (sf)
			end
		end

	some_immediate_set_family_dscr: STI_SET_FAMILY [detachable separate CHARACTER_REF]
			-- <Precursor>
		do
			Result := resources_dscr.some_immediate_set_family_dscr
		end

feature {NONE} -- Implementation

	resources_dscr: UNARY_TESTS_DSCR
			-- Auxiliary features
		attribute
			create Result
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
