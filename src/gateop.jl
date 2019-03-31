export GateOp

function GateOp(G::Array{ComplexF64}, q::Int64, reg::Register)
    op = zeros(ComplexF64, 2^(q-1), 2^(q-1)) + I
    op = op ⊗ G

    # Identity operations after qubit q
    ident = zeros(ComplexF64, 2, 2) + I
    for i in q+1:reg.N
        op = op ⊗ ident
    end

    reg.psi = op * reg.psi
end

#function GateOp(G::Array{ComplexF64}, q::Int64, p::Int64, reg::Register)
#    preI = zeros(2^q, 2^q) + I
#    display(preI)
#
#    for i in q:reg.N
#        a = 2+i
#    end
#end
