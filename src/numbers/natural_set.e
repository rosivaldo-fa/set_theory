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
			extended as set_extended,
			superset_anchor as set_superset_anchor
		end

feature -- Construction

	extended alias "&" (m: NATURAL_NUMBER): like superset_anchor
			-- Current natural set extended with `m', whose equality with any other element is defined by {NATURAL_NUMBER}.equals
		deferred
		ensure
			has_m: Result ∋ m
			by_existence: attached (Result |∃ agent m.equals) as exists ⇒ exists = True
		end

feature -- Anchor

	superset_anchor: NATURAL_SET
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
