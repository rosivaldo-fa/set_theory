note
	description: "Test suite for {STS_OBJECT_STANDARD_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_STANDARD_EQUALITY_TESTS [A, EQ -> STS_OBJECT_STANDARD_EQUALITY [A] create default_create end]

inherit
	EQUALITY_TESTS [A, EQ]
		redefine
			test_holds,
			test_holds_successively,
			same_object_a
		end

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_OBJECT_STANDARD_EQUALITY}.holds.
		note
			testing: "covers/{STS_OBJECT_STANDARD_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: A
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_a
			a2 := object_standard_twin_a (a1)
			assert ("a1 ≜ a2", eq (a1, a2))
			assert ("a1 ≜ a2 ok", properties.holds_ok (a1, a2, eq))

			separate a1 as sep_a1 do
				from
					a2 := some_object_a
				until
					if attached sep_a1 then
						not attached a2 or else not (sep_a1 ≜ a2)
					else
						attached a2
					end
				loop
					a2 := some_object_a
				end
			end
			assert ("not (a1 ≜ a2)", not eq (a1, a2))
			assert ("not (a1 ≜ a2) ok", properties.holds_ok (a1, a2, eq))
		end

	test_holds_successively
			-- Test {STS_INSTANCE_FREE_EQUALITY}.holds_successively.
			-- Test {STS_OBJECT_STANDARD_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_STANDARD_EQUALITY}.holds_successively"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: A
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_a
			a2 := object_standard_twin_a (a1)
			a3 := object_standard_twin_a (a2)
			assert ("a1 ≜ a2 ≜ a3", eq.holds_successively (a1, a2, a3))
			assert ("a1 ≜ a2 ≜ a3 ok", properties.holds_successively_ok (a1, a2, a3, eq))

			from
				a2 := some_object_a
				a3 := some_object_a
			until (
				agent (ia_a1, ia_a2, ia_a3: A): BOOLEAN
					do
						Result := if attached ia_a1 then
							not (attached ia_a2 and attached ia_a3) or else not (ia_a1 ≜ ia_a2 and ia_a2 ≜ ia_a3)
						else
							attached ia_a2 or attached ia_a3
						end
					end
				).item (a1, a2, a3)
			loop
				a2 := some_object_a
				a3 := some_object_a
			end
			assert ("not (a1 ≜ a2 ≜ a3)", not eq.holds_successively (a1, a2, a3))
			assert ("not (a1 ≜ a2 ≜ a3) ok", properties.holds_successively_ok (a1, a2, a3, eq))
		end

feature -- Factory (Object)

	same_object_a (a: A): A
			-- <Precursor>
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := Precursor (a)
			when 1 then
				Result := object_standard_twin_a (a)
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
