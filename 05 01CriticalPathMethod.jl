using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, xsa, Bin)
@variable(m, xsb, Bin)
@variable(m, xac, Bin)
@variable(m, xbc, Bin)
@variable(m, xbd, Bin)
@variable(m, xce, Bin)
@variable(m, xcd, Bin)
@variable(m, xde, Bin)
@variable(m, xefin, Bin)

@objective(m, Max, 0*xsa + 0*xsb + 3*xac + 4*xbc + 4*xbd + 5*xce + 5*xcd + 6*xde + 7*xefin)

@constraint(m, xsa + xsb == 1)
@constraint(m, xsa == xac)
@constraint(m, xsb == xbc + xbd)
@constraint(m, xac + xbc == xcd + xce)
@constraint(m, xbd + xcd == xde)
@constraint(m, xce + xde == xefin)
@constraint(m, xefin == 1)

optimize!(m)

tum_degiskenler = [xsa, xsb, xac, xbc, xbd, xce, xcd, xde, xefin]

sonuclar = [string(v, "=", Int(value(v))) for v in tum_degiskenler]
println(join(sonuclar, "  |  "))