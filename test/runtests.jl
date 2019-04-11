using Qubism
using Test

gate = Gates()
fac = 1.0/sqrt(2.0)

# Catch non-integers for register
@test_throws AssertionError reg = Register(3.4)


# N = 2 systems

# Bell state circuit
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = fac; ans[4] = fac

Op(gate.H, 1, reg)
cOp(gate.X, 1, 2, reg)
@test isapprox(reg.state,ans)

# Make range Op function is not negative
@test_throws AssertionError Op(gate.H, 2, 1, reg)

# Double Hadamard circuit
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = 1.0

Op(gate.H, 1, 2, reg)
Op(gate.H, 1, 2, reg)
@test isapprox(reg.state,ans)


# N = 4 systems

# H(all) - Y(3) - CNOT(2,3) - H(all)
reg = Register(4)
ans = zeros(ComplexF64,16)
ans[7] += -im

Op(gate.H, 1, 4, reg)
Op(gate.Y, 3, reg)
cOp(gate.X, 2, 3, reg)
Op(gate.H, 1, 4, reg)
@test isapprox(reg.state,ans)
