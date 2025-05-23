note
	description: "Pool of features available for test classes that need one generic parameter and its respective equality type"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [G]

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_object_g: G
			-- Randomly-fetched object like {G}
		deferred
		end

	object_standard_twin_g (a: G): G
			-- Object equal (according to `standard_equal') to `a'
		do
			if attached a then
				Result := a.standard_twin
			else
				Result := a
			end
		ensure
			attached_a: attached a ⇒ attached Result and then Result ≜ a
			detached_a: not attached a ⇒ not attached Result
		end

	object_twin_g (a: G): G
			-- Object equal (by value) to `a'
		do
			if attached a then
				Result := a.twin
			else
				Result := a
			end
		ensure
			definition: Result ~ a
		end

	object_deep_twin_g (a: G): G
			-- Object equal (according to `deep_equal') to `a'
		do
			if attached a then
				Result := a.deep_twin
			else
				Result := a
			end
		ensure
			attached_a: attached a ⇒ attached Result and then Result ≡≡≡ a
			detached_a: not attached a ⇒ not attached Result
		end

feature -- Factory (Set)

--	some_set_g: STS_SET [G]
--			-- Randomly-fetched polymorphic set of elements like {G}, whose equality is checked by {EQ}
--		deferred
--		end

--	some_immediate_set_g: STS_SET [G]
--			-- Some monomorphic set of elements like {G}
--		deferred
--		ensure
--			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_g}
--		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
