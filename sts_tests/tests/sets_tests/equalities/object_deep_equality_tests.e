note
	description: "Test suite for {STS_OBJECT_DEEP_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_DEEP_EQUALITY_TESTS [G]

--inherit
--	EQUALITY_TESTS [G]
--		redefine
--			test_holds
--		end

--	OBJECT_DEEP_EQUALITY_PROPERTIES [G]

--feature -- Test routines (Relationship)

--	test_holds
--			-- Test {STS_OBJECT_DEEP_EQUALITY}.holds.
--		note
--			testing: "covers/{STS_OBJECT_DEEP_EQUALITY}.holds"
--		local
--			eq: like equality_to_be_tested
--			a1, a2: G
--		do
--			Precursor {EQUALITY_TESTS}

--			eq := equality_to_be_tested
--			a1 := some_object_g
--			a2 := object_deep_twin_g (a1)
--			assert ("a1 ≡≡≡ a2", eq (a1, a2))
--			assert ("a1 ≡≡≡ a2 ok", holds_ok (a1, a2, eq))

--			separate a1 as sep_a1 do
--				from
--					a2 := some_object_g
--				until
--					if attached sep_a1 then
--						not attached a2 or else not (sep_a1 ≡≡≡ a2)
--					else
--						attached a2
--					end
--				loop
--					a2 := some_object_g
--				end
--			end
--			assert ("not (a1 ≡≡≡ a2)", not eq (a1, a2))
--		end

--feature -- Factory (Object)

--	same_object_g (a: G): G
--			-- Randomly-fetched object like {G}
--		do
--			inspect
--				next_random_item \\ 3
--			when 0 then
--				Result := a
--			when 1 then
--				Result := object_standard_twin_g (a)
--			when 2 then
--				Result := object_deep_twin_g (a)
--			end
--		end

--feature -- Factory (Equality)

--	some_immediate_equality_g: STS_OBJECT_DEEP_EQUALITY [G]
--			-- Some monomorphic object deep equality for {G} objects
--		deferred
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
