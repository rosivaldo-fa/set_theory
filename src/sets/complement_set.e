note
	description: "Set whose elements are those not included in a given reference set"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLEMENT_SET [G]

inherit
	SET [G]

feature -- Primitive

	reference_set: SET [G]
			-- Set that current set is a complement of
		deferred
		end

feature -- Membership

	has alias "∋" (a: G): BOOLEAN
			-- <Precursor>
		do
			Result := reference_set ∌ a
		ensure then
			definition: Result = reference_set ∌ a
		end

feature -- Construction

	prunned alias "/" (a: G): like subset_anchor
			-- <Precursor>
		deferred
		ensure then
			extended_reference: Result.reference_set ∋ a -- TODO: Use set equality.
		end

feature -- Anchor

	subset_anchor: COMPLEMENT_SET [G]
			-- <Precursor>
		deferred
		end

feature -- Quantifier

	there_exists alias "|∃" (p: PREDICATE [G]): detachable BOOLEAN_REF
			-- <Precursor>
		do
			Result := u |∃ agent p_holds_outside_reference_set (p, ?)
		ensure then
			definition: Result = u |∃ agent p_holds_outside_reference_set (p, ?)
		end

	p_holds_outside_reference_set (p: PREDICATE [G]; x: G): BOOLEAN
			-- Is not `x' `in reference_set' and does `p' (`x') hold?
		do
			Result := reference_set ∌ x and p (x)
		ensure
			definition: Result = (reference_set ∌ x and p (x))
		end;

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
