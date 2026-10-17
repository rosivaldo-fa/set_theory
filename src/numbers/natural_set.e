note
	description: "Set of natural numbers, i.e. a subset of ℕ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_SET

inherit
	SET [NATURAL_NUMBER]
		rename
			u as n,
			universe as natural_numbers,
			extended as set_extended
		end

feature -- Construction

	extended alias "&" (a_n: NATURAL_NUMBER): like natural_superset_anchor
			-- Current natural set extended with `a_n', whose equality with any other element is defined by {NATURAL_NUMBER}.equals
			--| TODO: How to impose {NATURAL_NUMBER}.equals without requiring an equality object?
		deferred
		ensure
			has_a_n: Result ∋ a_n
		end

feature -- Anchor

	subset_anchor: NATURAL_SET
			-- <Precursor>
		deferred
		end

	natural_superset_anchor: NATURAL_SET
			-- Anchor for supersets of current natural set
		deferred
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
