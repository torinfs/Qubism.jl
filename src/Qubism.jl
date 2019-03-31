module Qubism

using InteractiveUtils
using LinearAlgebra

const ⊗ = kron
include("register.jl")
include("gateop.jl")


function main()

    # Number of qubits
    N = 4

    # Initialize
    reg = Register(N)
    gate = Gates()

    # FIXME in constructor
    reg.psi[1] = 1.0

    #display(reg.psi)
    #GateOp(gate.H, 1, reg)
    #display(reg.psi)

    #@time GateOp(gate.H, 2, reg)
    #@time GateOp(gate.H, 2, reg)
    #@time GateOp(gate.H, 2, reg)
    GateOp(gate.H, 2, reg)
    display(reg.psi)
    println()
end


main()

end
