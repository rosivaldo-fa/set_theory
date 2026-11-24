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
			-- Does `p' hold for some {NATURAL_NUMBER} within current universe?
		local
			m: EFFECTIVE_NATURAL_NUMBER
		do
			from
				Result := p (m)
			invariant
				not_before: not (
					Current |∃ agent (ia_p: PREDICATE [NATURAL_NUMBER]; ia_m, ia_n: EFFECTIVE_NATURAL_NUMBER): BOOLEAN
						do
							Result := ia_n < ia_m and ia_p (ia_n)
						end (p, m, ?)
					)
				maybe_now: Result = p (m)
			until
				Result or m ≍ {EFFECTIVE_NATURAL_NUMBER}.Max_value
			loop
				m := m + {EFFECTIVE_NATURAL_NUMBER}.One
				Result := p (m)
			variant
				m: ({EFFECTIVE_NATURAL_NUMBER}.Max_value - m).value.as_integer_32
			end
		ensure then
			zero: p ({EFFECTIVE_NATURAL_NUMBER}.Zero) ⇒ Result
			other: not p ({EFFECTIVE_NATURAL_NUMBER}.Zero) ⇒ Result = (Current / {EFFECTIVE_NATURAL_NUMBER}.Zero) |∃ p
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
