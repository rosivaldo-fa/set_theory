note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_PROPERTIES [A, EQ -> STS_EQUALITY [A]]

inherit
	ELEMENT_PROPERTIES

feature -- Access

	o: like o_anchor
			-- The empty set
		deferred
		ensure
			is_empty: Result.is_empty
		end

	current_universe: like universe_anchor
			-- The current "Universe", i.e. set with every object currently in system memory whose type conforms to {A}.
			-- Notice that this "universe" may change from a call to another.
		deferred
		end

feature -- Properties (Primitive)

	is_empty_ok (s: STS_SET [A, EQ]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_empty?
		do
			check
				u: attached current_universe as u
--				definition: s.is_empty = (
--					s ≍ (
--						u | agent  (x: A): BOOLEAN
--							do
--								Result := False
--							end
--						)
--					)
--				has_nothing: s.is_empty = (u |∀ agent s.does_not_have)
--				no_element: s.is_empty = (# s = 0)
--				uniqueness: s.is_empty = (s ≍ o)
			then
				Result := True
			end
		end

feature {NONE} -- Anchor

	universe_anchor: STS_SET [A, EQ]
			-- Anchor for `current_universe'
		do
			Result := current_universe
		end

	o_anchor: STS_SET [A, EQ]
			-- Anchor for `o'
		do
			Result := o
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
