note
	description: "Object that reproduces a bug on hash codes of separate, generic objects"
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
			a: A
			h1, h2: INTEGER
		do
			from
			until False
			loop
				a := some_object_a
				h1 := object_hash_code (a)
				h2 := object_hash_code (a)
				check
					h1 = h2
				then
				end
			end
		end

feature {NONE} -- Implementation

	object_hash_code (a: A): INTEGER
			-- Hash code of `a'.`out'; 0 if `a' is Void.
		do
			if a /= Void then
				Result := a.out.hash_code
			end
		ensure
			when_void: a = Void ⇒ Result = 0
			when_not_void: a /= Void ⇒ Result = a.out.hash_code
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
