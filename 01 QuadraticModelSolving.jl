using Random
using Statistics

Random.seed!(42)

dolar = randn(30).*0.35.+0.10
euro = randn(30).*0.30.+0.05
altin = randn(30).*0.80.+0.20

w = [dolar euro altin]

varkov_matrisi = cov(w)

using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, x1)
@variable(m, x2)
@variable(m, x3)

@objective(m, Min, x1^2 * varkov_matrisi[1, 1] + x2^2 * varkov_matrisi[2, 2] + x3^2 * varkov_matrisi[3, 3] +
    2 * x1 * x2 * varkov_matrisi[1, 2] + 2 * x1 * x3 * varkov_matrisi[1, 3] + 2 * x2 * x3 * varkov_matrisi[2, 3])

    @constraint(m, x1 + x2 + x3 == 1)
    @constraint(m, x1 >= 0)
    @constraint(m, x2 >= 0)
    @constraint(m, x3 >= 0)
    @constraint(m, x1 <= 1)
    @constraint(m, x2 <= 1)
    @constraint(m, x3 <= 1)
    @constraint(m, x1 * mean(dolar) + x2 * mean(euro) + x3 * mean(altin) >= 0.15)

optimize!(m)

value(x1), value(x2), value(x3)

toplam = value(x1) + value(x2) + value(x3)
println("Toplam: ", toplam)