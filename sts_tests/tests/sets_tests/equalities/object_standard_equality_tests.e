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
		local
			eq: like equality_to_be_tested
			a1, a2: G
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_g
			a2 := object_standard_twin_g (a1)
			assert ("a1 ≜ a2", eq (a1, a2))

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

feature -- Factory (Object)

	same_object_g (a: G): G
			-- Randomly-fetched object like {G}
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := a
			when 1 then
				Result := object_standard_twin_g (a)
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
