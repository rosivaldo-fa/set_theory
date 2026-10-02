note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [G]

inherit
	ELEMENT_TESTS
		rename
			test_is_in as test_element_is_in,
			test_is_not_in as test_element_is_not_in,
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
			test_has
			test_does_not_have
			test_is_in
			test_is_not_in
			test_extended
			test_prunned
			test_element_out
			test_out
			test_debug_output
			test_is_universe
			test_given_element
			test_eq
			test_subset
			test_given_element_storage
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
		do
			assert (
					"make_extended",
					attached (
						create {like set_to_be_tested}.make_extended (a, create {REFERENCE_EQUALITY [G]}, set_to_be_tested)
					)
				)
		end

feature -- Test routines (Membership)

	test_has
			-- Test {SET}.has.
		note
			testing: "covers/{SET}.has"
		local
			s: like set_to_be_tested
		do
			create s.make_extended (a, create {REFERENCE_EQUALITY [G]}, set_to_be_tested)
			assert ("s ∋ Void", s ∋ a)

			create s
			assert ("not (s ∋ Void)", not (s ∋ a))

			s := set_to_be_tested
			assert ("has", s ∋ a ⇒ True)
		end

	test_does_not_have
			-- Test {SET}.does_not_have.
		note
			testing: "covers/{SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			create s
			assert ("s ∌ Void", s ∌ a)

			create s.make_extended (a, create {REFERENCE_EQUALITY [G]}, set_to_be_tested)
			assert ("not (s ∌ Void)", not (s ∌ a))

			s := set_to_be_tested
			assert ("does_not_have", s ∌ a ⇒ True)
		end

	test_is_in
			-- Test {SET}.is_in.
		note
			testing: "covers/{SET}.is_in"
		local
			s: like set_to_be_tested
			ss: SET [SET [G]]
		do
			s := set_to_be_tested
			create ss.make_extended (
					s, create {REFERENCE_EQUALITY [SET [G]]}, create {SET [SET [G]]}
				)
			assert ("s ∈ ss", s ∈ ss)

			create ss
			assert ("not (s ∈ ss)", not (s ∈ ss))
		end

	test_is_not_in
			-- Test {SET}.is_not_in.
		note
			testing: "covers/{SET}.is_not_in"
		local
			s: like set_to_be_tested
			ss: SET [SET [G]]
		do
			s := set_to_be_tested
			create ss
			assert ("s ∉ ss", s ∉ ss)

			create ss.make_extended (
					s, create {REFERENCE_EQUALITY [SET [G]]}, create {SET [SET [G]]}
				)
			assert ("not (s ∉ ss)", not (s ∉ ss))
		end

feature -- Test routines (Construction)

	test_extended
			-- Test {SET}.extended.
		note
			testing: "covers/{SET}.extended"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("{Void, ...}", s.extended (a, create {REFERENCE_EQUALITY [G]}) ∋ a)
		end

	test_prunned
			-- Test {SET}.prunned.
		note
			testing: "covers/{SET}.prunned"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∖ {Void}", s.prunned (a) ∌ a)
		end

feature -- Test routines (Quality)

	test_is_universe
			-- Test {SET}.is_universe.
		note
			testing: "covers/{SET}.is_universe"
		do
			assert ("is_universe", attached set_to_be_tested.is_universe ⇒ True)
		end

feature -- Test routines (Output)

	test_element_out
			-- Test {SET}.element_out.
		note
			testing: "covers/{SET}.element_out"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			s: like set_to_be_tested
			a_failed: BOOLEAN
		do
			if not a_failed then
				s := set_to_be_tested
				assert ("Void", s.element_out (a) ~ "Void")

				assert ("%U", s.element_out (b) ~ "%U")
			else
				check
						-- s was set on a previous iteration.
					attached s
				then
				end
			end
			assert ("a", s.element_out (c) ~ "a")
		rescue
			if {EXCEPTIONS}.tag_name ~ "a" then
				a_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

	test_out
			-- Test {SET}.out.
		note
			testing: "covers/{SET}.out"
		local
			s: like set_to_be_tested
			eq: REFERENCE_EQUALITY [G]
			s_out: STRING
		do
			create eq
			create s
			assert ("{}", s.out ~ "{}")

			s := s.extended (a, eq)
			s_out := s.out
			assert ("{Void}", s_out ~ "{} & (Void)")

			s := s.extended (b, eq)
			s_out := s.out
			assert ("{Void, %U}", s_out ~ "{} & (Void) & (%U)")

			separate c as sep_c do
			end
			s := s.extended (c, eq)
			s_out := s.out
			assert ("{Void, %U, a}", s_out ~ "{} & (Void) & (%U) & (a)")

			s := set_to_be_tested
			assert ("out", attached s.out)
		end

feature -- Test routines (Status report)

	test_debug_output
			-- Test {SET}.debug_output.
		note
			testing: "covers/{SET}.debug_output"
		local
			eq: REFERENCE_EQUALITY [G]
			s: like set_to_be_tested
			s_debug_output: STRING_32
		do
			create eq
			create s
			assert ("{}", s.debug_output ~ {STRING_32} "{}")

			s := s.extended (a, eq)
			s_debug_output := s.debug_output
			assert ("{Void}", s_debug_output ~ {STRING_32} "{} & (Void)")

			s := s.extended (b, eq)
			s_debug_output := s.debug_output
			assert ("{Void, %U}", s_debug_output ~ {STRING_32} "{} & (Void) & (%U)")

			separate c as sep_c do
			end
			s := s.extended (c, eq)
			s_debug_output := s.debug_output
			assert ("{Void, %U, a}", s_debug_output ~ {STRING_32} "{} & (Void) & (%U) & (a)")

			s := set_to_be_tested
			assert ("debug_output", attached s.debug_output)
		end

feature -- Test routines (Implementation)

	test_given_element
			-- Test {SET}.given_element.
		note
			testing: "covers/{SET}.given_element"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			s: like exposed_set_to_be_tested
			abc_failed: BOOLEAN
		do
			if not abc_failed then
				create s
				s := s.extended (a, create {REFERENCE_EQUALITY [G]})
				assert ("{a} /= {}", s.subset /= s)
				assert ("{a}", s.given_element = a)

				separate b as sep_b do
					s := s.extended (sep_b.standard_twin, create {OBJECT_STANDARD_EQUALITY [G]})
				end
				assert ("{a,b} /= {}", s.subset /= s)
				check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
					assert ("{a,b}", s_eq (s.given_element, b))
				end
			else
				check attached s then -- s has been set on a previous iteration.
					s := s.subset
				end
			end

			separate c as sep_c do
				s := s.extended (sep_c.twin, create {OBJECT_EQUALITY [G]})
			end
			assert ("{a,b,c} /= {}", s.subset /= s)
			check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
				assert ("{a,b,c}", s_eq (s.given_element, c))
			end

			separate d as sep_d do
				s := s.extended (sep_d.deep_twin, create {OBJECT_DEEP_EQUALITY [G]})
				assert ("{a,b,c,d} /= {}", s.subset /= s)
				check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
					assert ("{a,b,c,d}", s_eq (s.given_element, d))
				end
			end
		rescue
			if {EXCEPTIONS}.tag_name ~ "{a,b,c}" then
				abc_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

	test_eq
			-- Test {SET}.eq.
		note
			testing: "covers/{SET}.eq"
		local
			s: like exposed_set_to_be_tested
		do
			create s
			assert ("{}", s.eq = Void)

			s := s.extended (a, create {REFERENCE_EQUALITY [G]})
			assert ("{Void}", attached {REFERENCE_EQUALITY [G]} s.eq)
		end

	test_subset
			-- Test {SET}.subset.
		note
			testing: "covers/{SET}.subset"
		local
			s: like exposed_set_to_be_tested
		do
			create s
			assert ("{}", s = s.subset)

			s := s.extended (a, create {REFERENCE_EQUALITY [G]})
			assert ("{Void}", s /= s.subset)
		end

	test_given_element_storage
			-- Test {SET}.given_element_storage.
		note
			testing: "covers/{SET}.given_element_storage"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			s: like exposed_set_to_be_tested
			abc_failed, abcd_failed: BOOLEAN
		do
			if not (abc_failed or abcd_failed) then
				create s
				assert ("{}", not attached s.given_element_storage)

				s := s.extended (a, create {REFERENCE_EQUALITY [G]})
				check attached s.given_element_storage as s_given_element_storage then
					assert ("{a}", s_given_element_storage.item = a)
				end

				separate b as sep_b do
					s := s.extended (sep_b.standard_twin, create {OBJECT_STANDARD_EQUALITY [G]})
					assert ("{a,b} /= {}", s.subset /= s)
					check attached s.given_element_storage as s_given_element_storage then
						check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
							assert ("{a,b}", s_eq (s_given_element_storage.item, b))
						end
					end
				end
			else
				check attached s then -- s has been set on a previous iteration.
					s := s.subset
				end
			end

			if not abcd_failed then
				separate c as sep_c do
					s := s.extended (sep_c.twin, create {OBJECT_EQUALITY [G]})
					assert ("{a,b,c} /= {}", s.subset /= s)
					check attached s.given_element_storage as s_given_element_storage then
						check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
							assert ("{a,b,c}", s_eq (s_given_element_storage.item, c))
						end
					end
				end
			else
				s := s.subset
			end

			separate d as sep_d do
				s := s.extended (sep_d.deep_twin, create {OBJECT_DEEP_EQUALITY [G]})
				assert ("{a,b,c,d} /= {}", s.subset /= s)
				check attached s.given_element_storage as s_given_element_storage then
					check attached s.eq as s_eq then -- s.subset /= s and {SET} invariant
						assert ("{a,b,c,d}", s_eq (s_given_element_storage.item, d))
					end
				end
			end
		rescue
			if {EXCEPTIONS}.tag_name ~ "{a,b,c}" then
				abc_failed := True -- Please have a look at EIS entry above.
				retry
			elseif {EXCEPTIONS}.tag_name ~ "{a,b,c,d}" then
				abcd_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: SET [G]
			-- Set meant to be under tests
		do
			create Result
		end

	exposed_set_to_be_tested: EXPOSED_SET [G]
			-- Exposed set meant to be under tests
		do
			create Result
		end

feature {NONE} -- Factory

	a, b, c, d: G
			-- Auxiliary data
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
