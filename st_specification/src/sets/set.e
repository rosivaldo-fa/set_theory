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
		rename
			is_in as element_is_in,
			is_not_in as element_is_not_in
		end

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

	is_in alias "∈" (s: SET [SET [A, EQ], EQUALITY [SET [A, EQ]]]): BOOLEAN
			-- Does `s` have current set?
		do
			Result := s ∋ Current
		ensure
			definition: Result = s ∋ Current
		end

	is_not_in alias "∉" (s: SET [SET [A, EQ], EQUALITY [SET [A, EQ]]]): BOOLEAN
			-- Is not current set in `s'?
		do
			Result := not (Current ∈ s)
		ensure
			definition: Result = not (Current ∈ s)
		end

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

	without alias "/" (a: A): like subset_anchor
			-- Every element in current set but `a'
		deferred
		ensure
			does_not_have_a: Result ∌ a
			nothing_lost: Current |∀ agent xored (agent Result.has, agent equality_holds (a, ?), ?)
			nothing_else: Result |∀ agent has
		end

feature -- Quality

	is_singleton: BOOLEAN
			-- Does current set have exactly one element?
		do
			Result := not is_empty and others.is_empty
		ensure
			definition: Result = (not is_empty and others.is_empty)
		end

feature -- Measurement

	cardinality alias "#": like natural_anchor
			-- Number of elements in current set
		do
			Result := transformer_to_natural.set_reduction (Current, 0, agent cumulative_successor)
		ensure
			definition: Result = transformer_to_natural.set_reduction (Current, 0, agent cumulative_successor)
		end

feature -- Comparison

	equals alias "≍" (s: SET [A, EQ]): BOOLEAN
			-- Do current set and `s' have exactly the same elements?
			--| NOTICE: As expected, the order of the elements within the two sets is irrelevant, as are the types of the
			--| sets themselves; in order to be regarded equal, sets just must have the same elements under the same
			--| equality. By the way, redefining `is_equal' is not an option, since `is_equal' post-conditions require that
			--| `s' is like `Current', and two sets must be comparable according to the types of their elements and of their
			--| equalities only, not by the type of the sets temselves.
		do
			Result := (Current |∀ agent s.has) and (s |∀ agent has)
		ensure
			definition: Result = ((Current |∀ agent s.has) and (s |∀ agent has))
		end

	unequals alias "≭" (s: SET [A, EQ]): BOOLEAN
			-- Does not current set equal `s'?
		do
			Result := not (Current ≍ s)
		ensure
			definition: Result = not (Current ≍ s)
		end

	is_subset alias "⊆" (s: SET [A, EQ]): BOOLEAN
			-- Does `s' include current set, i.e. does `s' have every element in current set?
		do
			Result := Current |∀ agent s.has
		ensure
			definition: Result = (Current |∀ agent s.has)
		end

	is_not_subset alias "⊈" (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a subset of `s'?
		do
			Result := not (Current ⊆ s)
		ensure
			definition: Result = not (Current ⊆ s)
		end

	is_superset alias "⊇" (s: SET [A, EQ]): BOOLEAN
			-- Does current set include `s'?
		do
			Result := s ⊆ Current
		ensure
			definition: Result = (s ⊆ Current)
		end

	is_not_superset alias "⊉" (s: SET [A, EQ]): BOOLEAN
			-- Does not current set include `s'?
		do
			Result := not (Current ⊇ s)
		ensure
			definition: Result = not (Current ⊇ s)
		end

	is_comparable (s: SET [A, EQ]): BOOLEAN
			-- Is current set a subset or a superset of `s'?
		do
			Result := Current ⊆ s or s ⊆ Current
		ensure
			definition: Result = (Current ⊆ s or s ⊆ Current)
		end

	is_not_comparable (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a subset or a superset of `s'?
		do
			Result := not is_comparable (s)
		ensure
			definition: Result = not is_comparable (s)
		end

	is_strict_subset alias "⊂" (s: SET [A, EQ]): BOOLEAN
			-- Does `s' include current set and are both sets unequal?
		do
			Result := Current ⊆ s and Current ≭ s
		ensure
			definition: Result = (Current ⊆ s and Current ≭ s)
		end

	is_not_strict_subset alias "⊄" (s: SET [A, EQ]): BOOLEAN
			-- Is not current set a strict subset of `s'?
		do
			Result := not (Current ⊂ s)
		ensure
			definition: Result = not (Current ⊂ s)
		end

	is_strict_superset alias "⊃" (s: SET [A, EQ]): BOOLEAN
			-- Does current set include `s' strictly?
		do
			Result := s ⊂ Current
		ensure
			definition: Result = (s ⊂ Current)
		end

feature -- Quantifier

	exists alias "|∃" (p: PREDICATE [A]): BOOLEAN
			-- Existential quantifier: does `p' hold for some element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
		do
			Result := transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		ensure
			definition: Result = transformer_to_boolean.set_reduction (Current, False, agent cumulative_disjunction (?, p, ?))
		end

	for_all alias "|∀" (p: PREDICATE [A]): BOOLEAN
			-- Universal quantifier: does `p' hold for every element in current set?
		note
			EIS: "name=Quantifiers", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#quantifiers", "tag=operator, syntax"
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
			nothing_else: Result.is_singleton
		end

feature -- Predicate

	equality_holds (x1, x2: A): BOOLEAN
			-- Does `eq' (`x1', `x2') hold?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := eq (x1, x2)
		ensure
			definition: Result = eq (x1, x2)
		end

	ored (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Does `p1' (`x') or `p2' (`x') hold?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) or p2 (x)
		ensure
			class
			definition: Result = (p1 (x) or p2 (x))
		end

	xored (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Does `p1' (`x') or `p2' (`x') hold exclusively, i.e. does `p1' (`x') xor `p2' (`x') hold?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) xor p2 (x)
		ensure
			class
			definition: Result = (p1 (x) xor p2 (x))
		end

	iff (p1, p2: PREDICATE [A]; x: A): BOOLEAN
			-- Is `p1' (`x') equivalent to `p2' (`x'), i.e. does `p1' (`x') hold if and only if `p2' (`x') holds?
			-- TODO: Pull it up?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := p1 (x) = p2 (x)
		ensure
			class
			definition: Result = (p1 (x) = p2 (x))
		end

feature -- Reduction

	cumulative_disjunction (acc: BOOLEAN; p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical disjunction of `acc' and `p' (`x'), i.e. `acc' or `p' (`x').
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc or p (x)
		ensure
			class
			definition: Result = (acc or p (x))
		end

	cumulative_conjunction (acc: BOOLEAN; p: PREDICATE [A]; x: A): BOOLEAN
			-- Logical conjunction of `acc' and `p' (`x'), i.e. `acc' and `p' (`x').
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc and p (x)
		ensure
			class
			definition: Result = (acc and p (x))
		end

	cumulative_successor (acc: like natural_anchor; x: A): like natural_anchor
			-- Natural number that succeeds `acc', i.e. `acc' + 1; `x' is ignored.
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := acc + 1
		ensure
			class
			definition: Result = acc + 1
		end

feature -- Transformer

	transformer_to_boolean: TRANSFORMER [A, BOOLEAN, OBJECT_EQUALITY [BOOLEAN]]
			-- Transformer of objects whose types derive from {A} to objects whose types derive from {BOOLEAN}
		deferred
		end

	transformer_to_natural: TRANSFORMER [A, like natural_anchor, OBJECT_EQUALITY [like natural_anchor]]
			-- Transformer of objects whose types derive from {A} to objects whose types derive from {like natural_anchor}
		deferred
		end

feature -- Anchor

	natural_anchor: NATURAL
			-- Anchor for natural numbers
			--| TODO: Pull it up to a target-dependant class.
		do
		ensure
			class
		end

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
	no_repetition: not is_empty ⇒ others ∌ any

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""

end
