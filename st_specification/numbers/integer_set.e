note
	description: "Set of integer numbers, i.e. a subset of ℕ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTEGER_SET

inherit
	SET [INTEGER_NUMBER]
		rename
			u as z,
			universe as integer_numbers,
			extended as set_extended
		end

feature -- Construction

	extended (i: INTEGER_NUMBER): like integer_superset_anchor
			-- Current integer set extended with `i', whose equality with any other element is defined by {INTEGER_NUMBER}.equals
		deferred
		ensure
			has_a_n: Result ∋ i
		end

feature -- Anchor

	subset_anchor: INTEGER_SET
			-- <Precursor>
		deferred
		end

	integer_superset_anchor: INTEGER_SET
			-- Anchor for supersets of current integer set
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
