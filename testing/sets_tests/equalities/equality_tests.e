note
	description: "Test suite for {EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_TESTS

inherit
	ELEMENT_TESTS
		rename
			element_to_be_tested as equality_to_be_tested
		undefine
			equality_to_be_tested
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- Test every routine of {EQUALITY}.
		note
			testing: "covers/{EQUALITY}"
		do
			Precursor {ELEMENT_TESTS}
			test_holds
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {EQUALITY}.holds.
		note
			testing: "covers/{EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			c1, c2: detachable separate CHARACTER_REF
		do
			eq := equality_to_be_tested
			create c1
			assert ("c1 = c1", eq (c1, c1))

			c2 := c1
			assert ("c1 = c2", eq (c1, c2))

			create c2
			assert ("holds", eq (c1, c2) ⇒ True)
		end

	test_holds_successively
			-- Test {EQUALITY}.holds_successively.
		note
			testing: "covers/{EQUALITY}.holds_successively"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			eq: like equality_to_be_tested
			c1, c2, c3: detachable separate CHARACTER_REF
			neq_failed: BOOLEAN
		do
			if not neq_failed then
    			eq := equality_to_be_tested
    			create c1
    			assert ("same entity", eq.holds_successively (c1, c1, c1))
    			assert ("same entity ok", holds_successively_ok (c1, c1, c1, eq))

    			c2 := c1
    			c3 := c2
    			assert ("same reference", eq.holds_successively (c1, c2, c3))
    			assert ("same reference ok", holds_successively_ok (c1, c2, c3, eq))

    			create c2
    			separate c2 as sep_c2 do
    				sep_c2.set_item ('a')
    			end
    		else
    		    check
    		    		-- eq was set on a previous iteration.
    		        attached eq
    		    then
    		    end
			end
			assert ("unequal content", not eq.holds_successively (c1, c2, c3))
			assert ("unequal content ok", holds_successively_ok (c1, c2, c3, eq))

			create c2
			create c3
			assert ("holds_successively", eq.holds_successively (c1, c2, c3) ⇒ True)
			assert ("holds_successively_ok", holds_successively_ok (c1, c2, c3, eq))
		rescue
			if {EXCEPTIONS}.tag_name ~ "unequal content" then
				neq_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

feature -- Properties (Relationship)

	holds_successively_ok (a, b, c: detachable separate CHARACTER_REF; eq: EQUALITY [detachable separate CHARACTER_REF]): BOOLEAN
			-- Do the properties verified within set theory hold for {EQUALITY}.holds_successively?
		do
			check
				definition: eq.holds_successively (a, b, c) = (eq (a, b) and eq (a, c))
			then
				Result := True
			end
		rescue
		    retry
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: EQUALITY [detachable separate CHARACTER_REF]
			-- Equality meant to be under tests
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

