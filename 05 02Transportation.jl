using JuMP, HiGHS

"""
======================================================================
Transportation Problemi, İki Fabrika ve 4 Magaza var
Fabrikalardan Magazalara En ucuz Maliyetli Tasimanin Yolunu Bulacagiz
======================================================================
"""

m = Model(HiGHS.Optimizer)

@variable(m, x11)
@variable(m, x12)
@variable(m, x13)
@variable(m, x14)
@variable(m, x21)
@variable(m, x22)
@variable(m, x23)
@variable(m, x24)

@objective(m, 
        Min, 2*x11 + 5*x12 + 1*x13 + 6*x14 + 
             4*x21 + 2*x22 + 9*x23 + 3*x24)

@constraint(m, 
                x11 + x12 + x13 + x14 == 50) #arz kisiti: birinci fabrika 50 birim kapasite dagitmak zorunda
@constraint(m, 
                x21 + x22 + x23 + x24 ==100) #arz kisiti: ikinci fabrika 100 birim kapasite dagitmak zorunda

@constraint(m, 
                x11 +
                x21                   == 20) #talep kisiti: birinci magaza 20 birim kapasite almak zorunda
@constraint(m,      
                x12 +
                x22                   == 70) #talep kisiti: ikinci magaza 70 birim kapasite almak zorunda
@constraint(m,           x13 +
                         x23          == 50) #talep kisiti: ucuncu magaza 50 birim kapasite almak zorunda
@constraint(m,                x14 +
                              x24     == 10) #talep kisiti: dorduncu magaza 10 birim kapasite almak zorunda

variable_vector = [x11, x12, x13, x14, x21, x22, x23, x24]

@constraint(m, variable_vector .>= 0)

optimize!(m)

sonuclar = [string(v, "=", Int(value(v))) for v in variable_vector]
println(join(sonuclar, "  |  "))

#Yorum: Yoneylemci Gelmeden Once Total Cost: 750 Br idi, Yoneylemci bunu 300 Br maliyete indirdi