export Op
export cOp
export Gates
export H


"""
Constructs gate primitives for use in tensor contractions via Op()
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


"""
Performs an gate operation on the register by constructing
the tensor product of the operator. Single index only operates on 
one qubit, the double index operates on multiple *consecutive* qubits.

In general the operation is

\$ I \\otimes \\dots \\otimes G_q \\otimes \\dots 
\\otimes G_p \\otimes \\dots \\otimes I \$
"""
function Op(G::Array{ComplexF64}, q::Int64, reg::Register)
 
    # Create pre-gate Identity
    op = zeros(ComplexF64, 2^(q-1), 2^(q-1)) + I

    # Operate gate G on qubit q
    op = op ⊗ G

    # Identity operations after qubit q
    ident = zeros(ComplexF64, 2, 2) + I
    for i in q+1:reg.N
        op = op ⊗ ident
    end

    reg.state = op * reg.state
end


function Op(G::Array{ComplexF64}, q::Int64, p::Int64, reg::Register)
    @assert q < p
    op = zeros(ComplexF64, 2^(q-1), 2^(q-1)) + I

    # Operate 2x2 gate G on qubits q through p
    for i in q:p
        op = op ⊗ G
    end

    # Identity operations after qubit p
    ident = zeros(ComplexF64, 2, 2) + I
    for i in p+1:reg.N
        op = op ⊗ ident
    end

    # Update register
    reg.state = op * reg.state
end


"""
Controlled gate operation
"""
# FIXME: Add case for control below gate
function cOp(G::Array{ComplexF64}, c::Int64, q::Int64, reg::Register)
    
    # Create pre-gate Identity
    if c > 1
        op = zeros(ComplexF64, 2^(c-1), 2^(c-1)) + I
    end

    # Dimension of full controlled gate
    dim = 2^((q-c)+1)
    hf = div(dim,2)

    # Fill in 2x2 gates properly 
    ident = zeros(ComplexF64, 2, 2) + I
    con = zeros(ComplexF64, dim, dim)
    for i in 1:2:hf-1
        con[i : 1+i, i : 1+i] = ident
        con[i+hf : 1+i+hf, i+hf : 1+i+hf] = G
    end

    # Complete full gate up to qubit q
    if c > 1
        op = op ⊗ con
    else
        op = con
    end


    # Identity operations after qubit q
    for i in q+1:reg.N
        op = op ⊗ ident
    end

    # Update qubit register
    reg.state = op * reg.state
end



# Wrapper functions
"""
Single Hadamard
"""
function H(N::Int64, reg::Register)
    Op(gate.H, N, reg)   
end


"""
Ranged Hadamard
"""
function H(N::Int64, M::Int64, reg::Register)
    Op(gate.H, N, M, reg)   
end
