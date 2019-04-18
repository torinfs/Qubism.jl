export Register

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
