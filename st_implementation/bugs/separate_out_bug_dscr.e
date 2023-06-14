note
	description: "{SEPARATE_OUT_BUG [detachable separate CHARACTER_REF]}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name={(separate) A}.out inconsistent results", "protocol=URI", "src=https://support.eiffel.com/report_detail/19890", "tag=separate, bug, compiler, SCOOP"

class
	SEPARATE_OUT_BUG_DSCR

inherit
	SEPARATE_OUT_BUG [detachable separate CHARACTER_REF]

feature {NONE} -- Implementation

	some_object_a: detachable separate CHARACTER_REF
			-- <Precursor>
		do
			create Result
			separate Result as sep_r do
				sep_r.set_item ('a')
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
