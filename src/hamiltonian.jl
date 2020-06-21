export Hilbert

# 2x2 Annhilation Operator
a = complex([0  1.0; 0  0])

"""
A generic Hilbert space N-particle Hamiltonian. User defines 
creation/annhilation operator strings.
"""
mutable struct Hilbert
    N::Int
    dim::Int
    mat::Array{ComplexF64}

    function Hilbert(N::Int)
        if N >= 20
            @warn "Full Matrix has more than 1 trillion elements."
        end

        # N-site full dimension
        dim = 2^N
        mat = zeros(ComplexF64,2^N,2^N) 

        # Construct
        new(N,dim,mat)
    end
end


