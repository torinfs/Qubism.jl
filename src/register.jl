export Register
export Gates

"""
Creates register initializing with all |0⟩ qubits

- `N`   : Total number of qubits in circuit
- `psi` : State vector for the 2^N Hilbert space

"""
mutable struct Register
    N::Int64
    psi::Array{ComplexF64}

    # Construct with all |0⟩
    function Register(N)
        x = zeros(ComplexF64,2^N)
        x[1] = complex(1.0)
        new(N,x)
    end
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

