module Qubism

using LinearAlgebra

include("register.jl")
include("gates.jl")

# kron operator
const ⊗ = kron

# Export to user
export ⊗

end
