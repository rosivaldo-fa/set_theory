note
	description: "Model of a natural number, i.e. a non-negative integer number."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATURAL_NUMBER

inherit
	ELEMENT

feature -- Primitive

	value: like native_natural_anchor
			-- Native value of current natural number
		deferred
		end

feature -- Anchor

	native_natural_anchor: NATURAL
			-- Anchor for the native representation of the value of current natural number
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
