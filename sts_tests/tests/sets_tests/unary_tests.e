note
	description: "Pool of features available for test classes that need one generic parameter"
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
		note
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			if attached a then
				from
					Result := a.standard_twin
				until
					attached a ⇒ attached Result and then Result ≜ a -- Please have a look at EIS entry above.
				loop
					Result := a.standard_twin
				end
			else
				Result := a
			end
		ensure
			when_attached_a: attached a ⇒ attached Result and then Result ≜ a
			when_detached_a: not attached a ⇒ not attached Result
		end

	object_twin_g (a: G): G
			-- Object equal (by value) to `a'
		note
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			if attached a then
				from
					Result := a.twin
				until
					a ~ Result -- Please have a look at EIS entry above.
				loop
					Result := a.twin
				end
			else
				Result := a
			end
		ensure
			definition: Result ~ a
		end

	object_deep_twin_g (a: G): G
			-- Object equal (according to `deep_equal') to `a'
		note
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			if attached a then
				from
					Result := a.deep_twin
				until
					a ≡≡≡ Result -- Please have a look at EIS entry above.
				loop
					Result := a.deep_twin
				end
			else
				Result := a
			end
		ensure
			attached_a: attached a ⇒ attached Result and then Result ≡≡≡ a
			detached_a: not attached a ⇒ not attached Result
		end

	same_object_g (a: G; eq: STS_EQUALITY [G]): G
			-- Randomly-fetched object equal to `a' according to `eq'
		do
			Result := a
			if next_random_item \\ 2 = 0 then
				if {ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_STANDARD_EQUALITY [G]}).type_id) then
					Result := object_standard_twin_g (a)
				elseif {ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_EQUALITY [G]}).type_id) then
					Result := object_twin_g (a)
				elseif {ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_DEEP_EQUALITY [G]}).type_id) then
					Result := object_deep_twin_g (a)
				end
			end
		ensure
			when_detached_a: not attached a ⇒ a = Result
			when_object_standard_equality: attached a and
				{ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_STANDARD_EQUALITY [G]}).type_id) ⇒
				attached Result and then a ≜ Result
			when_object_equality: attached a and
				{ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_EQUALITY [G]}).type_id) ⇒ a ~ Result
			when_object_deep_equality: attached a and
				{ISE_RUNTIME}.type_conforms_to (eq.generating_type.type_id, ({STS_OBJECT_DEEP_EQUALITY [G]}).type_id) ⇒
				attached Result and then a ≡≡≡ Result
		end

feature -- Factory (Element)

	some_element: STS_ELEMENT
			-- Randomly-fetched polymorphic element
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := Precursor {ELEMENT_TESTS}
			when 1 then
				Result := some_equality_g
			when 2 then
				Result := some_set_g
			when 3 then
				Result := some_set_family_g
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

	some_equality_sg: STS_EQUALITY [STS_SET [G]]
			-- Randomly-fetched polymorphic equality for comparing sets of objects like {G}
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_reference_equality_sg
			when 1 then
				Result := some_object_standard_equality_sg
			when 2 then
				Result := some_object_equality_sg
			when 3 then
				Result := some_object_deep_equality_sg
					-- TODO: Add set equality
			end
		end

	some_reference_equality_sg: STS_REFERENCE_EQUALITY [STS_SET [G]]
			-- Randomly-fetched instance of {STS_REFERENCE_EQUALITY [STS_SET [G]]}
		do
			check
				eq: attached {STS_REFERENCE_EQUALITY [STS_SET [G]]} some_immediate_instance
						(agent: STS_REFERENCE_EQUALITY [STS_SET [G]] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_REFERENCE_EQUALITY [STS_SET [G]]}
			then
				Result := eq
			end
		end

	some_object_standard_equality_sg: STS_OBJECT_STANDARD_EQUALITY [STS_SET [G]]
			-- Randomly-fetched instance of {STS_OBJECT_STANDARD_EQUALITY [STS_SET [G]]}
		do
			check
				eq: attached {STS_OBJECT_STANDARD_EQUALITY [STS_SET [G]]} some_immediate_instance
						(agent: STS_OBJECT_STANDARD_EQUALITY [STS_SET [G]] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_STANDARD_EQUALITY [STS_SET [G]]}
			then
				Result := eq
			end
		end

	some_object_equality_sg: STS_OBJECT_EQUALITY [STS_SET [G]]
			-- Randomly-fetched instance of {STS_OBJECT_EQUALITY [STS_SET [G]]}
		do
			check
				eq: attached {STS_OBJECT_EQUALITY [STS_SET [G]]} some_immediate_instance
						(agent: STS_OBJECT_EQUALITY [STS_SET [G]] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_EQUALITY [STS_SET [G]]}
			then
				Result := eq
			end
		end

	some_object_deep_equality_sg: STS_OBJECT_DEEP_EQUALITY [STS_SET [G]]
			-- Randomly-fetched instance of {STS_OBJECT_DEEP_EQUALITY [STS_SET [G]]}
		do
			check
				eq: attached {STS_OBJECT_DEEP_EQUALITY [STS_SET [G]]} some_immediate_instance
						(agent: STS_OBJECT_DEEP_EQUALITY [STS_SET [G]] do create Result end) as eq -- `some_immediate_instance' definition
				monomorphic: eq.generating_type ~ {detachable STS_OBJECT_DEEP_EQUALITY [STS_SET [G]]}
			then
				Result := eq
			end
		end

feature -- Factory (Set)

	some_set_g: STS_SET [G]
			-- Randomly-fetched polymorphic set of elements like {G}
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_g
			when 1 then
				Result := some_universe_g
			end
		end

	some_immediate_set_g: STS_SET [G]
			-- Randomly-fetched monomorphic set of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_g}
		end

	some_set_sg: STS_SET [STS_SET [G]]
			-- Randomly-fetched polymorphic set of sets of elements like {G}
		do
			inspect
				next_random_item \\ 2
			when 0 then
				Result := some_immediate_set_sg
			when 1 then
				Result := some_set_family_g
			end
		end

	some_immediate_set_sg: STS_SET [STS_SET [G]]
			-- Randomly-fetched monomorphic set of sets of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_sg}
		end

	some_set_family_g: STS_SET_FAMILY [G]
			-- Randomly-fetched polymorphic family of sets of elements like {G}
		do
			Result := some_immediate_set_family_g
		end

	some_immediate_set_family_g: STS_SET_FAMILY [G]
			-- Randomly-fetched monomorphic family of sets of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_family_g}
		end

	some_universe_g: STS_UNIVERSE [G]
			-- Randomly-fetched polymorphic universe of elements like {G}
		do
			Result := some_immediate_universe_g
		end

	some_immediate_universe_g: STS_UNIVERSE [G]
			-- Randomly-fetched monomorphic universe of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_universe_g}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
