note
	description: "Arena for reproducing bugs"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	reproduce_arrayed_set_disjoint_bug,
	reproduce_arrayed_set_valid_index_bug,
	reproduce_arrayed_set_move_item_bug_19896,
	reproduce_arrayed_set_move_item_bug_19897,
	reproduce_arrayed_set_move_item_bug_item_exists

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
		note
			EIS: "name=Wrong post-condition of {ARRAYED_SET}.valid_index", "protocol=URI", "src=https://support.eiffel.com/report_detail/19895", "tag=Bug, EiffelBase"
		local
			s: ANNOTATED_ARRAYED_SET [INTEGER]
		do
			create s.make_from_iterable (<<0, 3, 5>>)
			check

				s.valid_index (2)
				not s.valid_index (5) -- {ARRAYED_SET}.valid_index's post-condition index_valid: 0 <= i and i <= count + 1 (from LINEAR_SUBSET) is violated.
									  -- It seems that the post-condition should read index_valid: Result = (0 <= i and i <= count + 1).
			then
			end
		end

	reproduce_arrayed_set_move_item_bug_19896
			-- Reproduce bug in {ARRAYED_SET}.move_item feature: {ARRAYED_SET}.put_left precondition violated.
		note
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.put_left precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19896", "tag=Bug, EiffelBase"
		local
			s: ARRAYED_SET [CHARACTER]
		do
			create s.make (0)
			s.extend ('a')
			s.move_item ('a') -- Exception here!
		end

	reproduce_arrayed_set_move_item_bug_19897
			-- Reproduce bug in {ARRAYED_SET}.move_item feature: {ARRAYED_SET}.go_i_th precondition violated.
		note
			EIS: "name={ARRAYED_SET}.move_item does not fulfill {ARRAYED_SET}.go_i_th precondition.", "protocol=URI", "src=https://support.eiffel.com/report_detail/19897", "tag=Bug, EiffelBase"
		local
			s: ARRAYED_SET [CHARACTER]
		do
			create s.make (0)
			s.extend ('a')
			s.finish
			s.forth
			s.move_item ('a') -- Exception here!
		end

	reproduce_arrayed_set_move_item_bug_item_exists
			-- Reproduce bug in {ARRAYED_SET}.move_item feature: item_exists precondition is possibly unnecessary.
		note
			EIS: "name=Possibly unnecessary precondition in {ARRAYED_SET}.move_item: item_exists", "protocol=URI", "src=https://support.eiffel.com/report_detail/19898", "tag=Bug, EiffelBase"
		local
			s1: BUG_EXPOSER_ARRAYED_SET [detachable CHARACTER_REF]
			s2: ARRAYED_SET [detachable CHARACTER_REF]
		do
			create s1.make (0)
			s1.extend (Void)
			s1.extend ('a')
			s1.finish
			s1.move_item (Void) -- No problem
			s1.wipe_out
			s1.compare_objects
			s1.extend (Void)
			s1.extend ('a')
			s1.finish
			s1.move_item (Void) -- Still no problem

			create s2.make (0)
			s2.extend (Void)
			s2.extend ('a')
			s2.finish
--			s2.move_item (Void) -- Precondition violated: item_exists: v /= Void
			s2.wipe_out
			s2.compare_objects
			s2.extend (Void)
			s2.extend ('a')
			s2.finish
			s2.move_item (Void) -- Precondition violated: item_exists: v /= Void
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
