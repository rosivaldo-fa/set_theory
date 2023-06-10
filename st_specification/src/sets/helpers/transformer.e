note
	description: "Object able to transform objects derived from a generic parameter into objects derived from another generic parameter."
	author: "Rosivaldo F Alves"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TRANSFORMER [A, B, EQ_B -> EQUALITY [B]]

inherit
	ELEMENT

feature -- Access

	eq_b: EQ_B
			-- Equality for elements like {B}
			--| Please have a look at the note in the header of {SET}.equals.
		deferred
		ensure
			class
		end

feature -- Transformation
	-- TODO: What if some `f' has a precondition?

	set_reduction (xs: SET [A, EQUALITY [A]]; leftmost: B; f: FUNCTION [B, A, B]): B
			-- `xs' reduced by `f' to a value like `start'
			-- NOTICE: Since the order of the elements in a set is irrelevant, the value of `set_reduction' may differ for two equal sets, unless `f' is
			-- "commutative", as explained at "Painfully detailed information about ambiguous folds" (https://preview.tinyurl.com/y4qp7zre). Additionally, please
			-- see the comment at {SET}.reduced header.
		do
			if xs.is_empty then
				Result := leftmost
			else
				Result := set_reduction (xs.others, f (leftmost, xs.any), f)
			end
		ensure
			class
			base: xs.is_empty implies eq_b (Result, leftmost)
			induction: not xs.is_empty implies eq_b (Result, set_reduction (xs.others, f (leftmost, xs.any), f))
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see http://www.eiffel.com/licensing/forum.txt)
		]"
	source: ""
end
