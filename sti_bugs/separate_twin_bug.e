note
	description: "Object that reproduces a bug on {ANY}.twin value of separate, generic objects"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SEPARATE_TWIN_BUG [G]

feature -- Bug

	reproduce_separate_twin_bug
			-- Reproduce a bug on `twin' value of separate, generic objects.
		note
			EIS: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952"
		local
			a, b: G
		do
			from
			until False
			loop
				a := some_object_g
				b := object_twin_g (a)
			end
		ensure
			class
		end

feature {NONE} -- Implementation

	some_object_g: G
			-- Some object of type {G}
		deferred
		ensure
			class
		end

	object_twin_g (a: G): G
			-- Object equal (by value) to `a'
		do
			if attached a then
				Result := a.twin
			else
				Result := a
			end
		ensure
			class
			same_value: Result ~ a -- BUG: Eventually violated.
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
