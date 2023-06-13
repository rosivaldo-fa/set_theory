note
	description: "{SEPARATE_OUT_BUG [detachable separate CHARACTER_REF, ...]}."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name={(separate) A}.out inconsistent results", "protocol=URI", "src=https://support.eiffel.com/report_detail/19890", "tag=separate, bug, compiler, SCOOP"

class
	SEPARATE_OUT_BUG_DSCR

inherit
	SEPARATE_OUT_BUG [detachable separate CHARACTER_REF, STS_REFERENCE_EQUALITY [detachable separate CHARACTER_REF]]
		rename
			some_object_a as some_separate_character_ref,
			some_immediate_set_a as some_immediate_set_of_references_dscr,
			some_set_a as some_set_of_references_dscr
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
