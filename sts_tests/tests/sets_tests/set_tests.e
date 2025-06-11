note
	description: "Test suite for {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	UNARY_TESTS [G]
		rename
			is_not_in_ok as element_is_not_in_ok,
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
			element_to_be_tested as set_to_be_tested
		redefine
			test_all,
			set_to_be_tested
		end

	SET_PROPERTIES [G]

feature -- Test routines (All)

	test_all
			-- Test every routine of {STS_SET}.
		note
			testing: "covers/{STS_SET}"
		do
			Precursor {UNARY_TESTS}
			test_has
			test_does_not_have
			test_is_in
			test_is_not_in
			test_extended
			test_prunned
			test_is_universe
		end

feature -- Test routines (Membership)

	test_has
			-- Test {STS_SET}.has.
		note
			testing: "covers/{STS_SET}.has"
		local
			a: G
			s: like set_to_be_tested
		do
			a := some_object_g
			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

	test_does_not_have
			-- Test {STS_SET}.does_not_have.
		note
			testing: "covers/{STS_SET}.does_not_have"
		local
			a: G
			s: like set_to_be_tested
		do
			a := some_object_g
			s := set_to_be_tested
			assert ("does_not_have", s ∌ a ⇒ True)
		end

	test_is_in
			-- Test {STS_SET}.is_in.
		note
			testing: "covers/{STS_SET}.is_in"
		local
			s: like set_to_be_tested
			ss: like some_set_sg
		do
			s := set_to_be_tested
			ss := some_set_sg.extended (s, some_equality_sg)
			assert ("s ∈ ss", s ∈ ss)

			ss := some_set_sg.prunned (s)
			assert ("not (s ∈ ss)", not (s ∈ ss))

			ss := some_set_sg
			assert ("is_in", s ∈ ss ⇒ True)
		end

	test_is_not_in
			-- Test {STS_SET}.is_not_in.
		note
			testing: "covers/{STS_SET}.is_not_in"
		local
			s: like set_to_be_tested
			ss: like some_set_sg
		do
			s := set_to_be_tested
			ss := some_set_sg.prunned (s)
			assert ("s ∉ ss", s ∉ ss)
			assert ("s ∉ ss ok", is_not_in_ok (s, ss))

			ss := some_set_sg.extended (s, some_equality_sg)
			assert ("not (s ∉ ss)", not (s ∉ ss))
			assert ("not (s ∉ ss) ok", is_not_in_ok (s, ss))

			ss := some_set_sg
			assert ("is_not_in", s ∉ ss ⇒ True)
			assert ("is_not_in_ok", is_not_in_ok (s, ss))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {STS_SET}.extended.
		note
			testing: "covers/{STS_SET}.extended"
		local
			s: like set_to_be_tested
			a: G
			eq: like some_equality_g
		do
			s := set_to_be_tested
			a := some_object_g
			eq := some_equality_g
			assert ("{a, ...}", s.extended (same_object_g (a, eq), eq) ∋ a)
		end

	test_prunned
			-- Test {STS_SET}.prunned.
		note
			testing: "covers/{STS_SET}.prunned"
		local
			s: like set_to_be_tested
			a: G
		do
			s := set_to_be_tested
			a := some_object_g
			assert ("s ∖ {a}", s.prunned (a) ∌ a)
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {STS_SET}.is_universe.
		note
			testing: "covers/{STS_SET}.is_universe"
		do
			assert ("is_universe", attached set_to_be_tested.is_universe ⇒ True)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_set_g
			-- Set meant to be under tests
		do
			Result := some_immediate_set_g
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
