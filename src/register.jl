export Register
export Gates

"""
Creates register initializing with the |0...0⟩ state

- `N`     : Total number of qubits in circuit
- `state` : State vector for the 2^N Hilbert space

"""
mutable struct Register
    N::Int
    state::Array{ComplexF64}

    # Construct with state |0...0⟩
    function Register(N)
        @assert typeof(N) == Int
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
- `T` : Rotate π/8 gate
- `S` : Rotate π/4 gate   

"""
struct Gates
    H::Array{ComplexF64}
    Z::Array{ComplexF64}
    X::Array{ComplexF64}
    Y::Array{ComplexF64}
    T::Array{ComplexF64}
    S::Array{ComplexF64}
    Gates() = new((1.0/sqrt(2.0)) * complex([1   1; 1  -1]),
                  complex([1   0; 0    -1]),
                  complex([0   1; 1     0]),
                  complex([0 -im; im    0]),
                  complex([1   0; 0  ℯ^(im*(π/4))]),
                  complex([1   0; 0  ℯ^(im*(π/2))]))
end

