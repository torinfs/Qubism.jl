using Qubism
using Test

fac = 1.0/sqrt(2.0)

# Catch non-integers for register
@test_throws AssertionError reg = Register(3.4)


# N = 2 systems

# Bell state circuit
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = fac; ans[4] = fac

SOp(H, 1, reg)
COp(X, 1, 2, reg)
@test isapprox(reg.state,ans)

# Make range Op function is not negative
@test_throws AssertionError SOp(H, 2, 1, reg)

# Double Hadamard circuit
reg = Register(2)
ans = zeros(ComplexF64,4)
ans[1] = 1.0

SOp(H, 1, 2, reg)
SOp(H, 1, 2, reg)
@test isapprox(reg.state,ans)


# N = 4 systems

# H(all) - Y(3) - CNOT(2,3) - H(all)
reg = Register(4)
ans = zeros(ComplexF64,16)
ans[7] += -im

SOp(H, 1, 4, reg)
SOp(Y, 3, reg)
COp(X, 2, 3, reg)
SOp(H, 1, 4, reg)
@test isapprox(reg.state,ans)

# H(1,2) - Z(1,2) - H(3) - SWAP(1,4)
reg = Register(4)
ans = zeros(ComplexF64,16)
fac = 0.35355339059327345
ans = [fac + 0.0im
      -fac + 0.0im
       fac + 0.0im
      -fac + 0.0im
      -fac + 0.0im
       fac + 0.0im
      -fac + 0.0im
       fac + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im
       0.0 + 0.0im]

SOp(H, 1, 2, reg)
SOp(Z, 1, 2, reg)
SOp(H, 3, reg)
SWAP(1, 4, reg)
@test isapprox(reg.state,ans)


## Helper functions

# Test printSmart()
mat = zeros(3,3)
vec = [1 2 3 4]
@test nothing == printSmart(mat, "Testmat")
@test nothing == printSmart(vec, "Testvec")
@test nothing == printSmart(mat)
@test_throws MethodError printSmart(mat, 234)
@test_throws MethodError printSmart(4, "Test")









