#-------------------------------------------------
#-------------------------------------------------
#ODEVIN ADI: INSAN NEREYE GIDECEGINI BILIR ILKKAN
#-------------------------------------------------
#-------------------------------------------------

using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, x12 , Bin)
@variable(m, x13 , Bin)
@variable(m, x23 , Bin)
@variable(m, x24 , Bin)
@variable(m, x25 , Bin)
@variable(m,x35 , Bin)
@variable(m,x36 , Bin)
@variable(m,x45 , Bin)
@variable(m,x47 , Bin)
@variable(m,x57 , Bin)
@variable(m,x65 , Bin)
@variable(m,x67 , Bin)

@objective(m, Min, 3*x12+4*x13+2*x23+7*x25+5*x24+6*x35+5*x36+3*x45+6*x47+8*x57+2*x65+7*x67)


@constraint(m, x12+x13 == 1) #evden cikma kisiti
@constraint(m, x47+x57+x67 == 1) #okula varmis olma kisiti
#diger kisitlar
@constraint(m, x12 == x23+x24+x25) #2'ye geldiysem 2'den gitmeliyim kisiti
@constraint(m, x13+x23 == x35+x36) #3'e geldiysem 3'ten gitmeliyim kisiti
@constraint(m, x24 == x45 + x47)   #4'e geldiysem 4'ten gitmeliyim kisiti
@constraint(m, x25+x35+x45+x65 == x57)         #5'e geldiysem 5'ten gitmeliyim kisiti
@constraint(m, x36 == x65 + x67)   #6'ya geldiysem 6'dan gitmeliyim kisiti

optimize!(m)

tum_degiskenler = [x12, x13, x23, x24, x25, x35, x36, x45, x47, x57, x65, x67]

sonuclar = [string(v, "=", Int(value(v))) for v in tum_degiskenler]
println(join(sonuclar, "  |  "))