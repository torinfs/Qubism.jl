export Hilbert, fermion

# 2x2 Annhilation Operator
a = complex([0  1.0; 0  0])
Id = complex(I + zeros(2,2))

"""
A generic Hilbert space N-particle Hamiltonian. User defines 
creation/annhilation operator strings applied to .mat
"""
mutable struct Hilbert
    N::Int
    dim::Int
    mat::Array{Complex}

    function Hilbert(N::Int)
        if N >= 20
            @warn "Full Matrix has more than 1 trillion elements."
        end

        # N-site full dimension
        dim = 2^N
        mat = zeros(Complex,2^N,2^N) 

        # Construct
        new(N,dim,mat)
    end
end


"""
Implements fermionic matrix element to a Hamiltonian using a naive
Jordan-Wigner string. For example a creation operator on site 3 out of 6 sites
would produce the following matrix.

a'_3 = Z ⊗ Z ⊗ a' ⊗ 1 ⊗ 1 ⊗ 1

FIXME: very inefficient
"""
function fermion(Ham::Hilbert, s::String, value::AbstractFloat)


    # Get full dimension
    N = Ham.N

    # Temporary matrix storage
    working_mat = zeros(Complex,2^N,2^N) 

    # Get sites for the term
    operators = parse_operator_string(s)

    isFirst = true

    # Loop over single creation/annhilation operators
    # in the fermion operator.
    for term in operators

        # Get site and operator type
        idx = term[1]
        create = term[2]
 
        # Input checks
        @assert idx >= 1 && idx <= N
        @assert create == 0 || create == 1

        # Populate with either creation or annihilation
        if create == 1
            op = a'    
        else
            op = a
        end

        # Build Matrix for each operator, then multiply
        if idx == 1
            mat = op
            for i = idx+1:N
                mat = mat ⊗ Id
            end
        else
            mat = Z
            for i = 2:idx-1
                mat = mat ⊗ Z
            end

            mat = mat ⊗ op
            
            for i = idx+1:N
                mat = mat ⊗ Id
            end
        end

        # Check if first term in list
        if isFirst
            working_mat = mat
            isFirst = false
        else
            working_mat = working_mat * mat
        end

    end
    
    # Add Matrix element to Hamiltonian
    Ham.mat += value * working_mat
end

