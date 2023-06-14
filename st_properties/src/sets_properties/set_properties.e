note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_PROPERTIES [A, EQ -> STS_EQUALITY [A]]

inherit
	ELEMENT_PROPERTIES
		rename
			is_in_ok as element_is_in_ok,
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Access

	o: like o_anchor
			-- The empty set
		deferred
		ensure
			is_empty: Result.is_empty
		end

	current_universe: like universe_anchor
			-- The current "Universe", i.e. set with every object currently in system memory whose type conforms to {A}.
			-- Notice that this "universe" may change from a call to another.
		deferred
		end

	eq: EQ
			-- Equality for objects like {A}
		deferred
		end

feature -- Properties (Primitive)

	is_empty_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_empty?
		do
			check
				u: attached current_universe as u
				definition: s.is_empty = (
							s ≍ (
								u | agent (x: A): BOOLEAN
									do
										Result := False
									end
							)
						)
				has_nothing: s.is_empty = (u |∀ agent s.does_not_have)
				no_element: s.is_empty = (# s = 0)
				uniqueness: s.is_empty = (s ≍ o)
			then
				Result := True
			end
		end

	any_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.any?
		do
			if not s.is_empty then
				check
					membership: s ∋ s.any
					building_up: s ≍ (s.others & s.any)
				then
				end
			end
			Result := True
		end

	others_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.others?
		do
			if s.is_empty then
				check
					same_set: s.others ≍ s
					no_element: # s.others = # s
				then
				end
			else
				check
					decomposing: s.others ≍ (s / s.any)
					strict_subset: s.others ⊂ s
					one_element_less: # s.others = # s - 1
				then
				end
			end
			check
				subset: s.others ⊆ s
			then
				Result := True
			end
		end

feature -- Properties (Membership)

	is_in_ok (s: STS_SET [A, EQ]; ss: STS_SET [STS_SET [A, EQ], STS_EQUALITY [STS_SET [A, EQ]]]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_in?
		do
			check
				require_non_emptiness: s ∈ ss ⇒ not ss.is_empty
			then
				Result := True
			end
		end

	is_not_in_ok (s: STS_SET [A, EQ]; ss: STS_SET [STS_SET [A, EQ], STS_EQUALITY [STS_SET [A, EQ]]]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_in?
		do
			check
				definition: s ∉ ss = ss ∌ s
				sufficient_emptiness: ss.is_empty ⇒ s ∉ ss
			then
				Result := True
			end
		end

	has_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.has?
		do
			check
				u: attached current_universe as u
				require_non_emptiness: s ∋ a ⇒ not s.is_empty
				universe_has_everything: u ∋ a
				uniqueness: s ∋ a = s |∃! agent s.equality_holds (?, a)
				has_own_elements: s |∀ agent s.has
			then
				Result := True
			end
		end

	does_not_have_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.does_not_have?
		do
			check
				definition: s ∌ a = s |∄ agent s.equality_holds (?, a)
				has_own_elements: s |∄ agent s.does_not_have
				empty_set_has_nothing: o ∌ a
			then
				Result := True
			end
		end

feature -- Properties (Construction)

	with_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.with?
		do
			check
				u: attached current_universe as u
				definition: (s & a) ≍ (u | agent u.ored (agent s.has, agent u.equality_holds (?, a), ?))
				by_union: (s & a) ≍ (s ∪ singleton (a))
				same_cardinality: s ∋ a ⇒ # (s & a) = # s
				incremented_cardinality: s ∌ a ⇒ # (s & a) = # s + 1
			then
				Result := True
			end
		end

	without_ok (s: STS_SET [A, EQ]; a: A): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.without?
		do
			check
				u: attached current_universe as u
				definition: (s / a) ≍ (u | agent anded (agent s.has, agent negated (agent s.equality_holds (?, a), ?), ?))
				excluded: (s / a) ∌ a
				every_other_element: s |∀ agent implied (agent negated (agent s.equality_holds (?, a), ?), agent (s / a).has, ?)
				nothing_else: (s / a) ⊆ s
				same_cardinality: s ∌ a ⇒ # (s / a) = # s
				decremented_cardinality: s ∋ a ⇒ # (s / a) = # s - 1
			then
				Result := True
			end
		end

feature -- Properties (Quality)

	is_singleton_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_singleton?
		do
			check
				definition: s.is_singleton = (# s = 1)
				by_construction: s.is_singleton ⇒ not s.is_empty and then s ≍ singleton (s.any)
			then
				Result := True
			end
		end

feature -- Properties (Measurement)

	cardinality_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.cardinality?
		do
			check
--				definition: # s = s.as_tuple.n
			then
				Result := True
			end
		end

feature -- Properties (Comparison)

	equals_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.equals?
		do
			check
				u: attached current_universe as u
				definition: s1 ≍ s2 = (u |∀ agent u.iff (agent s1.has, agent s2.has, ?))
				u_ps_ps_card: attached (2 ^ (2 ^ # u)) as u_ps_ps_card
				set_comparisons_upper_bound: attached (2 * u_ps_ps_card) as set_comparisons_upper_bound
				element_comparisons_upper_bound: attached ((# u ^ 2) * set_comparisons_upper_bound) as
 element_comparisons_upper_bound
--				checked_ps: attached {ISE_RUNTIME}.check_assert
--					(element_comparisons_upper_bound ≤ max_asserted_elements) as checked_ps
--					by_membership: element_comparisons_upper_bound ≤ max_elements ⇒ s1 ≍ s2 = (
--						u.powerset.powerset |∀ agent
--							(ss: STS_SET [STS_SET [A, EQ], STS_SET_EQUALITY [A, EQ]]; ia_s1, ia_s2: STS_SET [A, EQ]): BOOLEAN
--							do
--								Result := ia_s1 ∈ ss = ia_s2 ∈ ss
--							end (?, s1, s2)
--						)
--				checked_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_ps)
				by_inclusion: s1 ≍ s2 = (s1 ⊆ s2 and s2 ⊆ s1)
				reflexive: s1 ≍ s1
				symmetric: s1 ≍ s2 ⇒ s2 ≍ s1
				transitive: s1 ≍ s2 and s2 ≍ s3 ⇒ s1 ≍ s3
				same_cardinality: s1 ≍ s2 ⇒ (# s1 = # s2)
			then
				Result := True
			end
		end

	unequals_ok (s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.unequals?
		do
			check
				u: attached current_universe as u
				definition_1: s1 ≭ s2 = (
							u |∃ agent u.ored (
									agent anded (agent s1.has, agent s2.does_not_have, ?),
									agent anded (agent s1.does_not_have, agent s2.has, ?), ?
								)
						)
				definition_2: s1 ≭ s2 = (
							(u |∃ agent anded (agent s1.has, agent s2.does_not_have, ?)) or
							(u |∃ agent anded (agent s2.has, agent s1.does_not_have, ?))
						)
				lesser_definition: s1 ≭ s2 = ((s1 |∃ agent s2.does_not_have) or (s2 |∃ agent s1.does_not_have))
				u_ps_ps_card: attached (2 ^ (2 ^ # u)) as u_ps_ps_card
				set_comparisons_upper_bound: attached (2 * u_ps_ps_card) as set_comparisons_upper_bound
				element_comparisons_upper_bound: attached ((# u ^ 2) * set_comparisons_upper_bound) as
 element_comparisons_upper_bound
--				checked_ps: attached {ISE_RUNTIME}.check_assert
--					(element_comparisons_upper_bound ≤ max_asserted_elements) as checked_ps
--					by_membership: element_comparisons_upper_bound ≤ max_elements ⇒ s1 ≭ s2 = (
--						u.powerset.powerset |∃ agent
--							(s: STS_SET [STS_SET [A, EQ], STS_SET_EQUALITY [A, EQ]]; ia_s1, ia_s2: STS_SET [A, EQ]): BOOLEAN
--							do
--								Result := ia_s1 ∈ s /= ia_s2 ∈ s
--							end (?, s1, s2)
--						)
--				checked_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_ps)
				by_uninclusion: s1 ≭ s2 = (s1 ⊈ s2 or s2 ⊈ s1)
				irreflexive: not (s1 ≭ s1)
				symmetric: s1 ≭ s2 ⇒ s2 ≭ s1
				unequal_cardinalities: (# s1 /= # s2) ⇒ s1 ≭ s2
			then
				Result := True
			end
		end

	is_subset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_subset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊆ s2 = (u |∀ agent implied (agent s1.has, agent s2.has, ?))
				by_difference: s1 ⊆ s2 = (s1 ∖ s2) ≍ o
				reflexive: s1 ⊆ s1
				transitive: s1 ⊆ s2 and s2 ⊆ s3 ⇒ s1 ⊆ s3
				antisymmetric: s1 ⊆ s2 and s2 ⊆ s1 ⇒ s1 ≍ s2
				everything_includes_o: o ⊆ s1
				u_includes_everything: s1 ⊆ u
				equality: s1 ≍ s2 = (s1 ⊆ s2 and s2 ⊆ s1)
				o_includes_only_o: s1 ⊆ o ⇒ s1 ≍ o
				only_u_includes_u: u ⊆ s1 ⇒ s1 ≍ u
				cardinality: s1 ⊆ s2 ⇒ # s1 ≤ # s2
			then
				Result := True
			end
		end

	is_not_subset_ok (s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_subset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊈ s2 = (u |∃ agent anded (agent s1.has, agent s2.does_not_have, ?))
				lesser_definition: s1 ⊈ s2 = (s1 |∃ agent s2.does_not_have)
				by_difference: s1 ⊈ s2 = (s1 ∖ s2) ≭ o
				irreflexive: not (s1 ⊈ s1)
				unequality: s1 ≭ s2 = (s1 ⊈ s2 or s2 ⊈ s1)
				o_includes_only_o: s1 ⊈ o ⇒ s1 ≭ o
				only_u_includes_u: u ⊈ s1 ⇒ s1 ≭ u
				cardinality: # s1 > # s2 ⇒ s1 ⊈ s2
			then
				Result := True
			end
		end

	is_superset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_superset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊇ s2 = (u |∀ agent implied (agent s2.has, agent s1.has, ?))
				lesser_definition: s1 ⊇ s2 = (s2 |∀ agent s1.has)
				by_difference: s1 ⊇ s2 = (s2 ∖ s1) ≍ o
				reflexive: s1 ⊇ s1
				transitive: s1 ⊇ s2 and s2 ⊇ s3 ⇒ s1 ⊇ s3
				antisymmetric: s1 ⊇ s2 and s2 ⊇ s1 ⇒ s1 ≍ s2
				everything_includes_o: s1 ⊇ o
				u_includes_everything: u ⊇ s1
				equality: s1 ≍ s2 = (s1 ⊇ s2 and s2 ⊇ s1)
				o_includes_only_o: o ⊇ s1 ⇒ s1 ≍ o
				only_u_includes_u: s1 ⊇ u ⇒ s1 ≍ u
				cardinality: s1 ⊇ s2 ⇒ # s1 ≥ # s2
			then
				Result := True
			end
		end

	is_not_superset_ok (s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_superset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊉ s2 = (u |∃ agent anded (agent s2.has, agent s1.does_not_have, ?))
				lesser_definition: s1 ⊉ s2 = (s2 |∃ agent s1.does_not_have)
				by_difference: s1 ⊉ s2 = (s2 ∖ s1) ≭ o
				irreflexive: not (s1 ⊉ s1)
				unequality: s1 ≭ s2 = (s1 ⊉ s2 or s2 ⊉ s1)
				o_includes_only_o: o ⊉ s1 ⇒ s1 ≭ o
				only_u_includes_u: s1 ⊉ u ⇒ s1 ≭ u
				cardinality: # s1 < # s2 ⇒ s1 ⊉ s2
			then
				Result := True
			end
		end

	is_comparable_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_comparable?
		do
			check
				reflexive: s1.is_comparable (s1)
				symmetric: s1.is_comparable (s2) ⇒ s2.is_comparable (s1)
				not_transitive: s1.is_comparable (s2) and s2.is_comparable (s3) ⇒ s1.is_comparable (s3) or not s1.is_comparable (s3)
			then
				Result := True
			end
		end

	is_not_comparable_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_comparable?
		do
			check
				u: attached current_universe as u
				definition: s1.is_not_comparable (s2) = (
							(u |∃ agent anded (agent s1.has, agent s2.does_not_have, ?))
							and
							(u |∃ agent anded (agent s2.has, agent s1.does_not_have, ?))
						)
				lesser_definition: s1.is_not_comparable (s2) = (
							(s1 |∃ agent s2.does_not_have) and (s2 |∃ agent s1.does_not_have)
						)
				by_inclusion: s1.is_not_comparable (s2) = (s1 ⊈ s2 and s2 ⊈ s1)
--				proper_symmetric_difference: s1.is_not_comparable (s2) ⇒ (s1 ⊖ s2) ≭ o
				irreflexive: not s1.is_not_comparable (s1)
				symmetric: s1.is_not_comparable (s2) ⇒ s2.is_not_comparable (s1)
				not_transitive: s1.is_not_comparable (s2) and s2.is_not_comparable (s3) ⇒ s1.is_not_comparable (s3) or not s1.is_not_comparable (s3)
			then
				Result := True
			end
		end

	is_strict_subset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_strict_subset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊂ s2 = (
							(u |∀ agent implied (agent s1.has, agent s2.has, ?)) and
							(u |∃ agent anded (agent s2.has, agent s1.does_not_have, ?))
						)
				lesser_definition: s1 ⊂ s2 = ((s1 |∀ agent s2.has) and (s2 |∃ agent s1.does_not_have))
				by_inclusion: s1 ⊂ s2 = (s1 ⊆ s2 and s2 ⊈ s1)
				irreflexive: not (s1 ⊂ s1)
				transitive: s1 ⊂ s2 and s2 ⊂ s3 ⇒ s1 ⊂ s3
				asymmetric: s1 ⊂ s2 ⇒ not (s2 ⊂ s1)
				proper_difference: s1 ⊂ s2 ⇒ (s2 ∖ s1) ≭ o
				cardinality: s1 ⊂ s2 ⇒ # s1 < # s2
			then
				Result := True
			end
		end

	is_not_strict_subset_ok (s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_strict_subset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊄ s2 = (
							(u |∃ agent anded (agent s1.has, agent s2.does_not_have, ?)) or
							(u |∀ agent implied (agent s2.has, agent s1.has, ?))
						)
				lesser_definition: s1 ⊄ s2 = ((s1 |∃ agent s2.does_not_have) or (s2 |∀ agent s1.has))
				by_inclusion: s1 ⊄ s2 = (s1 ⊈ s2 or s2 ⊆ s1)
				reflexive: s1 ⊄ s1
				cardinality: # s1 ≥ # s2 ⇒ s1 ⊄ s2
			then
				Result := True
			end
		end

	is_strict_superset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_strict_superset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊃ s2 = (
							(u |∀ agent implied (agent s2.has, agent s1.has, ?)) and
							(u |∃ agent anded (agent s1.has, agent s2.does_not_have, ?))
						)
				lesser_definition: s1 ⊃ s2 = ((s1 |∃ agent s2.does_not_have) and (s2 |∀ agent s1.has))
				by_inclusion: s1 ⊃ s2 = (s1 ⊇ s2 and s2 ⊉ s1)
				irreflexive: not (s1 ⊃ s1)
				transitive: s1 ⊃ s2 and s2 ⊃ s3 ⇒ s1 ⊃ s3
				asymmetric: s1 ⊃ s2 ⇒ not (s2 ⊃ s1)
				proper_difference: s1 ⊃ s2 ⇒ (s1 ∖ s2) ≭ o
				cardinality: s1 ⊃ s2 ⇒ # s1 > # s2
			then
				Result := True
			end
		end

	is_not_strict_superset_ok (s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_strict_superset?
		do
			check
				u: attached current_universe as u
				definition: s1 ⊅ s2 = (
							(u |∃ agent anded (agent s2.has, agent s1.does_not_have, ?)) or
							(u |∀ agent implied (agent s1.has, agent s2.has, ?))
						)
				lesser_definition: s1 ⊅ s2 = ((s1 |∀ agent s2.has) or (s2 |∃ agent s1.does_not_have))
				by_inclusion: s1 ⊅ s2 = (s1 ⊉ s2 or s1 ≍ s2)
				reflexive: s1 ⊅ s1
				cardinality: # s1 ≤ # s2 ⇒ s1 ⊅ s2
			then
				Result := True
			end
		end

	is_trivial_subset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_trivial_subset?
		do
			check
				reflexive: s1.is_trivial_subset (s1)
				antisymmetric: s1.is_trivial_subset (s2) and s2.is_trivial_subset (s1) ⇒ s1 ≍ s2
				transitive: s1.is_trivial_subset (s2) and s2.is_trivial_subset (s3) ⇒ s1.is_trivial_subset (s3)
			then
				Result := True
			end
		end

	is_trivial_superset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_trivial_superset?
		do
			check
				definition: s1.is_trivial_superset (s2) = (s1 ≍ s2 or s2 ≍ o)
				reflexive: s1.is_trivial_superset (s1)
				antisymmetric: s1.is_trivial_superset (s2) and s2.is_trivial_superset (s1) ⇒ s1 ≍ s2
				transitive: s1.is_trivial_superset (s2) and s2.is_trivial_superset (s3) ⇒ s1.is_trivial_superset (s3)
			then
				Result := True
			end
		end

	is_proper_subset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_proper_subset?
		do
			check
				definition: s1.is_proper_subset (s2) = (s1 ⊆ s2 and not s1.is_trivial_subset (s2))
				irreflexive: not s1.is_proper_subset (s1)
				asymmetric: s1.is_proper_subset (s2) ⇒ not s2.is_proper_subset (s1)
				transitive: s1.is_proper_subset (s2) and s2.is_proper_subset (s3) ⇒ s1.is_proper_subset (s3)
			then
				Result := True
			end
		end

	is_proper_superset_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_proper_superset?
		do
			check
				definition: s1.is_proper_superset (s2) = (s1 ⊇ s2 and not s1.is_trivial_superset (s2))
				irreflexive: not s1.is_proper_superset (s1)
				asymmetric: s1.is_proper_superset (s2) ⇒ not s2.is_proper_superset (s1)
				transitive: s1.is_proper_superset (s2) and s2.is_proper_superset (s3) ⇒ s1.is_proper_superset (s3)
			then
				Result := True
			end
		end

	is_disjoint_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_disjoint?
		do
			check
				definition: s1.is_disjoint (s2) = s1 |∄ agent s2.has
				quasi_irreflexive: s1 ≭ o ⇒ not s1.is_disjoint (s1)
				symmetric: s1.is_disjoint (s2) = s2.is_disjoint (s1)
				not_transitive: s1.is_disjoint (s2) and s2.is_disjoint (s3) ⇒ s1.is_disjoint (s3) or not s1.is_disjoint (s3)
				left_disjoint: o.is_disjoint (s2)
				right_disjoint: s1.is_disjoint (o)
			then
				Result := True
			end
		end

	intersects_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.intersects?
		do
			check
				definition: s1.intersects (s2) = (s1 ∩ s2) ≭ o
				by_existence: s1.intersects (s2) = (s1 |∃ agent s2.has)
				quasi_reflexive: s1 ≭ o ⇒ s1.intersects (s1)
				symmetric: s1.intersects (s2) = s2.intersects (s1)
				not_transitive: s1.intersects (s2) and s2.intersects (s3) ⇒ s1.intersects (s3) or not s1.intersects (s3)
			then
				Result := True
			end
		end

feature -- Properties (Quantifier)

	exists_ok (s: STS_SET [A, EQ]; p: PREDICATE [A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.exists?
		do
			check
				definition: (s |∃ p) = not (s |∀ agent negated (p, ?))
				by_filtering: (s |∃ p) = (s | p) ≭ o
			then
				Result := True
			end
		end

	does_not_exist_ok (s: STS_SET [A, EQ]; p: PREDICATE [A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.does_not_exist?
		do
			check
				definition: s |∄ p = (s |∀ agent negated (p, ?))
				by_filtering: s |∄ p = (s | p) ≍ o
			then
				Result := True
			end
		end

	exists_unique_ok (s: STS_SET [A, EQ]; p: PREDICATE [A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.exists_unique?
		do
			check
				definition: s |∃! p = (s |∃ agent (ia_s: STS_SET [A, EQ] ia_p: PREDICATE [A] x: A): BOOLEAN
								do
									Result := ia_s |∀ agent ia_s.iff (ia_p, agent ia_s.equality_holds (?, x), ?)
								end (s, p, ?))
				by_inequality: s |∃! p = (s |∃ agent (ia_s: STS_SET [A, EQ] ia_p: PREDICATE [A] x: A): BOOLEAN
								do
									Result := ia_p (x) and ia_s |∄ agent anded (ia_p, agent negated (agent ia_s.equality_holds (?, x), ?), ?)
								end (s, p, ?))
				by_equality: s |∃! p = (s |∃ agent (ia_s: STS_SET [A, EQ] ia_p: PREDICATE [A] x: A): BOOLEAN
								do
									Result := ia_p (x) and (ia_s |∀ agent implied (ia_p, agent ia_s.equality_holds (?, x), ?))
								end (s, p, ?))
				by_pairing: s |∃! p = (
							(s |∃ p) and (s.for_all_pairs (agent pair_implied (agent binary_anded (p, ?, p, ?), agent s.equality_holds, ?, ?)))
						)
				by_cardinality: s |∃! p = (# (s | p) = 1)
			then
				Result := True
			end
		end

	exists_pair_ok (s: STS_SET [A, EQ]; p: PREDICATE [A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.exists_pair?
		do
			check
				definition: s.exists_pair (p) = not s.for_all_pairs (agent pair_negated (p, ?, ?))
--				by_filtering: s.exists_pair (p) = ((× s).filtered_xy (p)) ≭ (× o)
			then
				Result := True
			end
		end

	does_not_exist_pair_ok (s: STS_SET [A, EQ]; p: PREDICATE [A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.does_not_exist_pair?
		do
			check
				definition: s.does_not_exist_pair (p) = s.for_all_pairs (agent pair_negated (p, ?, ?))
--				by_filtering: s.does_not_exist_pair (p) = ((× s).filtered_xy (p)) ≍ (× o)
			then
				Result := True
			end
		end

	exists_distinct_pair_ok (s: STS_SET [A, EQ]; p: PREDICATE [A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.exists_distinct_pair?
		do
			check
				definition: s.exists_distinct_pair (p) = not s.for_all_distinct_pairs (agent pair_negated (p, ?, ?))
--				by_filtering: s.exists_distinct_pair (p) = (× s).filtered_xy (p) ⊈ ∆ s
--				by_square: s.exists_distinct_pair (p) = (× s).exist_xy (agent pair_anded (p, agent equality_does_not_hold, ?, ?))
				by_inequality: s.exists_distinct_pair (p) = s.exists_pair (agent pair_anded (p, agent pair_negated (agent s.equality_holds, ?, ?), ?, ?))
			then
				Result := True
			end
		end

	for_all_ok (s: STS_SET [A, EQ]; p: PREDICATE [A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.for_all?
		do
			check
				definition: (s |∀ p) = (s |∄ agent negated (p, ?))
				by_filtering: (s |∀ p) = (s | p) ≍ s
			then
				Result := True
			end
		end

	for_all_pairs_ok (s: STS_SET [A, EQ]; p: PREDICATE [A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.for_all_pairs?
		do
			check
				definition: s.for_all_pairs (p) = s.does_not_exist_pair (agent pair_negated (p, ?, ?))
--				by_filtering: s.for_all_pairs (p) = ((× s).filtered_xy (p) ≍ (× s))
			then
				Result := True
			end
		end

	for_all_distinct_pairs_ok (s: STS_SET [A, EQ]; p: PREDICATE [A, A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.for_all_distinct_pairs?
		do
			check
				definition: s.for_all_distinct_pairs (p) = not s.exists_distinct_pair (agent pair_negated (p, ?, ?))
--				by_filtering: s.for_all_distinct_pairs (p) = ((× s).filtered_xy (agent pair_negated(p, ?, ?)) ⊆ ∆ s)
--				by_square: s.for_all_distinct_pairs (p) = (× s).for_all_xy (agent pair_implied (agent pair_negated (p, ?, ?), agent s.equality_holds, ?, ?))
				by_equality: s.for_all_distinct_pairs (p) = s.for_all_pairs (agent pair_implied (agent pair_negated (p, ?, ?), agent s.equality_holds, ?, ?))
			then
				Result := True
			end
		end

feature -- Properties (Operation)

	subsets_ok (a: A; s0, s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.subsets?
		do
--			Result := powersets_properties_ok (a, s0, s1, s2, s1.subsets, s2.subsets)
		end

	powerset_ok (a: A; s0, s1, s2: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.powerset?
		do
--			Result := powersets_properties_ok (a, s0, s1, s2, s1.powerset, s2.powerset)
		end

--	powersets_properties_ok (a: A; s0, s1, s2: STS_SET [A, EQ]; s1_ps, s2_ps: STS_SUBSET_FAMILY [A, EQ]): BOOLEAN
--			-- Do the properties verified within set theory hold for the powersets of `s1' and `s2'?
--		require
--			s1_powerset: s1_ps ≍ s1.powerset
--			s2_powerset: s2_ps ≍ s2.powerset
--		do
--			check
--				u: attached current_universe as u
--				u_ps_card: attached (2 ^ # u) as u_ps_card
--				checked_u_ps: attached {ISE_RUNTIME}.check_assert (u_ps_card ≤ max_asserted_subsets) as checked_u_ps
--					definition: u_ps_card ≤ max_subsets ⇒ s1_ps ≍ (u.powerset | agent s1.is_superset)
--				checked_u_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_u_ps)
--				s1_ps_card: attached (2 ^ # s1) as s1_ps_card
--				checked_s1_ps: attached {ISE_RUNTIME}.check_assert (s1_ps_card ≤ max_asserted_subsets) as checked_s1_ps
--					s1_ps_card ≤ max_subsets ⇒ (
--						agent (ia_a: A; ia_s0, ia_s1: STS_SET [A, EQ]; ia_s1_ps: STS_SUBSET_FAMILY [A, EQ]): BOOLEAN
--							do
--								check
--									by_reducing_without: ia_s1_ps ≍ element_to_sets.set_reduction (
--										ia_s1, ia_s1.as_singleton, agent (acc: STS_SET [STS_SET [A, EQ], STS_SET_EQUALITY [A, EQ]]; x: A):
--											STS_SET [STS_SET [A, EQ], STS_SET_EQUALITY [A, EQ]]
--											do
--												Result := acc ∪ (acc ↦ agent {STS_SET [A, EQ]}.without (x))
--											end
--										)
--									has_base_set: ia_s1 ∈ ia_s1_ps
--									includes_lesser_powerset: ia_s1.others.powerset ⊆ ia_s1_ps
--									includes_extended_powerset: not ia_s1.is_empty ⇒
--										(ia_s1.others.powerset ↦ agent {STS_SET [A, EQ]}.with (ia_s1.any)) ⊆ ia_s1_ps
--									cardinality: # ia_s1_ps = 2 ^ (# ia_s1)
--									subset_membership: (ia_s0 ⊆ ia_s1) = ia_s0 ∈ ia_s1_ps
--									induced_membership: ia_s1 ∋ ia_a = singleton (ia_a) ∈ ia_s1_ps
--									has_empty_set: o ∈ ia_s1_ps
--								then
--									Result := True
--								end
--							end
--						).item (a, s0, s1, s1_ps)
--					s2_ps_card: attached (2 ^ # s2) as s2_ps_card
--					checked_s2_ps: attached {ISE_RUNTIME}.check_assert ((s1_ps_card ∨ s2_ps_card) ≤ max_asserted_subsets) as checked_s2_ps
--						(s1_ps_card ∨ s2_ps_card) ≤ max_subsets ⇒ (
--							agent (ia_s1, ia_s2: STS_SET [A, EQ]; ia_s1_ps, ia_s2_ps: STS_SUBSET_FAMILY [A, EQ]): BOOLEAN
--								do
--									check
--										induced_inclusion: (ia_s1 ⊆ ia_s2) = (ia_s1_ps ⊆ ia_s2_ps)
--										induced_equality: ia_s1 ≍ ia_s2 = ia_s1_ps ≍ ia_s2_ps
--										disjointness_consequence: (ia_s1 ∩ ia_s2) ≍ o ⇒ (ia_s1_ps ∩ ia_s2_ps) ≍ o.as_singleton
--										induced_intersection: (ia_s1 ∩ ia_s2).powerset ≍ (ia_s1_ps ∩ ia_s2_ps)
--										quasi_included_difference: (ia_s1 ∖ ia_s2).powerset ⊆ ((ia_s1_ps ∖ ia_s2_ps) ∪ o.as_singleton)
--									then
--										Result := True
--									end
--								end
--							).item (s1, s2, s1_ps, s2_ps)
--						s1_uni_s2_ps_card: attached (2 ^ # (s1 ∪ s2)) as s1_uni_s2_ps_card
--						checked_s1_uni_s2_ps: attached {ISE_RUNTIME}.check_assert
--							(s1_uni_s2_ps_card ≤ max_asserted_subsets) as checked_s1_uni_s2_ps
--							included_union: s1_uni_s2_ps_card ≤ max_subsets ⇒ (s1_ps ∪ s2_ps) ⊆ (s1 ∪ s2).powerset
--						checked_s1_uni_s2_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_s1_uni_s2_ps)
--					checked_s2_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_s2_ps)
--				checked_s1_ps_restored: attached {ISE_RUNTIME}.check_assert (checked_s1_ps)
--			then
--				Result := True
--			end
--		end

--	trivial_subsets_ok (s: STS_SET [A, EQ]): BOOLEAN
--			-- Do the properties verified within set theory hold for {STS_SET}.trivial_subsets?
--		do
--			if s.is_empty then
--				check
--					one_subset: # s.trivial_subsets = 1
--				then
--				end
--			else
--				check
--					two_subsets: # s.trivial_subsets = 2
--				then
--				end
--			end
--			Result := True
--		end

--	proper_subsets_ok (s: STS_SET [A, EQ]): BOOLEAN
--			-- Do the properties verified within set theory hold for {STS_SET}.proper_subsets?
--		do
--			if (2 ^ # s) ≤ max_subsets then
--				check
--					no_proper_subset: # s < 2 ⇒ # s.proper_subsets = 0
--					some_proper_subset: # s ≥ 2 ⇒ # s.proper_subsets = 2 ^ (# s) - 2
--				then
--				end
--			end
--			Result := True
--		end

	filtered_ok (s: STS_SET [A, EQ]; p: PREDICATE [A]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.filtered?
		do
			check
				u: attached current_universe as u
				definition: s | p ≍ (u | agent anded (p, agent s.has, ?))
				by_intersection: s | p ≍ (s ∩ (u | p))
				subset: s | p ⊆ s
				only_compliant_elements: (s | p) |∀ p
				nothing_lost: (s ∖ (s | p)) |∄ p
			then
				Result := True
			end
		end

	complemented_ok (s1, s2, s3: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.complemented?
		local
			u: STS_SET [A, EQ]
		do
			u := current_universe
			if s1 ⊆ s2 then
				check
					definition: (s1 ∁ s2) ≍ (u | agent anded (agent s2.has, agent s1.does_not_have, ?))
					by_difference: (s1 ∁ s2) ≍ (s2 ∖ s1)
						--								by_reduction: (s1 ∁ s2) ≍ element_to_set.set_reduction (s1, s2, agent {STS_SET [A, EQ]}.without)
					disjoint: (s1 ∁ s2).is_disjoint (s1)
					is_subset_too: (s1 ∁ s2) ⊆ s2
					complementary: (s1 ∪ (s1 ∁ s2)) ≍ s2
					involutive: ((s1 ∁ s2) ∁ s2) ≍ s1
					inverted_inclusion: s3 ⊆ s2 ⇒ (s1 ⊆ s3 = ((s1 ∁ s2) ⊇ (s3 ∁ s2)))
				then
				end
			end
			check
				everything_includes_o: o ⊆ s1 -- {STS_SET}.is_subset definition
			end
			check
				full_complement: (o ∁ s1) ≍ s1
			then
			end
			check
				reflexive_inclusion: s1 ⊆ s1 -- {STS_SET}.is_subset definition
			end
			check
				empty_complement: (s1 ∁ s1) ≍ o
			then
			end
			check
				u_includes_o: o ⊆ u -- {STS_SET}.is_subset definition
			end
			check
				dual_of_o: (o ∁ u) ≍ u
			then
			end
			check
				u_includes_u: u ⊆ u -- {STS_SET}.is_subset definition
			end
			check
				dual_of_u: (u ∁ u) ≍ o
			then
			end
			check
					-- Universe includes everything.
				u_includes_s1: s1 ⊆ u
				u_includes_c_s1: (s1 ∁ u) ⊆ u
			end
			check
				absolutely_involutive: ((s1 ∁ u) ∁ u) ≍ s1
			then
			end
			check
				u_includes_s2: s2 ⊆ u -- Universe includes everything.
			end
			check
				dual_inclusion: s1 ⊆ s2 = ((s1 ∁ u) ⊇ (s2 ∁ u))
			then
				Result := True
			end
		end

	intersected_ok (a: A; s1, s2, s3, s4: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.intersected?
		local
			u: like current_universe
		do
			u := current_universe
			check
				definition: (s1 ∩ s2) ≍ (u | agent anded (agent s1.has, agent s2.has, ?))
				lesser_definition: (s1 ∩ s2) ≍ ((s1 ∪ s2) | agent anded (agent s1.has, agent s2.has, ?))
--				by_reduction: (s1 ∩ s2) ≍ transformer_to_set.set_reduction (
--					s1, o, agent (ia_s2, acc: STS_SET [A, EQ]; x: A): STS_SET [A, EQ]
--						do
--							if ia_s2 ∋ x then
--								Result := acc & x
--							else
--								Result := acc
--							end
--						end (s2, ?, ?)
--					)
--				by_alternate_reduction: (s1 ∩ s2) ≍ transformer_to_set.set_reduction (
--					s2, o, agent (ia_s1, acc: STS_SET [A, EQ]; x: A): STS_SET [A, EQ]
--						do
--							if ia_s1 ∋ x then
--								Result := acc & x
--							else
--								Result := acc
--							end
--						end (s1, ?, ?)
--					)
				right_filtered: (s1 ∩ s2) ≍ (s2 | agent s1.has)
				membership: (s1 ∩ s2) ∋ a = (s1 ∋ a and s2 ∋ a)
				is_subset_of_s1: (s1 ∩ s2) ⊆ s1
				is_subset_of_s2: (s1 ∩ s2) ⊆ s2
				keeps_subset: s1 ⊆ s2 = (s1 ∩ s2) ≍ s1
				subset: (s3 ⊆ s1 and s3 ⊆ s2) = (s3 ⊆ (s1 ∩ s2))
				superset: s1 ⊆ s3 and s2 ⊆ s3 ⇒ (s1 ∩ s2) ⊆ s3
				induced_inclusion: s1 ⊆ s2 ⇒ (s1 ∩ s3) ⊆ (s2 ∩ s3)
				subintersection: s1 ⊆ s2 and s3 ⊆ s4 ⇒ (s1 ∩ s3) ⊆ (s2 ∩ s4)
				absorption: (o ∩ s1) ≍ o
				identity: (s1 ∩ u) ≍ s1
			then
			end
			check
				u_includes_s1: s1 ⊆ u -- Universe includes everything.
			end
			check
				disjoint_complement: (s1 ∩ (s1 ∁ u)) ≍ o
				idempotent: (s1 ∩ s1) ≍ s1
				commutative: (s1 ∩ s2) ≍ (s2 ∩ s1)
				associative: ((s1 ∩ s2) ∩ s3) ≍ (s1 ∩ (s2 ∩ s3))
			then
			end
			check
				u_includes_s2: s2 ⊆ u -- Universe includes everything.
			end
			check
				with_complement_of_disjoint: (s1 ∩ s2) ≍ o ⇒ (s1 ∩ (s2 ∁ u)) ≍ s1
				inverted_inclusion: (s1 ∁ u) ⊆ (s2 ∁ u) = (s1 ∩ s2) ≍ s2
				induced_non_disjointness: (s1 ∩ s2) ≍ s1 and (s1 ∩ s3) ≭ o ⇒ (s2 ∩ s3) ≭ o
--				pair_equality: paired_sets (s1, s2) ≍ paired_sets (s3, s4) ⇒ (s1 ∩ s2) ≍ (s3 ∩ s4)
				by_union_and_complement: (s1 ∩ s2) ≍ (s1 ∩ ((s1 ∁ u) ∪ s2))
			then
				Result := united_and_intersected_ok (s1, s2, s3, s4)
			end
		end

	united_ok (a: A; s1, s2, s3, s4: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.united?
		local
			u: STS_SET [A, EQ]
		do
			u := current_universe
			check
				definition: (s1 ∪ s2) ≍ (u | agent u.ored (agent s1.has, agent s2.has, ?))
--				by_reduction: (s1 ∪ s2) ≍ transformer_to_set.set_reduction (s1, s2, agent {STS_SET [A, EQ]}.with)
--				by_alternate_reduction: (s1 ∪ s2) ≍ transformer_to_set.set_reduction (s2, s1, agent {STS_SET [A, EQ]}.with)
				membership: (s1 ∪ s2) ∋ a = (s1 ∋ a or s2 ∋ a)
				includes_s1: s1 ⊆ (s1 ∪ s2)
				includes_s2: s2 ⊆ (s1 ∪ s2)
				keeps_superset: s1 ⊆ s2 = ((s1 ∪ s2) ≍ s2)
				superset: (s1 ⊆ s3 and s2 ⊆ s3) = ((s1 ∪ s2) ⊆ s3)
				subset: s3 ⊆ s1 or s3 ⊆ s2 ⇒ s3 ⊆ (s1 ∪ s2)
				induced_inclusion: s1 ⊆ s2 ⇒ (s1 ∪ s3) ⊆ (s2 ∪ s3)
				subunion: s1 ⊆ s2 and s3 ⊆ s4 ⇒ (s1 ∪ s3) ⊆ (s2 ∪ s4)
			then
			end
			check
					-- Universe includes everything.
				u_includes_s1: s1 ⊆ u
				u_includes_s2: s2 ⊆ u
			end
			check
				inverted_inclusion: (s1 ∁ u) ⊆ (s2 ∁ u) = ((s1 ∪ s2) ≍ s1)
				identity: (o ∪ s1) ≍ s1
				absorption: (s1 ∪ u) ≍ u
				partitioned_universe: (s1 ∪ (s1 ∁ u)) ≍ u
				idempotent: (s1 ∪ s1) ≍ s1
				commutative: (s1 ∪ s2) ≍ (s2 ∪ s1)
				associative: ((s1 ∪ s2) ∪ s3) ≍ (s1 ∪ (s2 ∪ s3))
				universal_union: (s1 ∪ s2) ≍ u ⇒ (s1 ∁ u) ⊆ s2
				empty_union: (s1 ∪ s2) ≍ o = (s1 ≍ o and s2 ≍ o)
--				pair_equality: paired_sets (s1, s2) ≍ paired_sets (s3, s4) ⇒ (s1 ∪ s2) ≍ (s3 ∪ s4)
				by_intersection_and_complement: (s1 ∪ s2) ≍ (s1 ∪ ((s1 ∁ u) ∩ s2))
			then
				Result := united_and_intersected_ok (s1, s2, s3, s4)
			end
		end

	united_and_intersected_ok (s1, s2, s3, s4: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.united and {STS_SET}.intersected together?
		local
			u: like current_universe
		do
			u := current_universe
			check
				absorbed_union: (s1 ∩ (s1 ∪ s2)) ≍ s1
				absorbed_intersection: (s1 ∪ (s1 ∩ s2)) ≍ s1
				distributed_intersection: (s1 ∩ (s2 ∪ s3)) ≍ ((s1 ∩ s2) ∪ (s1 ∩ s3))
				distributed_union: (s1 ∪ (s2 ∩ s3)) ≍ ((s1 ∪ s2) ∩ (s1 ∪ s3))
			then
			end
			check
					-- Universe includes everything.
				u_includes_s1: s1 ⊆ u
				u_includes_s2: s2 ⊆ u
				u_includes_intersection: (s1 ∩ s2) ⊆ u
				u_includes_union: (s1 ∪ s2) ⊆ u
			end
			check
				de_morgan_intersection: ((s1 ∩ s2) ∁ u) ≍ ((s1 ∁ u) ∪ (s2 ∁ u))
				de_morgan_union: ((s1 ∪ s2) ∁ u) ≍ ((s1 ∁ u) ∩ (s2 ∁ u))
				successive_inclusion: (s1 ⊆ s2 and s2 ⊆ s3) = ((s1 ∪ s2) ≍ (s2 ∩ s3))
				equality: (s1 ∪ s2) ≍ (s1 ∩ s2) = (s1 ≍ s2)
				empty_intersection: (s1 ∩ s2) ≍ o ⇒ (s1 ∪ (s2 ∁ u)) ≍ (s2 ∁ u)
				intersecting_two_unions: ((s1 ∪ s2) ∩ (s3 ∪ s4)) ≍ ((s1 ∩ s3) ∪ (s1 ∩ s4) ∪ (s2 ∩ s3) ∪ (s2 ∩ s4))
				uniting_two_intersections: ((s1 ∩ s2) ∪ (s3 ∩ s4)) ≍ ((s1 ∪ s3) ∩ (s1 ∪ s4) ∩ (s2 ∪ s3) ∩ (s2 ∪ s4))
				union_cardinality: # (s1 ∪ s2) = # s1 + # s2 - # (s1 ∩ s2)
			then
				Result := True
			end
		end

	subtracted_ok (a: A; s1, s2, s3, s4, s5: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.subtracted?
		local
			u: like current_universe
		do
			u := current_universe
			check
				definition: (s1 ∖ s2) ≍ (u | agent anded (agent s1.has, agent s2.does_not_have, ?))
--				by_reduction: (s1 ∖ s2) ≍ transformer_to_set.set_reduction (s2, s1, agent {STS_SET [A, EQ]}.without)
				membership: (s1 ∖ s2) ∋ a = (s1 ∋ a and s2 ∌ a)
				is_subset: (s1 ∖ s2) ⊆ s1
				by_complement: s2 ⊆ s1 ⇒ (s1 ∖ s2) ≍ (s2 ∁ s1)
				by_intersection: s1 ⊆ s5 and s2 ⊆ s5 ⇒ (s1 ∖ s2) ≍ (s1 ∩ (s2 ∁ s5))
			then
			end
			check
				u_includes_s2: s2 ⊆ u -- Universe includes everything.
			end
			check
				by_absolute_complement: (s1 ∖ s2) ≍ (s1 ∩ (s2 ∁ u))
				subtract_o: (s1 ∖ o) ≍ s1
				subtract_from_o: (o ∖ s1) ≍ o
				subtract_u: (s1 ∖ u) ≍ o
			then
			end
			check
				u_includes_s1: s1 ⊆ u -- Universe includes everything.
			end
			check
				subtract_from_u: (u ∖ s1) ≍ (s1 ∁ u)
				self_difference: (s1 ∖ s1) ≍ o
				subtract_complement: (s1 ∖ (s1 ∁ u)) ≍ s1
			then
			end
			check
				u_includes_difference: (s1 ∖ s2) ⊆ u -- Universe includes everything.
			end
			check
				complemented_difference: ((s1 ∖ s2) ∁ u) ≍ ((s1 ∁ u) ∪ s2)
				reverted_difference: (s1 ∖ s2) ≍ ((s2 ∁ u) ∖ (s1 ∁ u))
				non_left_associative: ((s1 ∖ s2) ∖ s3) ≍ (s1 ∖ (s2 ∪ s3))
				non_right_associative: (s1 ∖ (s2 ∖ s3)) ≍ ((s1 ∖ s2) ∪ (s1 ∩ s3))
				no_union_distribution: (s1 ∪ (s2 ∖ s3)) ≍ ((s1 ∪ s2) ∖ (s3 ∖ s1))
				intersection_distributed: (s1 ∩ (s2 ∖ s3)) ≍ ((s1 ∩ s2) ∖ (s1 ∩ s3))
				no_left_distribution_over_union: (s1 ∖ (s2 ∪ s3)) ≍ ((s1 ∖ s2) ∩ (s1 ∖ s3))
				no_left_distribution_over_intersection: (s1 ∖ (s2 ∩ s3)) ≍ ((s1 ∖ s2) ∪ (s1 ∖ s3))
				right_distribution_over_union: ((s1 ∪ s2) ∖ s3) ≍ ((s1 ∖ s3) ∪ (s2 ∖ s3))
				right_distribution_over_intersection: ((s1 ∩ s2) ∖ s3) ≍ ((s1 ∖ s3) ∩ (s2 ∖ s3))
				subtracted_difference: (s1 ∖ (s1 ∖ s2)) ≍ (s1 ∩ s2)
				subtracted_from_difference: ((s1 ∖ s2) ∖ s2) ≍ (s1 ∖ s2)
				subset_of_union: (s1 ∖ s2) ⊆ (s1 ∪ s2)
				equality: s1 ≍ s2 = (s1 ∖ s2) ≍ (s2 ∖ s1)
				inclusion: s1 ⊆ s2 = ((s1 ∖ s2) ≍ o)
				disjointness: (s1 ∩ s2) ≍ o = (s1 ∖ s2) ≍ s1
				mutual_complement: s1 ⊆ s2 and s3 ≍ (s2 ∖ s1) ⇒ s1 ≍ (s2 ∖ s3)
				disjoint_complement: (s1 ∩ s2) ≍ o and (s1 ∪ s2) ≍ s3 ⇒ s1 ≍ (s3 ∖ s2)
				disjoint_to_right: ((s1 ∖ s2) ∩ s2) ≍ o
				united_to_right: ((s1 ∖ s2) ∪ s2) ≍ (s1 ∪ s2)
				right_subtracted_from_union: ((s1 ∪ s2) ∖ s2) ≍ (s1 ∖ s2)
				right_subtracted_from_intersection: ((s1 ∩ s2) ∖ s2) ≍ o
				left_minus_intersection: (s1 ∖ (s1 ∩ s2)) ≍ (s1 ∖ s2)
				left_intersected_with_difference: (s1 ∩ (s1 ∖ s2)) ≍ (s1 ∖ s2)
				disjoint_intersection_and_difference: ((s1 ∩ s2) ∩ (s1 ∖ s2)) ≍ o
				disjoint_mutual_differences: ((s1 ∖ s2) ∩ (s2 ∖ s1)) ≍ o
				symmetric_difference: ((s1 ∖ s2) ∪ (s2 ∖ s1)) ≍ ((s1 ∪ s2) ∖ (s1 ∩ s2))
				intersected_differences: ((s1 ∖ s2) ∩ (s3 ∖ s4)) ≍ ((s1 ∩ s3) ∖ (s2 ∪ s4))
			then
				Result := True
			end
		end

feature -- Factory

	singleton (a: A): STS_SET [A, EQ]
			-- Singleton in the form {`a'}
			-- TODO: DRY
		do
			Result := o.singleton (a)
		ensure
			definition: Result ≍ o.singleton (a)
		end

--	paired_sets (s1, s2: STS_SET [A, EQ]): STS_SET [STS_SET [A, EQ], STS_SET_EQUALITY [A, EQ]]
--			-- The sets `s1' and `s2' put into a set, i.e. {`s1', `s2'}
--		do
--			Result := s1.as_singleton & s2
--		ensure
--			definition: Result ≍ (s1.as_singleton & s2)
--		end

feature -- Predicate

	negated (p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical negation of `p' (`x'), i.e. is `p' (`x') false?
			-- TODO: Pull it up?
		do
			Result := not p (x)
		ensure
			class
			definition: Result = not p (x)
		end

	anded (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Do `p1' (`x') and `p2' (`x') hold?
			-- TODO: Pull it up?
		do
			Result := p1 (x) and p2 (x)
		ensure
			class
			definition: Result = (p1 (x) and p2 (x))
		end

	implied (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- If `p1' (`x') holds, does `p2' (`x') hold too, i.e. does `p1' (`x') imply `p2' (`x')?
			-- TODO: Pull it up?
		do
			Result := p1 (x) ⇒ p2 (x)
		ensure
			class
			definition: Result = (p1 (x) ⇒ p2 (x))
		end

	pair_negated (p: PREDICATE [A, A]; x, y: A): BOOLEAN
			-- Logical negation of `p' (`x', `y'), i.e. is `p' (`x', `y') false?
			-- TODO: Pull it up?
		do
			Result := not p (x, y)
		ensure
			class
			definition: Result = not p (x, y)
		end

	pair_anded (p1, p2: PREDICATE [A, A]; x, y: A): BOOLEAN
			-- Do `p1' (`x', `y') and `p2' (`x', `y') hold?
			-- TODO: Pull it up?
		do
			Result := p1 (x, y) and p2 (x, y)
		ensure
			class
			definition: Result = (p1 (x, y) and p2 (x, y))
		end

	pair_implied (p1, p2: PREDICATE [A, A]; x, y: A): BOOLEAN
			-- If `p1' (`x', `y') holds, does `p2' (`x', `y') hold too, i.e. does `p1' (`x', `y') imply `p2' (`x', `y')?
			-- TODO: Pull it up?
		do
			Result := p1 (x, y) ⇒ p2 (x, y)
		ensure
			class
			definition: Result = (p1 (x, y) ⇒ p2 (x, y))
		end

	binary_anded (p: PREDICATE [A]; x: A; q: PREDICATE [A]; y: A): BOOLEAN
			-- Does `p' (`x') and `q' (`y') hold?
			-- TODO: Pull it up?
		do
			Result := p (x) and q (y)
		ensure
			class
			definition: Result = (p (x) and q (y))
		end

feature {NONE} -- Anchor

	o_anchor: STS_SET [A, EQ]
			-- Anchor for `o'
		do
			Result := o
		end

	universe_anchor: STS_SET [A, EQ]
			-- Anchor for `current_universe'
		do
			Result := current_universe
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
