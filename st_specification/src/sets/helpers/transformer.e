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

	set_map (xs: SET [A, EQUALITY [A]]; f: FUNCTION [A, B]): like set_map_anchor
			-- Set whose elements are the values of `f' (x), for all x in `xs', i.e. {`f' (x) | x ∈ `xs'}.
		deferred
		ensure
			maps_everything: xs |∀ agent transformer.target_set_has_value (Result, f, ?)
			nothing_else: Result |∀ agent transformer.source_set_has_argument (f, xs, ?)
		end

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

feature -- Predicate

	target_set_has_value (ys: SET [B, EQ_B]; f: FUNCTION [A, B] x: A): BOOLEAN
			-- Does `ys' have the value `f' (`x')?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := ys ∋ f (x)
		ensure
			class
			definition: Result = ys ∋ f (x)
		end

	source_set_has_argument (f: FUNCTION [A, B]; xs: SET [A, EQUALITY [A]]; y: B): BOOLEAN
			-- Does `xs' have some element x such that `f' (`x') = `y'?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := xs |∃ agent transformer.argument_is_mapped_to_value (f, ?, y)
		ensure
			class
			definition: Result = (xs |∃ agent transformer.argument_is_mapped_to_value (f, ?, y))
		end

	argument_is_mapped_to_value (f: FUNCTION [A, B]; x: A; y: b): BOOLEAN
			-- Does `f' map `x' to `y', i.e. `f' (`x') = `y'?
		note
			EIS: "name=Agent-only features", "protocol=URI", "src=file://$(system_path)/docs/EIS/st_specification.html#agentonlyfeatures", "tag=agent, contract view, EiffelStudio, specification"
		do
			Result := eq_b (f (x), y)
		ensure
			class
			definition: Result = eq_b (f (x), y)
		end

feature -- Transformer

	transformer: like Current
			-- Instance of this class to be used as target of agents
		deferred
		ensure
			class
		end

feature -- Anchor

	set_map_anchor: SET [B, EQ_B]
			-- Anchor for set maps
		deferred
		end

note
	copyright: "Copyright (c) 2012-2023, Rosivaldo F Alves"
	license: "[
		Eiffel Forum License v2
		(see https://www.eiffel.com/licensing/forum.txt)
		]"
	source: "https://github.com/rosivaldo-fa/Set-Theory"
end
