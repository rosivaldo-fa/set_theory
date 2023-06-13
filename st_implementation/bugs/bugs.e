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
			create shb
			shb.reproduce_separate_hash_bug
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
