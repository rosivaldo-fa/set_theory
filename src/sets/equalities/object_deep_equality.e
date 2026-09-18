note
	description: "Equality that holds for entities that are both void or that are equal according to the ≡≡≡ operator, i.e. `is_deep_equal' comparison."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_DEEP_EQUALITY [G]

inherit
	INSTANCE_FREE_EQUALITY [G]
		redefine
		    holds_successively
		end

feature -- Relationship

	holds alias "()" (a, b: G): BOOLEAN
			-- <Precursor>
		note
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			if attached a then
				Result := attached b and then a ≡≡≡ b
			else
				Result := not attached b
			end
		ensure then
			when_attached_a: attached a ⇒ Result = (attached b and then a ≡≡≡ b)
			when_detached_a: not attached a ⇒ Result = not attached b
		rescue
			if {EXCEPTIONS}.tag_name ~ "symmetric" or {EXCEPTIONS}.tag_name ~ "when_attached_a" then
				retry -- Please have a look at EIS entry above.
			end
		end

	holds_successively (a, b, c: G): BOOLEAN
			-- <Precursor>
		note
			eis: "name=Inconsistent results of {detachable separate CHARACTER_REF}.twin", "protocol=URI", "src=https://support.eiffel.com/report_detail/19952", "tag=bug, separate, compiler, SCOOP"
		do
			Result := Precursor {INSTANCE_FREE_EQUALITY}(a, b, c)
		rescue
			if {EXCEPTIONS}.tag_name ~ "definition" then
				retry -- Please have a look at EIS entry above.
			end
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
