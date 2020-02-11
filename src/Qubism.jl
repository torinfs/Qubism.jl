module Qubism

using LinearAlgebra

include("register.jl")
include("gates.jl")
include("helpers.jl")

# Unicode kron operator $\otimes$
const ⊗ = kron

# Export to user
export ⊗

end

