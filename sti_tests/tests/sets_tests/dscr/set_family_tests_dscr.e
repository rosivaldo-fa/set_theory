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
			test_make_extended,
			test_out
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
			Precursor {SET_FAMILY_TESTS}
		end

feature -- Test routines (Output)

	test_out
			-- <Precursor>
			-- Test {STI_SET_FAMILY}.out.
		note
			testing: "covers/{STI_SET}.out"
			testing: "covers/{STI_SET_FAMILY}.out"
		do
			from
			until false
			loop
			Precursor {SET_FAMILY_TESTS}
			end
		end

feature -- Factory (Set)

	some_set_dscr: STS_SET [detachable separate CHARACTER_REF]
			-- Randomly-fetched set of separate character references
		do
			Result := resources_dscr.some_set_dscr
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
