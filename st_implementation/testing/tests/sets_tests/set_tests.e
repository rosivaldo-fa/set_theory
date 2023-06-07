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

	test_others
			-- Test {SET}.others.
		note
			testing: "covers/{SET}.others"
		local
			s: like set_to_be_tested
			a, b, c: like some_object_a
		do
			s := o
--			assert ("∅", s.others ≍ o)
			assert ("∅ ok", properties.others_ok (s))

--			s := s & some_object_a
				check
					is_not_empty: not s.is_empty -- s = {a}
				end
			a := same_object_a (s.any)
--			assert ("{a}", s.others ≍ o)
			assert ("{a} ok", properties.others_ok (s))

--			s := s & some_other_object_a (s)
				check
					is_not_empty_2: not s.others.is_empty -- s = {a,b}
				end
			b := same_set_a (s.others).any
--			assert ("{a,b}", s.others ≍ (o & b))
			assert ("{a,b} ok", properties.others_ok (s))

--			s := s & some_other_object_a (s)
				check
					is_not_empty_3: not s.others.is_empty -- # s = 3
				end
			b := same_set_a (s.others).any
				check
--					is_not_empty_4: not (s.others / b).is_empty -- # s = 3
				end
--			c := same_set_a (s.others / b).any
--			assert ("{a,b,c}", s.others ≍ (s.o & b & c))
			assert ("{a,b,c} ok", properties.others_ok (s))

			s := set_to_be_tested
			assert ("others", attached s.others)
			assert ("others_ok", properties.others_ok (s))
		end

	test_eq
			-- Test {SET}.eq.
		note
			testing: "covers/{SET}.eq"
		do
			assert ("eq", attached set_to_be_tested.eq)
			assert ("class: eq", attached {like set_to_be_tested}.eq)
		end

feature {NONE} -- Factory (element to be tested)

	set_to_be_tested: like some_immediate_set_a
			-- Set meant to be under tests
		do
			Result := some_immediate_set_a
		end

	set_to_be_tested_with_cardinality (n: NATURAL): like set_to_be_tested
			-- Set with `n' elements meant to be under tests
			--| TODO: Make `n' more general.
		require
			small_enough: n ≤ Max_count
		do
			from
				from
					Result := set_to_be_tested
				until
--					# Result ≥ n
					True
				loop
					Result := set_to_be_tested
				end
--			invariant
--				at_least_n: # Result ≥ n
			until
--				# Result = n
				True
			loop
				Result := Result.others
--			variant
--				down_to_n: {like new_set_a}.natural_as_integer (# Result - n)
			end
		ensure
--			n_elements: # Result = n
		end

	o: like set_to_be_tested
			-- The empty set, i.e. {} or ∅
			--| TODO: Make it once? An attribute?
		do
			create Result.make_empty
		end

feature -- Factory (Equality)

	some_immediate_set_a: SET [A, EQ]
			-- Some monomorphic set of elements like {A}
		note
			EIS: "name=Post-condition ignored on joined descendant", "protocol=URI", "src=https://support.eiffel.com/report_detail/19889", "tag=bug, compiler"
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
