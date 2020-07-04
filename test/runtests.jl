using Qubism
using Test
using LinearAlgebra

fac = 1.0/sqrt(2.0)

# Catch non-integers for register
@test_throws MethodError reg = Register(3.4)


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

## Hamiltonians

# Hubbard Hamiltonian test
Ham = Hilbert(4)
fermion(Ham,"1^ 1", -0.25)
fermion(Ham,"1^ 2", -2.0)
fermion(Ham,"1^ 3", -2.0 )
fermion(Ham,"2^ 1", -2.0 )
fermion(Ham,"2^ 2", -0.25 )
fermion(Ham,"2^ 4", -2.0 )
fermion(Ham,"3^ 1", -2.0 )
fermion(Ham,"3^ 3", -0.25 )
fermion(Ham,"3^ 4", -2.0 )
fermion(Ham,"4^ 2", -2.0 )
fermion(Ham,"4^ 3", -2.0 )
fermion(Ham,"4^ 4", -0.25 )
fermion(Ham,"1^ 1 2^ 2", 1.0)
fermion(Ham,"1^ 1 3^ 3", 1.0 )
fermion(Ham,"2^ 2 4^ 4", 1.0 )
fermion(Ham,"3^ 3 4^ 4", 1.0 )

@test isapprox(eigvals(Ham.mat)[1], -4.249999999999999)



## Helper functions

# Test print_smart()
mat = zeros(3,3)
vec = [1 2 3 4]
@test nothing == print_smart(mat, "Testmat")
@test nothing == print_smart(vec, "Testvec")
@test nothing == print_smart(mat)
@test_throws MethodError print_smart(mat, 234)
@test_throws MethodError print_smart(4, "Test")

# Test parse_operator_string
@test Tuple[(4, 0), (2, 0), (1, 1), (3, 1)] == parse_operator_string("3^ 1^ 2 4")
@test_throws ArgumentError parse_operator_string("3^^")






