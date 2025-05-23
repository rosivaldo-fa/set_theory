note
	description: "Pool of features available for test classes that need one generic parameter and its respective equality type"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_TESTS [G]

inherit
	ELEMENT_TESTS

feature -- Factory (Object)

	some_object_g: G
			-- Randomly-fetched object like {G}
		deferred
		end

feature -- Factory (Set)

	some_set_g: STS_SET [G]
			-- Randomly-fetched polymorphic set of elements like {G}, whose equality is checked by {EQ}
		deferred
		end

	some_immediate_set_g: STS_SET [G]
			-- Some monomorphic set of elements like {G}
		deferred
		ensure
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_g}
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
