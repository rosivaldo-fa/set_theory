note
	description: "Arena for reproducing bugs"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			reproduce_arrayed_set_disjoint_bug
		end

feature {NONE} -- Bug

	reproduce_arrayed_set_disjoint_bug
			-- Reproduce the bug in {ARRAYED_SET}.disjoint feature.
		note
			EIS: "name=Error within implementation of {ARRAYED_SET}.disjoint", "protocol=URI", "src=https://support.eiffel.com/report_detail/19894", "tag=Bug, EiffelBase"
		local
			s: ARRAYED_SET [detachable INTEGER_REF]
		do
			create s.make (0)
			s.extend (Void) -- Nothing prevents that.
			check
					-- Somewhere {ARRAYED_SET}.subset_strategy_selection precondition (item_exists: v /= Void) is violated due to the Void item inside `s'.
				not s.disjoint (s)
			then
			end
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
