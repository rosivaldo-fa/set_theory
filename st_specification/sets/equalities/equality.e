note
	description: "Element that checks for equality between two objects; defined as an equivalence relation."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQUALITY [G]

inherit
	ELEMENT

feature -- Relationship

	holds alias "()" (a, b: G): BOOLEAN
			-- Does current equality hold for `a' and `b'?
			--| Please have a look at {INSTANCE_FREE_EQUALITY}.
		deferred
		ensure
			reflexive: a = b implies Result
			symmetric: Result implies holds (b, a)
		end

	holds_successively (a, b, c: G): BOOLEAN
			-- Does current equality hold for `a' and `b' and for `b' and `c'?
			--| Needed for asserting the transitive property of an equality
		do
			Result := holds (a, b) and holds (b, c)
		ensure
			definition: Result = (holds (a, b) and holds (b, c))
			transitive: Result implies holds (a, c)
		end

note
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
