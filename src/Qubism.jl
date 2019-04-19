module Qubism

using LinearAlgebra

const ⊗ = kron
include("register.jl")
include("gates.jl")

# Create primitive gate set
g = Gates()
export g

end
