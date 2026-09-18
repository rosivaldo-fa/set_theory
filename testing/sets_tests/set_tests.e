note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_TESTS

inherit
    ELEMENT_TESTS
    	rename
    	    element_to_be_tested as set_to_be_tested
    	redefine
    	    test_all,
    	    set_to_be_tested
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {SET}.
		note
			testing: "covers/{SET}"
		do
			Precursor {ELEMENT_TESTS}
			test_default_create
			test_make_extended
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {SET}.default_create.
		note
			testing: "covers/{SET}.default_create"
		do
			assert ("default_create", attached (create {like set_to_be_tested}))
		end

	test_make_extended
			-- Test {SET}.make_extended.
		note
			testing: "covers/{SET}.make_extended"
		local
			s: SET [detachable separate CHARACTER_REF]
		do
			create s
			assert (
				"make_extended",
				attached (create {like set_to_be_tested}.make_extended (Void, create {REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}, s))
				)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: SET [detachable separate CHARACTER_REF]
			-- Set meant to be under tests
		do
			create Result
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
