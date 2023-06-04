note
	description: "Set whose elements are compared by reference, i.e. via the = operator"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REFERENCE_SET [A]

inherit
	SET [A, REFERENCE_EQUALITY [A]]

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
