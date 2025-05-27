note
	description: "Pool of features available for test classes that need one generic parameter and its respective equality type"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [G]

inherit
	ELEMENT_TESTS
		redefine
			some_element
		end

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
		note
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			if attached a then
				Result := a.twin
			else
				Result := a
			end
		ensure
			definition: Result ~ a
		rescue
			if Result /~ a then -- Please have a look at EIS entry above.
				retry
			end
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

feature -- Factory (Element)

	some_element: STS_ELEMENT
			-- Randomly-fetched polymorphic element
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := Precursor {ELEMENT_TESTS}
			when 1 then
				Result := some_equality_g
			when 2 then
				Result := some_set_g
			end
		end

feature -- Factory (Equality)

	some_equality_g: STS_EQUALITY [G]
			-- Randomly-fetched polymorphic equality for comparing objects like {G}
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality_g
			when 1 then
				Result := some_object_standard_equality_g
			when 2 then
				Result := some_object_equality_g
			when 3 then
				Result := some_object_deep_equality_g
			end
		end

	some_reference_equality_g: STS_REFERENCE_EQUALITY [G]
			-- Randomly-fetched instance of {STS_REFERENCE_EQUALITY [G]}
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [G]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [G] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [G]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_g: STS_OBJECT_STANDARD_EQUALITY [G]
			-- Randomly-fetched instance of {STS_OBJECT_STANDARD_EQUALITY [G]}
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [G]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [G] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [G]}
			then
				Result := eq
			end
		end

	some_object_equality_g: STS_OBJECT_EQUALITY [G]
			-- Randomly-fetched instance of {STS_OBJECT_EQUALITY [G]}
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [G]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [G] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [G]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_g: STS_OBJECT_DEEP_EQUALITY [G]
			-- Randomly-fetched instance of {STS_OBJECT_DEEP_EQUALITY [G]}
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [G]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [G] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [G]}
			then
				Result := eq
			end
		end

feature -- Factory (Set)

	some_set_g: STS_SET [G]
			-- Randomly-fetched polymorphic set of elements like {G}, whose equality is checked by {EQ}
		do
			Result := some_immediate_set_g
		end

	some_immediate_set_g: STS_SET [G]
			-- Some monomorphic set of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_g}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
