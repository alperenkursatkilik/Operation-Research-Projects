using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, g)
@variable(m, q1)
@variable(m, q2)
@variable(m, q3)
@variable(m, q4)

@objective(m, Min, g)

@constraint(m, 3*q1-2*q2+5*q3+7*q4 <= g)
@constraint(m, -q1+11*q2+9*q3+0*q4 <= g)
@constraint(m, 8*q1+6*q2+12*q3+9*q4 <= g)
@constraint(m, q1+q2+q3+q4 == 1)
@constraint(m, q1 >= 0)
@constraint(m, q2 >= 0)
@constraint(m, q3 >= 0)
@constraint(m, q4 >= 0)

optimize!(m)

println("g = ", value(g))
println("q1 = ", value(q1))
println("q2 = ", value(q2))
println("q3 = ", value(q3))
println("q4 = ", value(q4))