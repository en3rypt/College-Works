
import sympy    #SYMPY library to solve laplace and inverse laplace programs

#laplace Transform function definition
def L(f):
    return sympy.laplace_transform(f, t, s, noconds=True)



#inverselaplase transform definition
def invL(F):
    return sympy.inverse_laplace_transform(F, s, t, noconds=True)



#Symbols definition 
t, s = sympy.symbols('t, s')
x = sympy.symbols('x', real=True, positive=True)
exp = sympy.exp


functions = [
    48,
    +24*sympy.Heaviside(t-10),
    -24*sympy.Heaviside(t-20),
]

y =[str(L(f)) for f in functions]

aa="+".join(y)

print(aa)

F=1/((s)*(s+(3/125)))


infunctions =[
    1000*(1/(s+(3/125))),
    48/((s)*(s+(3/125))),
    24*exp(-10*s)/((s)*(s+(3/125))),
    -24*exp(-20*s)/((s)*(s+(3/125))),
    ]

LI=[]
for inf in infunctions:
    LI.append(str(invL(inf)))

XX="+".join(LI)

inv=1000*(1/(s+(3/125)))+48/((s)*(s+(3/125)))+24*exp(-10*s)/((s)*(s+(3/125)))-24*exp(-20*s)/((s)*(s+(3/125)))

FF=invL(inv)

XX1=FF.subs({t:10})



print(XX)

print(round(XX1,4))





