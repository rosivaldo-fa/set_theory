note
	description: "bugs application root class"
	date: "$Date: 2019-09-11 18:27:54 +0000 (Wed, 11 Sep 2019) $"
	revision: "$Revision: 103504 $"

class
	BUGS

create
	reproduce_bugs

feature {NONE} -- Initialization

	reproduce_bugs
			-- Reproduce selected known bugs.
		local
			shb: SEPARATE_HASH_BUG_DSCR
		do
--			reproduce_separate_hash_bug
			create shb
			shb.reproduce_separate_hash_bug
		end

feature -- Bug

	reproduce_separate_hash_bug
			-- Reproduce a bug on hash codes of separate objects.
		local
			e: ELEMENT_TESTS
			a: detachable separate CHARACTER_REF
			h1, h2: INTEGER
		do
			from
				create e
			until False
			loop
				a := e.some_separate_character_ref
				h1 := object_hash_code (a)
				h2 := object_hash_code (a)
				check
					h1 = h2
				then
				end
			end
		end

feature {NONE} -- Implementation

	object_hash_code (a: detachable separate CHARACTER_REF): INTEGER
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
