note
	description: "Implementation of {STS_NATURAL_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_SET

inherit
	STS_NATURAL_SET
		undefine
			out
		end

	SET [STS_NATURAL_NUMBER]

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
