note
	description: "[
		Element that models a mathematical set.
		Notice that Eiffel Base has a {SET} class, that was renamed to {EB_SET} in order to not clash with this one, that has a more
		fundamental nature, hence the choice of keeping current's name instead of Eiffel Base's one.
		]"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET [A, EQ -> EQUALITY [A]]

inherit
	ELEMENT

feature -- Primitive

	is_empty: BOOLEAN
			-- Does current set have no element?
		deferred
		end

	any: A
			-- An arbitrary element in current set
			-- NOTICE: Two equal set may have different `any'; even the same set is free to return different `any' at different times. Please see {SET}.equals.
		require
			is_not_empty: not is_empty
		deferred
		end

	others: like subset_anchor
			-- Set that has only and all the elements in current set but `any'
			--| NOTICE: There is no precondition to `others'; if current set is empty, `others' is empty too, as stated in {SET} invariant.
		deferred
		end

	eq: EQ
			-- Rule for testing equality between elements in current set
			--| Notice that the type of `eq' is hard-wired as a generic parameter. Though it is not very flexible, the alternative would be to guard with
			--| preconditions every feature where two sets are somehow compared, in order to check whether their current equalities are equivalent, and this
			--| would be rather cumbersome. Making the equality part of the set type guarantees that only compatible sets are compared at any time, with no
			--| need for preconditions.
		deferred
		end

feature -- Membership

	has alias "∋" (a: A): BOOLEAN
			-- Is `a' an element in current set?
		do
			Result := Current |∃ agent equality_holds (a, ?)
		ensure
			definition: Result = (Current |∃ agent equality_holds (a, ?))
		end

	does_not_have alias "∌" (a: A): BOOLEAN
			-- Does not current set have `a'?
		do
			Result := not (Current ∋ a)
		ensure
			definition: Result = not (Current ∋ a)
		end

feature -- Construction

	with alias "&" (a: A): like superset_anchor
			-- Every element in current set, together with `a'.
		deferred
		ensure
			has_a: Result ∋ a
			nothing_lost: Current |∀ agent Result.has
			nothing_else: Result |∀ agent ored (agent has, agent equality_holds (a, ?), ?)
		end

feature -- Quantifier

	exists alias "|∃" (p: PREDICATE [A]): BOOLEAN
			-- Existential quantifier: does `p' hold for some element in current set?
			--| Notice that Eiffel has its own quantifiers, e.g. ∃ c: s ¦ some_condition (c). But they require that s be a descendant of ITERABLE, and a key idea
			--| of set_theory is to rely as least as possible upon EiffelBase or any other library, since it should be able to annotate and model those libraries.
			--| Hence the somewhat awkward syntax of set_theory quantifiers, since they cannot benefit from Eiffel iteration mechanism.
		do
			Result := transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		ensure
			definition: Result = transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		end

	for_all alias "|∀" (p: PREDICATE [A]): BOOLEAN
			-- Universal quantifier: does `p' hold for every element in current set?
			--| NOTICE: See comments at `exists' header.
		do
			Result := transformer_to_boolean.set_reduction (Current, True, agent cumulative_conjunction (?, p, ?))
		ensure
			definition: Result = transformer_to_boolean.set_reduction (Current, True, agent cumulative_conjunction (?, p, ?))
		end

feature -- Factory

	o,
	empty_set: like subset_anchor
			-- Set with no element, i.e. {} or ∅.
		deferred
		ensure
			definition: Result.is_empty
		end

	singleton (a: A): like set_anchor
			-- Set that has `a' as its sole element, i.e. {`a'}.
		deferred
		ensure
			has_a: Result ∋ a
--			nothing_else: Result.is_singleton
		end

feature -- Predicate

	equality_holds (x1, x2: A): BOOLEAN
			-- Does `eq' (`x1', `x2') hold?
			-- NOTICE: Please see the comment at the header of `ored'.
		do
			Result := eq (x1, x2)
		ensure
			definition: Result = eq (x1, x2)
		end

	ored (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Does `p1' (`x') or `p2' (`x') hold?
			--| The need for such a feature lies in the fact that the Contract view of EiffelStudio does not show the body of an inline agent. Hence e.g. the
			--| post-condition clause of `united' whose tag is nothing_else cannot read
			--| 	Result |∀ agent (ia_s: STS_SET [A, EQ]; ia_x: A): BOOLEAN
			--| 		do
			--| 			Result := Current ∋ ia_x or ia_s ∋ ia_x
			--| 		end (s, ?)
			--| as would be more straightfoward.			
		do
			Result := p1 (x) or p2 (x)
		ensure
			class
			definition: Result = (p1 (x) or p2 (x))
		end

feature -- Reduction

	cumulative_disjunction (acc: BOOLEAN; p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical disjunction of `acc' and `p' (`x'), i.e. `acc' or `p' (`x').
			-- NOTICE: Please see the comment at the header of `ored'.
		do
			Result := acc or p (x)
		ensure
			class
			definition: Result = (acc or p (x))
		end

	cumulative_conjunction (acc: BOOLEAN; p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical conjunction of `acc' and `p' (`x'), i.e. `acc' and `p' (`x').
			-- NOTICE: Please see the comment at the header of `ored'.
		do
			Result := acc and p (x)
		ensure
			class
			definition: Result = (acc and p (x))
		end

feature -- Transformer

	transformer_to_boolean: TRANSFORMER [A, BOOLEAN, --EQ,
	OBJECT_EQUALITY [BOOLEAN]]
			-- Transformer of objects whose types derive from {A} to objects whose types derive from {BOOLEAN}
		deferred
		end

feature -- Anchor

	set_anchor: SET [A, EQ]
			-- Anchor for sets like current one
		do
			Result := Current
		end

	subset_anchor: SET [A, EQ]
			-- Anchor for subsets of current set
		do
			Result := Current
		end

	superset_anchor: SET [A, EQ]
			-- Anchor for supersets of current set
		do
			Result := Current
		end

invariant
	consistent_emptiness: is_empty ⇒ others.is_empty
--	no_repetition: not is_empty ⇒ others ∌ any -- TODO: Uncomment.

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
