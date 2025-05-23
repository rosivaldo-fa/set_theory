note
	description: "Test suite for {STS_OBJECT_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_EQUALITY_TESTS [G]

inherit
	EQUALITY_TESTS [G]
		redefine
			test_holds,
			test_holds_successively
		end
	OBJECT_EQUALITY_PROPERTIES [G]

feature -- Test routines (Relationship)

	test_holds
			-- Test {STS_OBJECT_EQUALITY}.holds.
		note
			testing: "covers/{STS_OBJECT_EQUALITY}.holds"
		local
			eq: like equality_to_be_tested
			a1, a2: G
		do
			Precursor {EQUALITY_TESTS}

			eq := equality_to_be_tested
			a1 := some_object_g
			a2 := object_twin_g (a1)
			assert ("a1 ~ a2", eq (a1, a2))
			assert ("a1 ~ a2 ok", holds_ok (a1, a2, eq))

			from
				a2 := some_object_g
			until
				a2 /~ a1
			loop
				a2 := some_object_g
			end
			assert ("a1 /~ a2", not eq (a1, a2))
			assert ("a1 /~ a2 ok", holds_ok (a1, a2, eq))
		end

	test_holds_successively
			-- Test {STS_INSTANCE_FREE_EQUALITY}.holds_successively.
			-- Test {STS_OBJECT_EQUALITY}.holds_successively.
		note
			testing: "covers/{STS_INSTANCE_FREE_EQUALITY}.holds_successively"
			testing: "covers/{STS_OBJECT_EQUALITY}.holds_successively"
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		local
			eq: like equality_to_be_tested
			a1, a2, a3: G
			bug_19952: BOOLEAN
		do
			if not bug_19952 then
				Precursor {EQUALITY_TESTS}

				eq := equality_to_be_tested
				a1 := some_object_g
				a2 := object_twin_g (a1)
				a3 := object_twin_g (a2)
				assert ("a1 ~ a2 ~ a3", eq.holds_successively (a1, a2, a3))
				assert ("a1 ~ a2 ~ a3 ok", holds_successively_ok (a1, a2, a3, eq))
			else
				check
						-- We reach here only if bug_19952 is true, wich implies all entities below are attached.
					attached eq
					attached a1
					attached a2
					attached a3
				then
					if a1 /~ a2 then
						a2 := object_twin_g (a1)
					end
					if a2 /~ a3 then
						a3 := object_twin_g (a2)
					end
					assert ("a1 ~ a2 ~ a3", eq.holds_successively (a1, a2, a3))
					assert ("a1 ~ a2 ~ a3 ok", holds_successively_ok (a1, a2, a3, eq))
				end
			end

			from
				a2 := some_object_g
				a3 := some_object_g
			until
				not (a1 ~ a2 and a2 ~ a3)
			loop
				a2 := some_object_g
				a3 := some_object_g
			end
			assert ("not (a1 ~ a2 ~ a3)", not eq.holds_successively (a1, a2, a3))
			assert ("not (a1 ~ a2 ~ a3) ok", holds_successively_ok (a1, a2, a3, eq))
		rescue
			if
				{EXCEPTIONS}.exception = {EXCEPTIONS}.postcondition and (
					{EXCEPTIONS}.recipient_name ~ "object_twin_g" or
					{EXCEPTIONS}.recipient_name ~ "holds_successively"
					) or
				{EXCEPTIONS}.tag_name ~ "a1 ~ a2 ~ a3"
			then
				bug_19952 := True
				retry
			end
		end

feature -- Factory (Object)

	same_object_g (a: G): G
			-- Randomly-fetched object like {G}
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := a
			when 1 then
				Result := object_standard_twin_g (a)
			when 2 then
				Result := object_twin_g (a)
			end
		end

feature -- Factory (Equality)

	some_immediate_equality_g: STS_OBJECT_EQUALITY [G]
			-- Some monomorphic object equality for {G} objects
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
