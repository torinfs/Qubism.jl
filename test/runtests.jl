using Qubism
using Test

gate = Gates()
fac = 1.0/sqrt(2.0)

# N = 2 systems

# Bell state
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = fac; ans[4] = fac

Op(gate.H, 1, reg)
cOp(gate.X, 1, 2, reg)
@test isapprox(reg.state,ans)


# Double Hadamard
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = 1.0

Op(gate.H, 1, 2, reg)
Op(gate.H, 1, 2, reg)
@test isapprox(reg.state,ans)



