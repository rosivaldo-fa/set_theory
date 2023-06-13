note
	description: "Object that reproduces a bug on Void-safety value for separate objects"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Controlled separate object looses Void-safety", "protocol=URI", "src=https://support.eiffel.com/report_detail/19891", "tag=separate, bug, compiler, SCOOP, Void-safety"

class
	SEPARATE_VOID_UNSAFETY

feature -- Bug

	reproduce_separate_void_unsafety
			-- Reproduces a bug on Void-safety value for separate objects.
		note
			EIS: "name=Controlled separate object looses Void-safety", "protocol=URI", "src=https://support.eiffel.com/report_detail/19891", "tag=separate, bug, compiler, SCOOP, Void-safety"
		local
			c1: detachable CHARACTER_REF
			c2: detachable separate CHARACTER_REF
			s1, s2: STRING
		do
--			s1 := c1.out
--			s2 := c2.out
			separate c2 as sep_c2 do
				create s2.make_from_separate (sep_c2.out)
			end
		ensure
			class
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
