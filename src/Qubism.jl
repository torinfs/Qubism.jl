module Qubism

using LinearAlgebra

include("register.jl")
include("gates.jl")

# Create primitive gate set
g = Gates()

# kron operator
const ⊗ = kron

# Export to user
export g
export ⊗


end
