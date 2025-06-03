note
	description: "Set whose elements are sets"
	author: "Rosivaldo Fernandes Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_FAMILY [G]

inherit
	SET [SET [G]]
		rename
			subset_anchor as subfamily_anchor,
			superset_anchor as superfamily_anchor
		end

feature -- Anchor

	subfamily_anchor: SET_FAMILY [G]
			-- Anchor for subsets of current set family
		deferred
		end

	superfamily_anchor: SET_FAMILY [G]
			-- Anchor for supersets of current set family
		deferred
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
