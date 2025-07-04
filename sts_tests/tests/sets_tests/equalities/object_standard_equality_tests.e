note
	description: "Test suite for {STS_OBJECT_STANDARD_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_STANDARD_EQUALITY_TESTS [G]

inherit
	EQUALITY_TESTS [G]
		redefine
			test_holds,
			test_holds_successively
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_OBJECT_STANDARD_EQUALITY}.holds.
		note
			testing: "covers/{STS_OBJECT_STANDARD_EQUALITY}.holds"
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			eq: like equality_to_be_tested
			a1, a2: G
			eq_failed, neq_failed: BOOLEAN
		do
			if not eq_failed then
				Precursor {EQUALITY_TESTS}

				eq := equality_to_be_tested
				a1 := some_object_g
			else
				check
						-- If eq_failed, then a1 and eq got attached at some iteration before.
					attached a1
					attached eq
				then
				end
			end
			if not neq_failed then
				a2 := object_standard_twin_g (a1)
				assert ("a1 ≜ a2", eq (a1, a2))
			end

			separate a1 as sep_a1 do
				from
					a2 := some_object_g
				until
					if attached sep_a1 then
						not attached a2 or else not (sep_a1 ≜ a2)
					else
						attached a2
					end
				loop
					a2 := some_object_g
				end
			end
			assert ("not (a1 ≜ a2)", not eq (a1, a2))
		rescue
			if {EXCEPTIONS}.tag_name ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("a1 ≜ a2") then
				eq_failed := True -- Please have a look at EIS entry above.
				retry
			elseif {EXCEPTIONS}.tag_name ~ {UTF_CONVERTER}.string_32_to_utf_8_string_8 ("not (a1 ≜ a2)") then
				neq_failed := True -- Please have a look at EIS entry above.
				retry
			end
		end

	test_holds_successively
			-- Test {STS_INSTANCE_FREE_EQUALITY}.holds_successively.
			-- Test {STS_OBJECT_STANDARD_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_STANDARD_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: G
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_g
			a2 := object_standard_twin_g (a1)
			a3 := object_standard_twin_g (a2)
			assert ("a1 ≜ a2 ≜ a3", eq.holds_successively (a1, a2, a3))
			assert ("a1 ≜ a2 ≜ a3 ok", holds_successively_ok (a1, a2, a3, eq))

			from
				a2 := some_object_g
				a3 := some_object_g
			until (
					agent (ia_a1, ia_a2, ia_a3: G): BOOLEAN
						do
							Result := if attached ia_a1 then
									not (attached ia_a2 and attached ia_a3) or else not (ia_a1 ≜ ia_a2 and ia_a2 ≜ ia_a3)
								else
									attached ia_a2 or attached ia_a3
								end
						end
				).item (a1, a2, a3)
			loop
				a2 := some_object_g
				a3 := some_object_g
			end
			assert ("not (a1 ≜ a2 ≜ a3)", not eq.holds_successively (a1, a2, a3))
			assert ("not (a1 ≜ a2 ≜ a3) ok", holds_successively_ok (a1, a2, a3, eq))
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
