module Qubism

using LinearAlgebra

const ⊗ = kron
include("register.jl")
include("gates.jl")

# Create primitive gate set
gate = Gates()
export gate

end
