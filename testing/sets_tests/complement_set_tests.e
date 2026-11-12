note
	description: "Test suite for {COMPLEMENT_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

deferred class
	COMPLEMENT_SET_TESTS [G]

inherit
	SET_TESTS [G]
		redefine
			test_all,
			test_has,
			test_does_not_have,
			test_there_exists
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {COMPLEMENT_SET}.
		note
			testing: "covers/{COMPLEMENT_SET}"
		do
			Precursor {SET_TESTS}
			test_make
			test_reference_set
			test_out
			test_debug_output
			test_p_holds_outside_reference_set
		end

feature -- Test routines (Initialization)

	test_make
			-- Test {COMPLEMENT_SET}.make.
		note
			testing: "covers/{COMPLEMENT_SET}.make"
		do
			assert (
					"make",
					attached (
						create {like set_to_be_tested}.make (create {EFFECTIVE_SET [G]})
					)
				)
		end

feature -- Test routines (Primitive)

	test_reference_set
			-- Test {COMPLEMENT_SET}.reference_set.
		note
			testing: "covers/{COMPLEMENT_SET}.reference_set"
		do
			assert ("reference_set", attached set_to_be_tested.reference_set)
		end

feature -- Test routines (Membership)

	test_has
			-- Test {COMPLEMENT_SET}.has.
		note
			testing: "covers/{COMPLEMENT_SET}.has"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∋ a", s ∋ a)

			s := s / a
			assert ("not (s ∋ a)", not (s ∋ a))
			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

	test_does_not_have
			-- Test {COMPLEMENT_SET}.does_not_have.
		note
			testing: "covers/{COMPLEMENT_SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested / a
			assert ("s ∌ a", s ∌ a)
			create s.make (create {EFFECTIVE_SET [G]})
			assert ("not (s ∌ a)", not (s ∌ a))
			s := set_to_be_tested
			assert ("does_not_have", s ∌ a ⇒ True)
		end

feature -- Test routines (Output)

	test_out
			-- Test {COMPLEMENT_SET}.out.
		note
			testing: "covers/{COMPLEMENT_SET}.out"
		do
			assert ("out", attached set_to_be_tested.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {COMPLEMENT_SET}.debug_output.
		note
			testing: "covers/{COMPLEMENT_SET}.debug_output"
		do
			assert ("debug_output", attached set_to_be_tested.debug_output)
		end

feature -- Test routines (Quantifier)

	test_there_exists
			-- Test {COMPLEMENT_SET}.there_exists.
		note
			testing: "covers/{COMPLEMENT_SET}.there_exists"
		local
			s0: EFFECTIVE_SET [G]
			s: like set_to_be_tested
		do
			create s0
			s0 := s0.extended (a, create {REFERENCE_EQUALITY [G]})
			create s.make (s0)
			assert (
					"s.p_holds_outside_reference_set",
					s.p_holds_outside_reference_set (
							agent (x: G): BOOLEAN
								do
									Result := True
								end,
							b
						)
				)

			assert (
					"not s.p_holds_outside_reference_set",
					not s.p_holds_outside_reference_set (
								agent (x: G): BOOLEAN
									do
										Result := True
									end,
								a
							)
				)
		end

	test_p_holds_outside_reference_set
			-- Test {COMPLEMENT_SET}.p_holds_outside_reference_set.
		note
			testing: "covers/{COMPLEMENT_SET}.p_holds_outside_reference_set"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert (
					"outside",
					s.p_holds_outside_reference_set (agent (s.reference_set).does_not_have, a)
				)

			s := s.prunned (a)
			assert (
					"inside",
					not s.p_holds_outside_reference_set (agent (s.reference_set).has, a)
				)
		end

feature -- Factory (element to be tested)

	set_to_be_tested: COMPLEMENT_SET [G]
			-- <Precursor>
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
