note
	description: "Set of rational numbers, pq.e. a subset of ℚ."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RATIONAL_SET

inherit
	SET [RATIONAL_NUMBER]
		rename
			u as q,
			universe as rational_numbers,
			extended as set_extended
		end

feature -- Construction

	extended (pq: RATIONAL_NUMBER): like rational_superset_anchor
			-- Current rational set extended with `pq', whose equality with any other element is defined by {RATIONAL_NUMBER}.equals
		deferred
		ensure
			has_pq: Result ∋ pq
		end

feature -- Anchor

	subset_anchor: RATIONAL_SET
			-- <Precursor>
		deferred
		end

	rational_superset_anchor: RATIONAL_SET
			-- Anchor for supersets of current rational set
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
