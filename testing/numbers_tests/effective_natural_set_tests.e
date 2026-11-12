note
	description: "Test suite for {EFFECTIVE_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	EFFECTIVE_NATURAL_SET_TESTS

inherit
	NATURAL_SET_TESTS
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EFFECTIVE_NATURAL_SET}.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}"
		do
			Precursor {NATURAL_SET_TESTS}
			test_default_create
		end

feature -- Test routines (Initialization)

	test_default_create
			-- Test {EFFECTIVE_NATURAL_SET}.default_create.
		note
			testing: "covers/{EFFECTIVE_NATURAL_SET}.default_create"
		do
			assert ("default_create", attached (create {like set_to_be_tested}))
		end

feature -- Factory (element to be tested)

	set_to_be_tested: EFFECTIVE_NATURAL_SET
			-- <Precursor>
		do
			create Result
		ensure then
			class
		end

feature -- Factory

	n1: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 1
		ensure then
			class
		end

	n2: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 2
		ensure then
			class
		end

	n3: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 3
		ensure then
			class
		end

	n4: EFFECTIVE_NATURAL_NUMBER
			-- <Precursor>
		once
			Result := {NATURAL} 4
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
