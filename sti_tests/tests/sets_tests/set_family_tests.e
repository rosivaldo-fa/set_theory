note
	description: "Test suite for {STI_SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_FAMILY_TESTS [G]

inherit
	STST_SET_FAMILY_TESTS [G]
		undefine
			default_create
		redefine
			test_all
		end

	SET_TESTS [STS_SET [G]]
		rename
			test_make_extended as test_set_make_extended,
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
		undefine
			set_family_to_be_tested,
			some_set_sg,
			some_set_ssg
		redefine
			test_all,
			test_set_make_extended
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {STI_SET_FAMILY}.
		note
			testing: "covers/{STI_SET_FAMILY}"
		do
			Precursor {SET_TESTS}
			test_make_extended
		end

feature -- Test routines (Initialization)

	test_set_make_extended
			-- Do nothing. {STI_SET_FAMILY}.set_make_extended is a no-op.
		note
			testing: "covers/{STI_SET_FAMILY}.set_make_extended"
		do
		end

	test_make_extended
			-- Test {STI_SET_FAMILY}.make_extended.
		note
			testing: "covers/{STI_SET_FAMILY}.make_extended"
		do
			assert ("make_extended", attached (create {like set_family_to_be_tested}.make_extended (some_set_g, some_equality_sg, some_set_family_g)))
		end

feature -- Factory (Set)

	some_immediate_set_sg: STI_SET [STS_SET [G]]
			-- Randomly-fetched monomorphic set of sets of elements like {G}
		deferred
		end

	some_immediate_set_ssg: STI_SET [STS_SET [STS_SET [G]]]
			-- Randomly-fetched monomorphic set of sets of sets of elements like {G}
		deferred
		end

	some_immediate_set_family_g: STI_SET_FAMILY [G]
			-- Randomly-fetched monomorphic family of sets of elements like {G}
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
