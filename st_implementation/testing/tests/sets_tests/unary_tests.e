note
	description: "Pool of features available for test classes that need one generic parameter and its respective equality type"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	ELEMENT_TESTS
		redefine
			on_prepare
		end

feature -- Access

	eq_a: EQ
			-- Equality for objects like {A}

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			Precursor {ELEMENT_TESTS}
			create eq_a
		end

feature -- Factory (Object)

	some_object_a: A
			-- Randomly-fetched object like {A}
		deferred
		end

	same_object_a (a: A): A
			-- Randomly-fetched object like {A}
		do
			Result := a
		ensure
			definition: eq_a (Result, a)
		end

	some_other_object_a (s: STS_SET [A, EQ]): A
			-- Randomly-fetched object like {A} not belonging to `s'
		do
			from
				Result := some_object_a
			until
				not (s ∋ Result)
			loop
				Result := some_object_a
			end
		ensure
			not_in_s: not (s ∋ Result)
		end

	object_standard_twin_a (a: A): A
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

	object_twin_a (a: A): A
			-- Object equal (by value) to `a'
		note
			EIS: "name={ANY}.deep_twin bug", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_implementation_tests.html#19887", "tag=bug, compiler"
		do
			if attached a then
				Result := a.twin
			else
				Result := a
			end
		ensure
			definition: Result ~ a
		end

	object_deep_twin_a (a: A): A
			-- Object equal (according to `deep_equal') to `a'
		note
			EIS: "name={ANY}.deep_twin bug", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_implementation_tests.html#19887", "tag=bug, compiler"
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

	some_set_a: STS_SET [A, EQ]
			-- Randomly-fetched polymorphic set of elements like {A}, whose equality is checked by {EQ}
		deferred
		end

	some_immediate_set_a: SET [A, EQ]
			-- Some monomorphic set of elements like {A}
		note
			EIS: "name=Post-condition ignored on joined descendant", "protocol=URI", "src=https://support.eiffel.com/report_detail/19889", "tag=bug, compiler"
		deferred
		ensure
			bug_ignored_on_joined_descendant: False
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_a}
		end

	same_set_a (s: STS_SET [A, EQ]): like some_set_a
			-- Set mathematically equal to `s', with type randomly chosen.
		local
			l_s: STS_SET [A, EQ]
			tmp_result: SET [A, EQ]
		do
			inspect
				next_random_item \\ 3
			when 0 then
				Result := s
			when 1 then
				if attached {SET [A, EQ]} s as effective_s then
					Result := effective_s.twin
				else
					Result := s
				end
--			when 2 then
--				inspect
--					next_random_item \\ 2
--				when 0 then
----					create {like some_immediate_set_a} Result.make_from_set (s)
--				when 1 then
----					create {like new_transformable_set_aa} Result.make_from_set (s)
--				end
			when 2 then
				inspect
					next_random_item \\ 1
				when 0 then
					create {like some_immediate_set_a} tmp_result.make_empty
--				when 1 then
--					create {like new_transformable_set_aa} tmp_result.make_empty
				end
				inspect
					next_random_item \\ 2
				when 0 then
					check
						is_disjoint: tmp_result.is_disjoint (s) -- tmp_result.is_empty
					end
					Result := tmp_result.batch_extended (s)
				when 1 then
					from
						l_s := s
					invariant
----						building_prefixed_s_up: tmp_result.as_tuple.prefix (# (s ∖ l_s)).terms ≍ (s ∖ l_s)
----						suffixed_o: tmp_result.as_tuple.suffix (0).terms.is_empty
					until
						l_s.is_empty
					loop
						check
							does_not_have: tmp_result ∌ l_s.any -- tmp_result ≍ (s ∖ l_s)
						end
						tmp_result := tmp_result.extended (same_object_a (l_s.any))
						l_s := l_s.others
					variant
						cardinality: {SET [A, EQ]}.natural_as_integer (# l_s)
					end
					Result := tmp_result
				end
			end
		ensure
			definition: Result ≍ s
		end

	some_set_sa: STS_SET [STS_SET [A, EQ], STS_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched polymorphic set of sets of elements like {A}
		do
			inspect
				next_random_item \\ 4
			when 0 then
				Result := some_set_references_a
			when 1 then
				Result := some_set_standard_objects_a
			when 2 then
				Result := some_set_objects_a
			when 3 then
				Result := some_set_deep_objects_a
--			when 4 then
--				Result := some_sets_a
			end
		end

	some_set_references_a: STS_SET [STS_SET [A, EQ], STS_REFERENCE_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched set of sets of elements like {A}, and whose (member) sets are compared by their object references.
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_effecive_set_references_a
--			when 1 then
--				Result := some_reference_sets_a
			end
		end

	some_immediate_effecive_set_references_a: SET [STS_SET [A, EQ], STS_REFERENCE_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched monomorphic set of sets of elements like {A}, and whose (member) sets are compared by their object references.
		do
			check
				ss: attached {SET [STS_SET [A, EQ], STS_REFERENCE_EQUALITY [STS_SET [A, EQ]]]} some_immediate_instance (
							agent: SET [STS_SET [A, EQ], STS_REFERENCE_EQUALITY [STS_SET [A, EQ]]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_set_a
									end
								end
						) as ss -- `some_immediate_instance' definition
			then
				Result := cropped_set (ss)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable SET [STS_SET [A, EQ], STS_REFERENCE_EQUALITY [STS_SET [A, EQ]]]}
		end

	some_set_standard_objects_a: STS_SET [STS_SET [A, EQ], STS_OBJECT_STANDARD_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched set of sets of elements like {A}, and whose (member) sets are compared by their standard object values.
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_effecive_set_standard_objects_a
--			when 1 then
--				Result := some_reference_sets_a
			end
		end

	some_immediate_effecive_set_standard_objects_a: SET [STS_SET [A, EQ], STS_OBJECT_STANDARD_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched monomorphic set of sets of elements like {A}, and whose (member) sets are compared by their standard object values.
		do
			check
				ss: attached {SET [STS_SET [A, EQ], STS_OBJECT_STANDARD_EQUALITY [STS_SET [A, EQ]]]} some_immediate_instance (
							agent: SET [STS_SET [A, EQ], STS_OBJECT_STANDARD_EQUALITY [STS_SET [A, EQ]]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_set_a
									end
								end
						) as ss -- `some_immediate_instance' definition
			then
				Result := cropped_set (ss)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable SET [STS_SET [A, EQ], STS_OBJECT_STANDARD_EQUALITY [STS_SET [A, EQ]]]}
		end

	some_set_objects_a: STS_SET [STS_SET [A, EQ], STS_OBJECT_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched set of sets of elements like {A}, and whose (member) sets are compared by their standard object values.
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_effecive_set_objects_a
--			when 1 then
--				Result := some_reference_sets_a
			end
		end

	some_immediate_effecive_set_objects_a: SET [STS_SET [A, EQ], STS_OBJECT_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched monomorphic set of sets of elements like {A}, and whose (member) sets are compared by their object values.
		do
			check
				ss: attached {SET [STS_SET [A, EQ], STS_OBJECT_EQUALITY [STS_SET [A, EQ]]]} some_immediate_instance (
							agent: SET [STS_SET [A, EQ], STS_OBJECT_EQUALITY [STS_SET [A, EQ]]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_set_a
									end
								end
						) as ss -- `some_immediate_instance' definition
			then
				Result := cropped_set (ss)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable SET [STS_SET [A, EQ], STS_OBJECT_EQUALITY [STS_SET [A, EQ]]]}
		end

	some_set_deep_objects_a: STS_SET [STS_SET [A, EQ], STS_OBJECT_DEEP_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched set of sets of elements like {A}, and whose (member) sets are compared by their deep object values.
		do
			inspect
				next_random_item \\ 1
			when 0 then
				Result := some_immediate_effecive_set_deep_objects_a
--			when 1 then
--				Result := some_reference_sets_a
			end
		end

	some_immediate_effecive_set_deep_objects_a: SET [STS_SET [A, EQ], STS_OBJECT_DEEP_EQUALITY [STS_SET [A, EQ]]]
			-- Randomly-fetched monomorphic set of sets of elements like {A}, and whose (member) sets are compared by their deep object values.
		do
			check
				ss: attached {SET [STS_SET [A, EQ], STS_OBJECT_DEEP_EQUALITY [STS_SET [A, EQ]]]} some_immediate_instance (
							agent: SET [STS_SET [A, EQ], STS_OBJECT_DEEP_EQUALITY [STS_SET [A, EQ]]]
								do
									across
										1 |..| some_count.as_integer_32 as i
									from
										create Result.make_empty
									loop
										Result := Result & some_set_a
									end
								end
						) as ss -- `some_immediate_instance' definition
			then
				Result := cropped_set (ss)
			end
		ensure
			monomorphic: Result.generating_type ~ {detachable SET [STS_SET [A, EQ], STS_OBJECT_DEEP_EQUALITY [STS_SET [A, EQ]]]}
		end

feature -- Predicate

	negated (p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical negation of `p' (`x'), i.e. is `p' (`x') false?
			-- TODO: DRY.
		do
			Result := not p (x)
		ensure
			class
			definition: Result = not p (x)
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
