using JuMP, HiGHS

m = Model(HiGHS.Optimizer)

@variable(m, x12)
@variable(m, x13)
@variable(m, x23)
@variable(m, x24)
@variable(m, x25)
@variable(m, x35)
@variable(m, x36)
@variable(m, x47)
@variable(m, x57)
@variable(m, x67)
@variable(m, f==70)
@objective(m, Min, 3*x12+2*x13+5*x23+2*x24+2*x25+4*x35+3*x36+7*x47+6*x57+6*x67)

@constraint(m, x12+x13 == f) #evden cikma kisiti
@constraint(m, x47+x57+x67 == f) #okula varma kisiti
@constraint(m, x12 == x23+x24+x25)
@constraint(m, x13+x23 == x35 + x36)
@constraint(m, x24 == x47)
@constraint(m, x25 + x35 == x57)
@constraint(m, x36 == x67)

# tum degiskenleri vektor olarak belirleyelim
degiskenler = [x12, x13, x23, x24, x25, x35, x36, x47, x57, x67]

# Karşılık gelen üst sınır değerleri
sinirlar =    [100, 150,  20,  80,  30,  10,  40,  20,  10, 100] 
# Noktalı eşitsizlik ile tek satırda ekleme
@constraint(m, 0 .<=degiskenler .<= sinirlar)

optimize!(m)

sonuclar = [string(v, "=", Int(value(v))) for v in degiskenler]
println(join(sonuclar, "  |  "))