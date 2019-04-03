module Qubism

using LinearAlgebra

const ⊗ = kron
include("register.jl")
include("gateop.jl")


function main()

    # Number of qubits
    N = 2

    # Initialize
    reg = Register(N)
    gate = Gates()

    #display(reg.psi)
    #GateOp(gate.H, 1, reg)
    #display(reg.psi)

    #@time GateOp(gate.H, 2, reg)
    #@time GateOp(gate.H, 2, reg)
    #@time GateOp(gate.H, 2, reg)
    #gateop(gate.H, 2, 3, reg)
    #gateop(gate.H, 2, reg)
    #gateop(gate.H, 3, reg)

    #@time gateop(gate.H, 2, reg)
    #@time gateop(gate.H, 3, reg)
    #@time gateop(gate.H, 2, reg)
    #@time gateop(gate.H, 2, reg)
    #@time gateop(gate.H, 2, reg)
    #@time gateop(gate.H, 2, reg)

    gateop(gate.H, 1, reg)
    cgateop(gate.X, 1, 2, reg)
    #gateop(gate.H, 1, reg)
    display(reg.psi)
    println()
end


main()

end
