note
	description: "Test suite for {STS_SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_FAMILY_TESTS [G]

inherit
	SET_TESTS [STS_SET [G]]
		rename
			set_to_be_tested as set_family_to_be_tested,

			some_object_g as some_set_g,
			same_object_g as same_set_g,
			object_standard_twin_g as set_standard_twin_g,
			object_twin_g as set_twin_g,
			object_deep_twin_g as set_deep_twin_g,

			some_equality_g as some_equality_sg,
			some_reference_equality_g as some_reference_equality_sg,
			some_object_standard_equality_g as some_object_standard_equality_sg,
			some_object_equality_g as some_object_equality_sg,
			some_object_deep_equality_g as some_object_deep_equality_sg,
			some_equality_sg as some_equality_ssg,
			some_reference_equality_sg as some_reference_equality_ssg,
			some_object_standard_equality_sg as some_object_standard_equality_ssg,
			some_object_equality_sg as some_object_equality_ssg,
			some_object_deep_equality_sg as some_object_deep_equality_ssg,

			some_set_g as some_set_sg,
			some_immediate_set_g as some_immediate_set_sg,
			some_set_sg as some_set_ssg,
			some_immediate_set_sg as some_immediate_set_ssg,
			some_set_family_g as some_set_family_sg,
			some_immediate_set_family_g as some_immediate_set_family_sg
		redefine
			set_family_to_be_tested
		end

feature {NONE} -- Factory (element to be tested)

	set_family_to_be_tested: like some_immediate_set_family_g
			-- Set family meant to be under tests
		do
			Result := some_immediate_set_family_g
		end

feature -- Factory (Set)

	some_set_family_g: STS_SET_FAMILY [G]
			-- Randomly-fetched polymorphic family of sets of elements like {G}
		do
			Result := some_immediate_set_family_g
		end

	some_immediate_set_family_g: STS_SET_FAMILY [G]
			-- Randomly-fetched monomorphic family of sets of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_family_g}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
