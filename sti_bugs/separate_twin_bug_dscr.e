note
	description: "{SEPARATE_TWIN_BUG [detachable separate CHARACTER_REF]}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SEPARATE_TWIN_BUG_DSCR

inherit
	SEPARATE_TWIN_BUG [detachable separate CHARACTER_REF]

feature {NONE} -- Implementation

	some_object_g: detachable separate CHARACTER_REF
			-- <Precursor>
		do
			create Result
			separate Result as sep_r do
				sep_r.set_item ('a')
			end
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
