note
	description: "Test suite for {ELEMENT}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines (All)

	test_all
			-- Test every routine of {ELEMENT}.
		note
			testing: "covers/{ELEMENT}"
		do
			test_is_in
			test_is_not_in
		end

feature -- Test routines (Membership)

	test_is_in
			-- Test {ELEMENT}.is_in.
		note
			testing: "covers/{ELEMENT}.is_in"
		local
			a: like element_to_be_tested
			s: SET [ELEMENT]
		do
			a := element_to_be_tested
			create s
			assert ("not (a ∈ s)", not (a ∈ s))

			s := s.extended (a, create {REFERENCE_EQUALITY [ELEMENT]})
			assert ("a ∈ s", a ∈ s)

			s := s.prunned (a)
			assert ("not (a ∈ (s \ {a}))", not (a ∈ s))
		end

	test_is_not_in
			-- Test {ELEMENT}.is_not_in.
		note
			testing: "covers/{ELEMENT}.is_not_in"
		local
			a: like element_to_be_tested
			s: SET [ELEMENT]
		do
			a := element_to_be_tested
			create s
			assert ("is_not_in", a ∉ s ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (a, s))
		end

feature -- Properties (Membership)

	is_not_in_ok (a: ELEMENT; s: SET [ELEMENT]): BOOLEAN
			-- Do the properties verified within set theory hold for {ELEMENT}.is_not_in?
		do
			check
				another_definition: a ∉ s = s ∌ a
			then
				Result := True
			end
		end

feature {NONE} -- Factory (Element to be tested)

	element_to_be_tested: ELEMENT
			-- Element meant to be under tests
		do
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
