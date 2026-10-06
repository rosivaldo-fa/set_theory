note
	description: "Effective test suite for {SET_FAMILY}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_FAMILY_EFFECTIVE_TESTS

inherit
	SET_FAMILY_TESTS [detachable separate CHARACTER_REF]
		redefine
			test_all
		end

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{SET_FAMILY}"
		do
			Precursor {SET_FAMILY_TESTS}
		end

feature {NONE} -- Factory

	s1: SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		once
			create Result
		ensure then
			class
		end

	s2: SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		once
			Result := s1.extended ({SET_EFFECTIVE_TESTS}.C1, create {REFERENCE_EQUALITY [detachable separate CHARACTER_REF]})
		ensure then
			class
		end

	s3: SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		once
			separate {SET_EFFECTIVE_TESTS}.C2 as sep_c2 do
				Result := s2.extended (sep_c2.standard_twin, create {OBJECT_STANDARD_EQUALITY [detachable separate CHARACTER_REF]})
			end
		ensure then
			class
		end

	s4: SET [detachable separate CHARACTER_REF]
			-- <Precursor>
		once
			separate {SET_EFFECTIVE_TESTS}.C3 as sep_c3 do
				Result := s3.extended (sep_c3.twin, create {OBJECT_EQUALITY [detachable separate CHARACTER_REF]})
			end
		ensure then
			class
		end

note
	copyright: "Copyright (c) 2012-2026, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"

end
