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
			o1, o2: STRING
		do
			from
			until False
			loop
				a := some_object_a
				o1 := object_out (a)
				o2 := object_out (a)
				check
					o1.hash_code = o2.hash_code
				then
				end
			end
		end

feature {NONE} -- Implementation

	object_out (a: A): STRING
			-- New string containing terse printable representation of `a'
		do
			if a /= Void then
				create Result.make_from_separate (a.out)
			else
				create Result.make_empty
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
