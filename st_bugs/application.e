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
	make,
	reproduce_arrayed_set_disjoint_bug,
	reproduce_arrayed_set_valid_index_bug

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			reproduce_arrayed_set_disjoint_bug
			reproduce_arrayed_set_valid_index_bug
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

	reproduce_arrayed_set_valid_index_bug
			-- Reproduce the bug in {ARRAYED_SET}.valid_index feature.
		local
			s: ANNOTATED_ARRAYED_SET [INTEGER]
		do
			create s.make_from_iterable (<<0, 3, 5>>)
			check

				s.valid_index (2)
				not s.valid_index (5) -- {ARRAYED_SET}.valid_index's post-condition index_valid: 0 <= i and i <= count + 1 (from LINEAR_SUBSET) is violated.
									  -- It seems that the post-condition should read index_valid: Result (0 <= i and i <= count + 1).
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
