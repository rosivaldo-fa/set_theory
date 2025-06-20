note
	description: "Implementation of {STST_ELEMENT_TESTS}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	ELEMENT_TESTS

inherit
	STST_ELEMENT_TESTS
		rename
			some_immediate_natural_number as some_expanded_natural_number
		undefine
			default_create
		redefine
			test_all,
			test_is_in,
			test_is_not_in
		end

	EQA_TEST_SET

feature -- Test routines (All)

	test_all
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Test routines (Membership)

	test_is_in
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}.is_in"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

	test_is_not_in
			-- <Precursor>
		note
			testing: "covers/{STS_ELEMENT}.is_not_in"
		do
			Precursor {STST_ELEMENT_TESTS}
		end

feature -- Factory (Element)

	some_elements: STI_SET [STS_ELEMENT]
			-- <Precursor>
		do
			across
				1 |..| some_count.as_integer_32 as i
			from
				create Result
			loop
				Result := Result.extended (some_element, some_element_equality)
			end
		end

feature -- Factory (natural number)

	some_expanded_natural_number: STI_NATURAL_NUMBER
			-- <Precursor>
		do
		end

	some_native_natural_number: NATURAL
			-- Randomly-created native natural number
		do
			Result := next_random_item.as_natural_32 & 0b1111111 -- TODO: No magic number!
		end

note
	copyright: "Copyright (c) 2012-2025, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/set_theory"
end
