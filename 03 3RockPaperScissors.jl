using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, g)
@variable(m, p1)
@variable(m, p2)
@variable(m, p3)

@objective(m, Max, g)

@constraint(m, 0*p1+p2-p3 >= g)
@constraint(m, -p1+0*p2+p3 >= g)
@constraint(m, p1-p2+0*p3 >= g)
@constraint(m, p1+p2+p3 == 1)
@constraint(m, p1 >= 0)
@constraint(m, p2 >= 0)
@constraint(m, p3 >= 0)

optimize!(m)

println("g = ", value(g))
println("p1 = ", value(p1))
println("p2 = ", value(p2))
println("p3 = ", value(p3))
