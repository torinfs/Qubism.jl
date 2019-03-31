module Qubism

using InteractiveUtils

# Globals
const ⊗ = kron


mutable struct Register
    N::Int64
    psi::Array{ComplexF64}
    Register(N) = new(N,zeros(ComplexF64,2^N))
end


"""
Constructs gate primitives for use in tensor contractions via GateOp()
All matrices are of complex float types.

# Gates

   - `H` : Hadamard gate
   - `Z` : Pauli Z gate
   - `X` : Pauli X gate
   - `Y` : Pauli Y gate

"""
struct Gates
    H::Array{ComplexF64}
    Z::Array{ComplexF64}
    X::Array{ComplexF64}
    Y::Array{ComplexF64}
    Gates() = new((1.0/sqrt(2.0)) * complex([1   1; 1  -1]),
                  complex([1   0; 0  -1]),
                  complex([0   1; 1   0]),
                  complex([0 -im; im  0]))
end


function GateOp(G::Array{ComplexF64}, q::Int64, reg::Register)
    #temp = complex(zeros(ComplexF64,2^13))
    I = complex([1 0; 0 1])
    temp = G ⊗ I
    temp = temp ⊗ I
    display(temp)
end


function main()

    # Number of qubits
    N = 3

    reg = Register(N)
    gate = Gates()
    display(gate.H)
    display(gate.Z)
    println()

    fac = complex(1.0/sqrt(2.0))
    H = fac * complex([1 1; 1 -1])
    I = complex([1 0; 0 1])
    temp = H ⊗ I ⊗ I

    display(temp)
    reg.psi[1] = 1.0
    display(temp*temp*reg.psi)

    println("\nNew")

    GateOp(gate.H, 1, reg)

    #@time test(H,I)
    println()
end


main()

end
