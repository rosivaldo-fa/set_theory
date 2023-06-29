# set_theory
Eiffel classes modeled upon the concepts of set theory

Please see https://www.eiffel.org/blog/rosivaldo/2017/09/set-theory

Copyright (c) 2012-2023, Rosivaldo F Alves

license: Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)

## Change history
### v0.1.3
- Added examples of using set theory classes:
	- st_examples.ecf
	- st_examples\src\mutable_set.e
	- st_examples\testing\application.e
### v0.1.2
- Set transformations:
    - {STS_SET}.mapped
    - {STS_SET}.reduced
    - {STS_SET}.proper_reduced
### v0.1.1
- Set mapping ({STS_SET}.mapped alias "↦") available.
### v0.1.0
- Working implementation of the set concept:
    - membership relation
    - set relations (is_subset, is_superset, etc.)
    - set operations (intersection, union, etc.)
    - quantifiers (for_all, exists, etc.)
