export gateop
export cgateop

"""
Performs an gate operation on the register by constructing
the tensor product of the operator. Single index only operates on 
one qubit, the double index operates on multiple *consecutive* qubits.

In general the operation is

\$ I \\otimes I \\otimes \\dots G_q \\otimes \\dots \\otimes G_p 
\\otimes I \\otimes \\dots \\otimes I \$

"""
function gateop(G::Array{ComplexF64}, q::Int64, reg::Register)
    op = zeros(ComplexF64, 2^(q-1), 2^(q-1)) + I
    op = op ⊗ G

    # Identity operations after qubit q
    ident = zeros(ComplexF64, 2, 2) + I
    for i in q+1:reg.N
        op = op ⊗ ident
    end

    reg.psi = op * reg.psi
end


function gateop(G::Array{ComplexF64}, q::Int64, p::Int64, reg::Register)
    @assert q < p
    op = zeros(ComplexF64, 2^(q-1), 2^(q-1)) + I

    for i in q:p
        op = op ⊗ G
    end

    # Identity operations after qubit q
    ident = zeros(ComplexF64, 2, 2) + I
    for i in p+1:reg.N
        op = op ⊗ ident
    end

    reg.psi = op * reg.psi
end


"""
Controlled gate operation
"""
function cgateop(G::Array{ComplexF64}, c::Int64, q::Int64, reg::Register)
    if c > 1
        op = zeros(ComplexF64, 2^(c-1), 2^(c-1)) + I
    end

    dim = 2^((q-c)+1)
    hfdim = div(dim,2)
    ident = zeros(ComplexF64, 2, 2) + I
    con = zeros(ComplexF64, dim, dim)
    for i in 1:2:hfdim-1
        con[i : 1+i, i : 1+i] = ident
        con[i+hfdim : 1+i+hfdim, i+hfdim : 1+i+hfdim] = G
    end

    if c > 1
        op = op ⊗ con
    else
        op = con
    end


    # Identity operations after qubit q
    for i in q+1:reg.N
        op = op ⊗ ident
    end

    display(op)

    reg.psi = op * reg.psi

end
