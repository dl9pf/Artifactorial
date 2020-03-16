#!/bin/sh

set -e

if [ "$1" = "setup" ]
then
  set -x
  apt-get -q update
  apt-get install --no-install-recommends --yes pylint3 python3-pylint-django
else
  set -x
  # Only run some pylint checkers
  # See https://docs.pylint.org/en/1.6.0/features.html
  # Disabled:
  #  C0411: %s comes before %s Used when PEP8 import order is not respected (standard imports first, then third-party libraries, then local imports)
  #  C0412: Imports from package %s are not grouped
  #  E0401: Unable to import '%s'
  #  E0611: No name '%s' in module '%s'
  #  R0201: Method could be a function
  #  R0401: Cyclic import (%s -> %s)
  # Enabled:
  #  R1707: Disallow trailing comma tuple
  #  R1714: Consider merging these comparisons with "in" to %r
  #  R1715: Consider using dict.get for getting values from a dict if a key is present or a default if not
  #  R1716: Simplify chained comparison between the operands
  #  W0235: Useless super delegation in method %r
  #  W0404: Reimport %r (imported line %s) Used when a module is reimported multiple times.
  #  W0611: Unused %s Used when an imported module or variable is not used.
  #  W1401: Anomalous backslash in string: '%s'.
  #  W1402: Anomalous Unicode escape in byte string: '%s'.
  #  W1403: Implicit string concatenation found in %s
  #  W1505: Using deprecated method warn()
  pylint3 --disable=all --enable=elif,exceptions,stdlib,imports,variables,string,string_constant,logging,newstyle,classes --disable=C0411,C0412,E0401,E0611,R0201,R0401,W --enable=R1707,R1714,R1715,R1716,W0235,W0404,W0611,W1401,W1402,W1403,W1505 Artifactorial
fi
