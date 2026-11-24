note
	description: "Minimal implementation of {NATURAL_NUMBERS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	EFFECTIVE_NATURAL_NUMBERS

inherit
	NATURAL_NUMBERS

feature -- Construction

	prunned alias "/" (m: NATURAL_NUMBER): EFFECTIVE_COMPLEMENT_SET [NATURAL_NUMBER]
			-- <Precursor>
		local
			s: EFFECTIVE_NATURAL_SET
		do
			create s
			create Result.make (s & m)
		end

feature -- Quantifier

	there_exists alias "|∃" (p: PREDICATE [NATURAL_NUMBER]): BOOLEAN
			-- <Precursor>
		do
		end

feature -- Anchor

	subset_anchor: SET [NATURAL_NUMBER]
			-- <Precursor>
		do
			Result := Current
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
