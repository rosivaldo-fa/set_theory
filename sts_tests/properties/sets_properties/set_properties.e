note
	description: "Object that checks whether the properties verified within set theory hold for an implementation of {STS_SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_PROPERTIES [G]

inherit
	ELEMENT_PROPERTIES
		rename
			is_not_in_ok as element_is_not_in_ok
		end

feature -- Access

	u: like universe_anchor
			-- The universe set
		deferred
		end

feature -- Properties (Membership)

	is_not_in_ok (s: STS_SET [G]; ss: STS_SET [STS_SET [G]]): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.is_not_in?
		do
			check
				definition: s ∉ ss = ss ∌ s
			then
				Result := True
			end
		end

	has_ok (s: STS_SET [G]; a: G): BOOLEAN
			-- Do the properties verified within set theory hold for {STS_SET}.has?
		do
			check
				universe_has_everything: u ∋ a
			then
				Result := True
			end
		end

feature -- Anchor

	universe_anchor: STS_UNIVERSE [G]
			-- Anchor for `u'
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
