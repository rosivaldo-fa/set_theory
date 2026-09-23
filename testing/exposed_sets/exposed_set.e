note
	description: "Descendant of {SET} that exposes the hidden features or its ancestor in order to test them"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class EXPOSED_SET [G]

inherit
    SET [G]
    	export {SET_TESTS}
    		given_element,
    		subset
    	end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
