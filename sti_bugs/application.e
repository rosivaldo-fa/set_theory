note
	description: "sti_bugs application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	reproduce_bugs

feature {NONE} -- Initialization

	reproduce_bugs
			-- Run application.
		do
			{SEPARATE_TWIN_BUG_DSCR}.reproduce_separate_twin_bug
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
