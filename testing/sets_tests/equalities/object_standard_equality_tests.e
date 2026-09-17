note
	description: "Test suite for {OBJECT_STANDARD_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_STANDARD_EQUALITY_TESTS

inherit
	EQUALITY_TESTS
		redefine
			test_holds,
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {OBJECT_STANDARD_EQUALITY}.holds.
		note
			testing: "covers/{OBJECT_STANDARD_EQUALITY}.holds"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			eq: like equality_to_be_tested
			c1, c2: detachable separate CHARACTER_REF
			eq_failed, neq_failed: BOOLEAN
		do
			if not (eq_failed or neq_failed) then
    			Precursor {EQUALITY_TESTS}
    			eq := equality_to_be_tested
    			create c1
    			separate c1 as sep_c1 do
    				c2 := sep_c1.standard_twin
    			end
    		else
    		    check
    		    		-- eq and c1 were set on a previous iteration.
    		        attached eq
    		        attached c1
    		    then
    		    end
    		end
   			if not neq_failed then
       			assert ("c1 ≜ c2", eq (c1, c2))

    			c2 := Void
    			assert ("not (c1 ≜ Void)", not eq (c1, c2))

    			create c2
    			separate c2 as sep_c2 do
    				sep_c2.set_item ('a')
    			end
   			end
    		assert ("not (c1 ≜ 'a')", not eq (c1, c2))
		rescue
			if {EXCEPTIONS}.tag_name ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("c1 ≜ c2") then
				eq_failed := True -- Please have a look at EIS entry above.
				retry
			elseif {EXCEPTIONS}.tag_name ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("not (c1 ≜ 'a')") then
				neq_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

	test_holds_successively
			-- Test {OBJECT_STANDARD_EQUALITY}.holds_successively.
		note
			testing: "covers/{OBJECT_STANDARD_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			c1, c2, c3: detachable separate CHARACTER_REF
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			create c1
			separate c1 as sep_c1 do
				c2 := sep_c1.standard_twin
			end
			separate c2 as sep_c2 do
				c3 := sep_c2.standard_twin
			end
			assert ("c1 ≜ c2 ≜ c3", eq.holds_successively (c1, c2, c3))
			assert ("c1 ≜ c2 ≜ c3 ok", holds_successively_ok (c1, c2, c3, eq))

			separate c2 as sep_c2 do
				sep_c2.set_item ('a')
			end
			c3 := Void
			assert ("not (c1 ≜ c2 ≜ c3)", not eq.holds_successively (c1, c2, c3))
			assert ("not (c1 ≜ c2 ≜ c3) ok", holds_successively_ok (c1, c2, c3, eq))
		end

feature {NONE} -- Factory (Element to be tested)

	equality_to_be_tested: OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]
			-- <Precursor>
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
