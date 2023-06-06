note
	description: "Test suite for {SET}"
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SET_TESTS [A, EQ -> STS_EQUALITY [A] create default_create end]

inherit
	UNARY_TESTS [A, EQ]
		rename
			element_to_be_tested as set_to_be_tested
		redefine
			properties,
			set_to_be_tested
		end

feature -- Access

	properties: SET_PROPERTIES [A, EQ]
			-- Object that checks the set-theory properties of {SET}

feature -- Test routines (Primitive)

	test_is_empty
			-- Test {SET}.is_empty.
		note
			testing: "covers/{SET}.is_empty"
		local
			s: like set_to_be_tested
		do
			s := set_to_be_tested
			inspect
				next_random_item \\ 2
			when 0 then
--				s := s.o
			when 1 then
--				s := s ∖ same_set_a (s)
			end
			assert ("s.is_empty", s.is_empty)
			assert ("s.is_empty ok", properties.is_empty_ok (s))

--			s := set_to_be_tested & some_object_a
			create s.make_singleton (some_object_a)
			assert ("not s.is_empty", not s.is_empty)
			assert ("not s.is_empty ok", properties.is_empty_ok (s))

			s := set_to_be_tested
			assert ("is_empty", s.is_empty ⇒ True)
			assert ("is_empty_ok", properties.is_empty_ok (s))
		end

	test_any
			-- Test {SET}.any.
		note
			testing: "covers/{SET}.any"
		local
			s: like set_to_be_tested
		do
--			s := set_to_be_tested & some_object_a
			create s.make_singleton (some_object_a)
				check
					is_not_empty: not s.is_empty -- s ≍ {a, ...}
				end
			assert ("s.any", attached s.any ⇒ True)
			assert ("s.any ok", properties.any_ok (s))

			s := set_to_be_tested
			assert ("any", not s.is_empty ⇒ attached s.any ⇒ True)
			assert ("any_ok", properties.any_ok (s))
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_set_a
			-- Set meant to be under tests
		do
			Result := some_immediate_set_a
		end

feature -- Factory (Equality)

	some_immediate_set_a: SET [A, EQ]
			-- Some monomorphic set of elements like {A}
		note
			TODO: "Report bug!"
		deferred
		ensure
			bug_ignored_on_joined_descendant: False
			monomorphic: Result.generating_type ~ {detachable like some_immediate_set_a}
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
