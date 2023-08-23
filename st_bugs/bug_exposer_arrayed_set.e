note
	description: "Class meant to repoduce some bugs in ARRAYED_SET"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	BUG_EXPOSER_ARRAYED_SET [G]

inherit
	ARRAYED_SET [G]
		redefine
			move_item
		end

create
	make,
	make_from_iterable

create {ARRAYED_SET}
	make_filled

convert
	make_from_iterable ({ARRAY [G]})

feature -- Element change

	move_item (v: G)
			-- <Precursor>
			-- Repeat the inherited implementation, except for the preconditions.
		require else
--			item_exists: v /= Void -- Get rid of this precondition.
			item_in_set: has (v)
		local
			idx: INTEGER
			found: BOOLEAN
		do
			idx := index
			from
				start
			until
				found or after
			loop
				if object_comparison then
					found := v ~ item
				else
					found := v = item
				end
				if not found then
					forth
				end
			end
			check
				found: found and not after
				-- Because the precondition states that `v' is in the set.
			end
			remove
			go_i_th (idx)
			put_left (v)
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
