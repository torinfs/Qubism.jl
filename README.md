# Qubism.jl

<a href='https://travis-ci.org/torinfs/Qubism.jl'><img src='https://travis-ci.org/torinfs/Qubism.jl.svg?branch=master' alt='Coverage Status' class='center'/></a> [![Coverage Status](https://coveralls.io/repos/github/torinfs/Qubism.jl/badge.svg?branch=master)](https://coveralls.io/github/torinfs/Qubism.jl?branch=master)

## Overview

Qubism is quantum toolbox and quantum circuit simulator written in `Julia`. Functionality currently includes
- Basic quantum gate operations
- Hamiltonian builders

Warning: This package is currently in very early development, so things will break and change often.

## Examples

To create a two site Hamiltonian, adding fermionic creation and annhilation operator terms,
and printing the result, you can do the following
```
Ham = Hilbert(2)

fermion(Ham, "1^ 1", -1.0)
fermion(Ham, "2^ 2", -1.0)

print_smart(Ham.mat)
```


