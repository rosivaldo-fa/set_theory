note
	description: "Object that reproduces a bug on hash codes of separate objects"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SEPARATE_HASH_BUG [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	UNARY_TESTS [A, EQ]

feature -- Bug

	reproduce_separate_hash_bug
			-- Reproduce a bug on hash codes of separate objects.
		local
			e: ELEMENT_TESTS
			a: A
			i: INTEGER
			cell: CELL [A]
		do
			from
				create e
			until False
			loop
				a := some_object_a
				i := (
					agent (x: A): INTEGER
						do
							if attached x then
								Result := x.out.hash_code
							end
						end
					).item (a)
				create cell.put (a)
				check
					(
						agent (x, y: A): BOOLEAN
							do
								if x = Void then
									Result := y = Void
								else
									Result := y /= Void and then x.out.hash_code = y.out.hash_code
								end
							end
						).item (a, cell.item)
				then
				end
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
