note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_EQUALITY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY_PROPERTIES [A, EQ -> STS_EQUALITY [A]]

inherit
	ELEMENT_PROPERTIES

feature -- Access

	current_universe: STS_SET [A, EQ]
			-- The current "Universe", i.e. set with every object currently in system memory whose type conforms to {A}.
			-- Notice that this "universe" may change from a call to another.
		deferred
		end

feature -- Properties (Relationship)

	holds_ok (a, b: A; eq: EQ): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_EQUALITY}.holds?
		do
			check
				u: attached current_universe as u
--				definition: eq (a, b) = (
--					u.powerset |∀ agent (s: STS_SET [A, EQ]; ia_a, ia_b: A): BOOLEAN
--						do
--							Result := s ∋ ia_a = s ∋ ia_b
--						end (?, a, b)
--					)
			then
				Result := True
			end
		end

	holds_successively_ok (a, b, c: A; eq: EQ): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_EQUALITY}.holds_successively?
		do
			check
				definition: eq.holds_successively (a, b, c) = (eq (a, b) and eq (a, c))
			then
				Result := True
			end
		end

feature {NONE} -- Implementation

--	max_supersets: NATURAL
--			-- Maximum number of supersets to be checked within property statemens
--		deferred
--		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
