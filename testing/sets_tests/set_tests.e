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

feature -- Test routines (Membership)

	test_has
			-- Test {SET}.has.
		note
			testing: "covers/{SET}.has"
		local
			s: like set_to_be_tested
		do
			create s.make_extended (Void, create {REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}, set_to_be_tested)
			assert ("s ∋ Void", s ∋ Void)

			create s
			assert ("not (s ∋ Void)", not (s ∋ Void))

			s := set_to_be_tested
			assert ("has", s ∋ Void ⇒ True)
		end

	test_does_not_have
			-- Test {SET}.does_not_have.
		note
			testing: "covers/{SET}.does_not_have"
		local
			s: like set_to_be_tested
		do
			create s
			assert ("s ∌ Void", s ∌ Void)

			create s.make_extended (Void, create {REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}, set_to_be_tested)
			assert ("not (s ∌ Void)", not (s ∌ Void))

			s := set_to_be_tested
			assert ("does_not_have", s ∌ Void ⇒ True)
		end

	test_is_in
			-- Test {SET}.is_in.
		note
			testing: "covers/{SET}.is_in"
		local
			s: like set_to_be_tested
			ss: SET [SET [detachable separate CHARACTER_REF]]
		do
			s := set_to_be_tested
			create ss.make_extended (
				s, create {REFERENCE_EQUALITY [SET [detachable separate CHARACTER_REF]]}, create {SET [SET [detachable separate CHARACTER_REF]]}
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
			ss: SET [SET [detachable separate CHARACTER_REF]]
		do
			s := set_to_be_tested
			create ss
			assert ("s ∉ ss", s ∉ ss)

			create ss.make_extended (
				s, create {REFERENCE_EQUALITY [SET [detachable separate CHARACTER_REF]]}, create {SET [SET [detachable separate CHARACTER_REF]]}
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
			assert ("{Void, ...}", s.extended (Void, create {REFERENCE_EQUALITY [detachable separate CHARACTER_REF]}) ∋ Void)
		end

	test_prunned
			-- Test {SET}.prunned.
		note
			testing: "covers/{SET}.prunned"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			assert ("s ∖ {Void}", s.prunned (Void) ∌ Void)
		end

feature -- Test routines (Output)

	test_element_out
			-- Test {SET}.element_out.
		note
			testing: "covers/{SET}.element_out"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			c: detachable separate CHARACTER_REF
			s: like set_to_be_tested
			a_failed: BOOLEAN
		do
			if not a_failed then
    			s := set_to_be_tested
    			assert ("Void", s.element_out (c) ~ "Void")

    			create c
    			assert ("%U", s.element_out (c) ~ "%U")

    			separate c as sep_c do
    			    sep_c.set_item ('a')
    			end
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
			c1, c2, c3: detachable separate CHARACTER_REF
			s: like set_to_be_tested
			eq: REFERENCE_EQUALITY [detachable separate CHARACTER_REF]
			s_out: STRING
		do
			create eq
			create s
			assert ("{}", s.out ~ "{}")

			s := s.extended (c1, eq)
			s_out := s.out
			assert ("{Void}", s_out ~ "{} & (Void)")

			create c2
			s := s.extended (c2, eq)
			s_out := s.out
			assert ("{Void, '%%U'}", s_out ~ "{} & (Void) & '%%U'")

			create c3
			separate c3 as sep_c3 do
			    sep_c3.set_item ('a')
			end
			s := s.extended (c3, eq)
			s_out := s.out
			assert ("{Void, '%%U', 'a'}", s_out ~ "{} & (Void) & '%%U' & 'a'")

			s := set_to_be_tested
			assert ("out", attached s.out)
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
