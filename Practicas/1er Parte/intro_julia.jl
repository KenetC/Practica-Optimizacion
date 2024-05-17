### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ db4b1043-c7ed-4ecc-8399-130c2f8215cb
# ╠═╡ disabled = true
#=╠═╡
using BenchmarkTools
  ╠═╡ =#

# ╔═╡ 526dfcf0-456f-4dfa-ae08-3e1e0f89b9af
# ╠═╡ disabled = true
#=╠═╡
using LinearAlgebra
  ╠═╡ =#

# ╔═╡ 43cc7453-e513-4726-8d0e-d6aad9e347ce
# ╠═╡ disabled = true
#=╠═╡
begin
	using Random
	using Random: seed!
end
  ╠═╡ =#

# ╔═╡ 33c36924-e49f-4dd6-b920-e93bdb33a584
# ╠═╡ disabled = true
#=╠═╡
using Plots
  ╠═╡ =#

# ╔═╡ 3f22e159-451b-4f89-a509-ba455f498c7f
begin
	using PlutoUI
	TableOfContents()
end

# ╔═╡ b4326862-dc79-11ee-310e-012976d8abde
md"""
# Introducción a Julia
"""

# ╔═╡ 9ab11aa2-24a8-416e-9407-367951d5075a
md"""
## ¿Por qué Julia?

Julia es un lenguaje de código abierto, dinámico y de alto rendimiento. Al aprovechar un diseño inteligente en torno a un compilador just in time (JIT), Julia logra combinar la velocidad de lenguajes como C o Fortran con la facilidad de uso de Matlab o Python.
"""

# ╔═╡ 84ea2d2d-e6b3-4cc9-9abf-553b4482ba64
md"""
Aquí expondremos los aspectos básicos de Julia, pero siempre puede recurrir a la documentacón oficial de Julia. Como también a los siguientes links de interés:
* [Documentación](https://docs.julialang.org/en/v1/)
* [Tutorial por Martín Maas](https://www.matecdev.com/posts/julia-tutorial-science-engineering.html)
* [MATLAB--Python--Julia cheatsheet](https://cheatsheets.quantecon.org/index.html)
"""

# ╔═╡ 6b1012a8-b313-42a6-b5ee-b7c0bd49d041
md"""
!!! tip "Ventajas"
	* **Sintaxis intuitiva y flexible:** Julia fue diseñado para ser fácil de usar y potente al mismo tiempo. Julia proporciona una sintaxis muy intuitiva y admite muchos conceptos útiles de otros lenguajes, como los generadores de Python.
	* **Rendimiento:** dado que Julia es un lenguaje compilado, el código en Julia es generalmente más rápido que el código escrito en Python o Matlab puro.
	* **Multiple Dispatch**: Significa que una función consta de múltiples métodos que pueden diferir en la cantidad de argumentos de entrada o su tipo. Cuando se llama a una función, se ejecuta la definición de método más específica que coincida con el número y los tipos de argumento. Esto permite definir funciones generales, en lugar de usar nombres de funciones específicas.
"""

# ╔═╡ bb582a5f-a323-4183-97ad-fc60a8855898
md"""
!!! warning "Desventajas"
	* **Número limitado de paquetes:** aunque Julia crece rápidamente y hay muchos paquetes, no puede competir con la cantidad de paquetes disponibles en Python o R. Sin embargo, Julia proporciona una forma sencilla de interactuar con otros lenguajes. Si no hay un paquete adecuado en Julia, es posible utilizar paquetes de otros idiomas.
	* **Primera ejecución lenta:** dado que Julia usa compilación just in time, la primera llamada de cada función es más lenta debido a la compilación. Esta desaceleración puede ser significativa si se llaman varias funciones por primera vez. Esto incluye la creación de un gráfico en una nueva sesión de Julia porque los paquetes para trazar son grandes y utilizan muchas funciones. El resultado es mucho tiempo hasta el primer gráfico (~20 s con Plots.jl).
"""

# ╔═╡ 9432100c-ebc2-4482-a6ab-a93de3f39e7c
md"""
### Sintaxis intuitiva y flexible
Julia proporciona una sintaxis muy intuitiva y flexible, que permite a los usuarios escribir funciones relativamente complicadas de una manera sencilla y legible. Como ejemplo, podemos comparar la definición de la función que calcula el número de Fibonacci. Una implementación en Matlab de esta función podría ser:
```Matlab
function f = fib(n)
    if n < 2
        f = n;
    else
        f = fib(n-1) + fib(n-2);
    end
end
```
Mientras que en Python podría ser
```python
def fib(n):
    return n if n<2 else fib(n-1) + fib(n-2)
```
En Julia esta sintaxis puede ser más simple:
"""

# ╔═╡ 7b444b48-c22c-489b-9e19-beca9e36a201
fib(n::Int) = n < 2 ? n : fib(n-1) + fib(n-2)

# ╔═╡ a351d29a-b16b-4b4e-ad0f-dd2635c27027
md"""
Al mismo tiempo, es posible utilizar la sintaxis tradicional de declaración de funciones multilínea.
```julia
function fib(n::Int)
    if n < 2
        return n
    else
        return fib(n-1) + fib(n-2)
    end
end
```
"""

# ╔═╡ d7a4b008-1e4f-492d-8947-a41afff37559
md"""
La anotación del tipo de argumento de entrada y la palabra clave de retorno son opcionales y ambas pueden omitirse. Por lo tanto, Julia admite diferentes sintaxis para definir funciones. Esto es muy útil porque es posible escribir funciones simples en una línea o usar una sintaxis multilínea para funciones más complicadas. Además, los autores de Julia se inspiraron en otros idiomas y Julia proporciona muchas funciones útiles conocidas en otros idiomas:
* La sintaxis de las operaciones matriciales está inspirada en Matlab.
* Los paquetes estadísticos utilizan una sintaxis similar a la de los paquetes R.
* Es posible utilizar generadores y listas por comprensión como en Python.
"""

# ╔═╡ e7233d76-5890-4a57-a220-40740991af72
md"""
### Performance
Una de las ventajas más obvias de Julia es su velocidad. Dado que Julia utiliza la compilación just in time, es posible lograr el rendimiento de C sin utilizar ningún truco o paquete especial. Se puede encontrar ejemplos de esto en [Julia Micro-Benchmarks](https://julialang.org/benchmarks/) o [aquí](https://www.matecdev.com/posts/julia-performance-checklist.html).
"""

# ╔═╡ b9482f66-640c-4d8d-8fa5-20810c9abaeb
md"""
[performance en Python](https://colab.research.google.com/drive/1AQAoprkDxJtY08wDXRQ8fPXbIgF-klt3?usp=sharing)
"""

# ╔═╡ 5d49ccc0-22f3-4d3f-8a6e-6119a8ab92e0
# ╠═╡ disabled = true
#=╠═╡
function estimate_pi(n)
    n_circle = 0
    for i in 1:n
        x = 2*rand() - 1
        y = 2*rand() - 1
        if sqrt(x^2 + y^2) <= 1
           n_circle += 1
        end
    end
    return 4*n_circle/n
end
  ╠═╡ =#

# ╔═╡ c22d5215-711d-4495-aae4-c97ea00f3b95
# ╠═╡ disabled = true
#=╠═╡
n=1000000
  ╠═╡ =#

# ╔═╡ 3bdd8245-3dbb-46e3-a1cf-791c85574bc7
#=╠═╡
@time estimate_pi(n)
  ╠═╡ =#

# ╔═╡ f019caa9-6a83-42a0-85e9-91f26b523970
md"""
## Instalación
Julia se puede instalar desde la [página oficial](https://julialang.org/). 

Es posible escribir códigos Julia en cualquier editor de texto y ejecutarlos directamente desde la terminal. Sin embargo, normalmente es mejor utilizar un IDE que proporcione funciones adicionales, como resaltado de sintaxis o sugerencias de código. Por ejemplo podemos usar Visual Studio Code, un editor de código fuente gratuito creado por Microsoft. Admite muchos lenguajes de programación (Julia, Python, LaTex,...) mediante extensiones. El editor está disponible en la [página oficial](https://code.visualstudio.com/download).
"""

# ╔═╡ eba93ce6-f083-47a5-bf94-c02d60cb9d0b
md"""
---
"""

# ╔═╡ 2c6111bd-5bd5-4e2a-8994-eb26c55b5471
md"""
## Instalación de paquetes
"""

# ╔═╡ f5ec0d53-3bd5-4829-8d05-28f42f614a49
md"""
Julia proporciona una gran biblioteca de paquetes. Para agregar un paquete, desde el REPL introducimos un ] e instalamos un paquete con la palabra clave agregar.
```julia
pkg> add Plots
```
o
```julia
julia> using Pkg
julia> Pkg.add("Plots")
```
Algunos paquetes ya vienen con Julia pero tanto estos como los que isntalemos antes debemos cargarlos para poder usarlos.
"""

# ╔═╡ 25ca2aaa-b74b-43ee-9deb-e1f310e79848
# ╠═╡ disabled = true
#=╠═╡
B = [1 2 3;0 1 0;2 2 1]
  ╠═╡ =#

# ╔═╡ e323d321-46d1-4405-8174-93b9e01ce2ff
#=╠═╡
det(B)
  ╠═╡ =#

# ╔═╡ d21c4c93-3211-4990-a80c-ad69e5886ad2
# ╠═╡ disabled = true
#=╠═╡
inv(B)
  ╠═╡ =#

# ╔═╡ b170a25d-83d4-41dd-9425-2ab24f250699
#=╠═╡
seed!(1234);
  ╠═╡ =#

# ╔═╡ 8a8ff29f-c111-4c7d-b601-f1996bdb131d
# ╠═╡ disabled = true
#=╠═╡
rand(2)
  ╠═╡ =#

# ╔═╡ 034ed68c-53df-47ff-bb69-2fdc64d712c4
md"""
---
"""

# ╔═╡ 3fe95409-4175-43cd-88e9-e09466e84940
md"""
## Arrays
"""

# ╔═╡ cd634a12-9428-48a9-875e-20f703b9b612
md"""
La forma más conveniente de ingresar una matriz es usar columnas separadas por espacios en blanco y punto y coma para las filas, de la siguiente manera
"""

# ╔═╡ 010aa605-152e-41f4-bccc-e348c3201a19
# ╠═╡ disabled = true
#=╠═╡
A = [1 2 3; 1 2 4; 2 2 2] 
  ╠═╡ =#

# ╔═╡ 38d399d6-7d4a-4415-820f-b3742fcfab8f
# ╠═╡ disabled = true
#=╠═╡
A_bis = [1 2 3; 
     1 2 4; 
     2 2 2]  
  ╠═╡ =#

# ╔═╡ 274096bd-2e01-40c9-a80c-ab222ed5c55b
md"""
En cuanto a la entrada de vectores, cada elemento se puede separar mediante comas o punto y coma. Sin embargo, tenga en cuenta que separar las entradas con espacios en blanco dará como resultado una matriz de 1x3, que para Julia es un tipo de entidad diferente a un vector.
"""

# ╔═╡ a11981c0-ce48-4949-bb10-af6df6653066
# ╠═╡ disabled = true
#=╠═╡
b1 = [4.0, 5, 6]   
  ╠═╡ =#

# ╔═╡ 9a3505d9-34dd-4e1d-b6c5-48272ae1ba93
# ╠═╡ disabled = true
#=╠═╡
b2 = [4.0; 5; 6]    
  ╠═╡ =#

# ╔═╡ 662fd73d-8904-4893-9142-a43597752ef0
# ╠═╡ disabled = true
#=╠═╡
m1 = [4.0 5 6] 
  ╠═╡ =#

# ╔═╡ c2c9fc15-7f27-4d82-b0a4-481f74c743fb
md"""
Julia también admite matrices de tipos no numéricos como Cadenas, o incluso matrices de Cualquiera, que podrían incluir cadenas y números, y se pueden inicializar como:
"""

# ╔═╡ dfca2a45-c7ea-47ba-8cfc-2d3a4620c51c
# ╠═╡ disabled = true
#=╠═╡
C = ["Hello", 1, 2, 3]
  ╠═╡ =#

# ╔═╡ a10e58a2-c025-47f6-9ae9-3c9b5d963ae1
md"""
Una forma muy concisa de inicializar y formar matrices es recurrir a las llamadas comprensiones de matrices.
"""

# ╔═╡ 7bc8c5b3-e59e-49d2-b8f2-8a508c83187f
#=╠═╡
v = [1/n^2 for n=1:100000]
  ╠═╡ =#

# ╔═╡ b75d3ef0-76ec-45e5-9cf0-f38cab595f0a
md"""
Si queremos inicializar una matriz por ejemplo, por motivos de rendimiento, es aconsejable inicializar matrices de un tipo (y tamaño) determinado, sin especificar ningún valor. Es decir, ni siquiera inicializar una nueva matriz con ceros.

Lo que sucede cuando declaramos una matriz `undef` es que una cierta porción de memoria se reserva (o asigna) para este uso específico. Como el ordenador ni siquiera llena esa porción de memoria con ceros, estamos ahorrando algo de tiempo.

```julia
n = 5
A1 = Array{Float64}(undef,n,n)          # 5×5 Matrix{Float64}
A2 = Matrix{Float64}(undef,n,n)         # 5×5 Matrix{Float64}

V1 = Array{Float64}(undef,n)            # 5-element Vector{Float64}
V2 = Vector{Float64}(undef,n)           # 5-element Vector{Float64}
```
"""

# ╔═╡ 3ea6f4ff-3d77-4f77-a907-00aa1b54fe3e
# ╠═╡ disabled = true
#=╠═╡
A2 = Matrix{Float64}(undef,5,5)
  ╠═╡ =#

# ╔═╡ bb619266-6bc4-45e5-b69a-625ca17caaa1
md"""
Por otras razones, podriamos necesitar matrices o vectores vacios.
"""

# ╔═╡ 68d49871-78bd-41ee-8446-91249ece09ff
# ╠═╡ disabled = true
#=╠═╡
v1 = Array{Float64}(undef,0) #o v = Float64[] 
#Ojo con v1=[]
  ╠═╡ =#

# ╔═╡ 8d7c958f-4e5e-48e2-908a-d2491d1b28fb
md"""
Para indexar arreglos hacemos lo siguiente:
"""

# ╔═╡ a3234313-3734-48e2-a58d-60d672de48e6
# ╠═╡ disabled = true
#=╠═╡
D=rand(4,4)
  ╠═╡ =#

# ╔═╡ fe0b9ee2-c345-49c7-867d-43905e17d40f
# ╠═╡ disabled = true
#=╠═╡
D[1,2] #o D[1:2,3:4] o D[ D .< 0.5 ] .= 0
  ╠═╡ =#

# ╔═╡ 05a7c95a-248e-4c0c-becd-cc6f8cba06f7
#=╠═╡
for i ∈ 1:size(D,1), j ∈ 1:size(D,2)
   println(string("i=$(i) j=$(j) D[i,j]=$(D[i,j])"))
end
  ╠═╡ =#

# ╔═╡ 886f45c0-26c5-4ebd-a2cf-10ca79c4c309
md"""
Ahora si queremos operar con vectores y matrices:
"""

# ╔═╡ a07eeae0-a41c-4bba-bbd1-2f6ffec9e951
# ╠═╡ disabled = true
#=╠═╡
begin
	x = rand(100)
	y = rand(100)
end
  ╠═╡ =#

# ╔═╡ 3b2e4ac1-d1eb-488a-9eff-d3b8460c7c06
#=╠═╡
z=dot(x,y) #o x'y
  ╠═╡ =#

# ╔═╡ ea940181-1167-470f-8c55-9ca415ce3327
# ╠═╡ disabled = true
#=╠═╡
E=rand(2,2)
  ╠═╡ =#

# ╔═╡ 89a83767-7643-4055-8f68-8c0377556643
# ╠═╡ disabled = true
#=╠═╡
E*[1,0]
  ╠═╡ =#

# ╔═╡ 215b8560-98c2-43a2-88b3-2ceece763b18
#=╠═╡
E*E' #Si quiero escalar contra escalar hago *.
  ╠═╡ =#

# ╔═╡ 54359c18-d380-4eb7-a6c4-19c9259a18f6
md"""
Para resolver sistemas usamos la notación estilo MATLAB

```julia
b1 = [4.0, 5, 6]                # 3-element Vector{Float64}
b2 = [4.0; 5; 6]                # 3-element Vector{Float64}
m1 = [4.0 5 6]                  # 1×3 Matrix{Float64}

x=A\b1                          # Solves A*x=b
x=A\b2                          # Solves A*x=b  
x=A\m1                          # Error!!
```
"""

# ╔═╡ 3597e0c7-e2a0-4f14-9c46-ca4391348af3
md"""
Finalmente, otra operación clave es la de concatenar arreglos
"""

# ╔═╡ 52c13975-a864-4add-9227-75175e9a1a8b
# ╠═╡ disabled = true
#=╠═╡
begin 
	F = [4 5 6] 
	G = [6 7 8]
end
  ╠═╡ =#

# ╔═╡ 796576a6-3852-44ff-86a5-206bb6a1ddac
# ╠═╡ disabled = true
#=╠═╡
vcat(F,G)
  ╠═╡ =#

# ╔═╡ 5dbec593-c6fc-4be8-9377-52d0c83470ca
# ╠═╡ disabled = true
#=╠═╡
hcat(F,G)
  ╠═╡ =#

# ╔═╡ f7611478-cf81-4849-9374-16f1ad631126
# ╠═╡ disabled = true
#=╠═╡
[F;G]
  ╠═╡ =#

# ╔═╡ 188f3cb9-51dc-49f9-a9b6-286aa70e6d98
# ╠═╡ disabled = true
#=╠═╡
[F G]
  ╠═╡ =#

# ╔═╡ 471cc8b6-98df-452c-bf9d-87847b12921c
md"""
## Funciones
"""

# ╔═╡ fbe00302-ad64-4f12-8041-95ff252c70ed
md"""
Supongamos que quiero implementar una función que devuelva la aproximación de la serie geométrica de razón r: 
```math
geom(r) = \sum_{n=1}^\infty r^n
```
"""

# ╔═╡ 9ea1640a-3fca-44a6-9bce-c047579a2531
# ╠═╡ disabled = true
#=╠═╡
function geom(r,n)
	res = 0
	for k in 1:1:n
		res = res + r^k
		#println(k)
	end
	return res
end
  ╠═╡ =#

# ╔═╡ 9c22b068-288b-4e96-a16c-c8ed180d9b84
# ╠═╡ disabled = true
#=╠═╡
geom(0.4,12.9) #o println(geom(0.5,100))
  ╠═╡ =#

# ╔═╡ 638acd36-3585-4dab-a686-c7c2cd2251d3
# ╠═╡ disabled = true
#=╠═╡
function geom2(r,n::Int)
	res = 0
	for k in 1:1:n
		res = res + r^k
		#println(k)
	end
	return res
end
  ╠═╡ =#

# ╔═╡ d9d7bd6a-ab2b-4838-ac69-91ce3b1fca0f
# ╠═╡ disabled = true
#=╠═╡
geom2(0.4,12)
  ╠═╡ =#

# ╔═╡ 6d8cf425-ddb2-4b9f-af5e-2f8c361d02c7
# ╠═╡ disabled = true
#=╠═╡
function geom3(r;n=12)
	res = 0
	for k in 1:1:n
		res = res + r^k
		#println(k)
	end
	return res
end

#se pueden agregar if
  ╠═╡ =#

# ╔═╡ 53c37283-b6f8-4e23-bc1b-b218ade239ba
# ╠═╡ disabled = true
#=╠═╡
geom3(0.4,n=19)
  ╠═╡ =#

# ╔═╡ 2937bb42-a5d5-408c-8ad3-069c86ee109b
# ╠═╡ disabled = true
#=╠═╡
geom4(r;n=10) = sum(r^k for k=1:n)
  ╠═╡ =#

# ╔═╡ 04a65196-f07e-46f1-9208-f9feed4960aa
# ╠═╡ disabled = true
#=╠═╡
geom3(0.4)
  ╠═╡ =#

# ╔═╡ 346d3dc0-577c-4ae3-a80e-7f82f7da8a71
md"""
Algo que nos puede ser de utilidad es querer aplicar una función a un vector, por ejemplo:
"""

# ╔═╡ 10ca418d-b84b-49ca-855d-f8f3382e344d
# ╠═╡ disabled = true
#=╠═╡
r=rand(3)
  ╠═╡ =#

# ╔═╡ 881ece1f-0fff-4135-bf65-5ab5be57d642
# ╠═╡ disabled = true
#=╠═╡
geom3(r)
  ╠═╡ =#

# ╔═╡ ebad048e-1fa5-4904-af0a-2f517f72d342
# ╠═╡ disabled = true
#=╠═╡
geom3.(r)
  ╠═╡ =#

# ╔═╡ 1c4bf792-c22e-4591-a9bf-2a19f0429fdc
md"""
---
"""

# ╔═╡ a8da8b14-3c8a-4cc4-8a16-87c2b0f7c442
md"""
### Multiple Dispatch
"""

# ╔═╡ a5733281-c9fb-4a11-8ef7-18cede997e79
md"""
Una de las características más distintivas de Julia se llama Multiple Distpach. En pocas palabras, es la posibilidad de tener funciones genéricas con múltiples métodos asociados, cada uno para una combinación diferente de tipos de argumentos.
"""

# ╔═╡ 3608dd25-3322-41cd-97e6-53c2cdc12e70
# ╠═╡ disabled = true
#=╠═╡
function f(v)
	x=v[1]
	y=v[2]
	return x*y
end
  ╠═╡ =#

# ╔═╡ 61edd761-adf8-46c8-a97b-164d8ce5fde6
# ╠═╡ disabled = true
#=╠═╡
function f(x,y)
	return x*y
end
  ╠═╡ =#

# ╔═╡ 1214e5b3-e896-4557-8770-c813009cd90c
# ╠═╡ disabled = true
#=╠═╡
f([4,3])
  ╠═╡ =#

# ╔═╡ c290d96b-7d48-4dd6-a727-0b66cf771368
# ╠═╡ disabled = true
#=╠═╡
f(3,4)
  ╠═╡ =#

# ╔═╡ e718da0d-025f-45f8-aa88-53d07e51a25d
# ╠═╡ disabled = true
#=╠═╡
g(x::Real) = x + 1
  ╠═╡ =#

# ╔═╡ 757d9c95-96d1-4e1b-8be6-c257caf52685
# ╠═╡ disabled = true
#=╠═╡
g(x::String) = repeat(x, 4)
  ╠═╡ =#

# ╔═╡ 87d23f82-4c3b-4596-aae3-2a8ad41f9bd7
# ╠═╡ disabled = true
#=╠═╡
g(4.1)
  ╠═╡ =#

# ╔═╡ 91685a10-41dd-4eb2-90b1-3e65ab770f35
# ╠═╡ disabled = true
#=╠═╡
g("a")
  ╠═╡ =#

# ╔═╡ fd70bd2b-f5cd-4706-b4e5-0d3ccc9f601a
# ╠═╡ disabled = true
#=╠═╡
begin
	h( x :: Int ) = "This is an Int: $(x)"
	h( x :: Float64 ) = "This is a Float: $(x)"
	h( x :: Any) = "This is a generic fallback"
end
  ╠═╡ =#

# ╔═╡ 9a851fd5-f515-4e6e-ac90-ea4b288867da
md"""
!!! note "Envio doble"
	Hasta ahora, habíamos estado discutiendo ejemplos del dispatch de Julia en el caso de las funciones de un solo argumento. Sin embargo, a diferencia 	de otros lenguajes de programación, Julia no se limita a enviar un solo 			argumento: ¡puede enviar cualquier número finito de argumentos!

	Por supuesto, se aplican los mismos principios. Podemos tener funciones de 			múltiples argumentos que se especializan en casos particulares, o podemos 			extender los tipos existentes con funciones de múltiples argumentos, todo 			mientras evitamos el uso extensivo de declaraciones if-else, y de una manera que 	fomenta la modularidad y la reutilización del código.
"""

# ╔═╡ 921c4717-3e54-42bc-8282-b0cb5c9a85b1
md"""
## Plots
"""

# ╔═╡ 9169232a-b5df-4877-91f5-50ad4dba4ae7
md"""
El paquete [Plots](https://docs.juliaplots.org/stable/) no es un paquete de trazado estándar conocido en otros lenguajes. El paquete Plots proporciona una interfaz unificada y un conjunto de herramientas para crear gráficos.

En comparación con Python o Matlab, se necesita algo de tiempo para crear el primer gráfico en una nueva sesión de Julia. En Julia, todas las funciones se compilan durante su primera ejecución, lo que ralentiza la primera ejecución.
"""

# ╔═╡ 5eadcbc7-3438-44c2-9ee1-1253d8afd75e
# ╠═╡ disabled = true
#=╠═╡
begin
	a = range(0, 2π; length = 100)
	b = sin.(a)
	plot(a, b)
end
  ╠═╡ =#

# ╔═╡ 9101fe94-e511-4589-924d-74e9344b3134
# ╠═╡ disabled = true
#=╠═╡
plot!(a, sin.(a .+ π/4))
  ╠═╡ =#

# ╔═╡ 6dfb8433-0b0f-4ab0-a5f5-e38c788d97ce
md"""
Algunos atributos:
- label: nombre de cada grafico que aparecera en la leyenda.
- xguide, yguide: nombre de los ejes.
- legend: posicion de la leyenda.
- title: titulo del plot.
- color: series color (ver documentación).
- linestyle: estilo de la linea.
- linewidth: tamaño de la linea.
"""

# ╔═╡ c40b98fc-ebe7-4a72-99b7-8a112d162c44
# ╠═╡ disabled = true
#=╠═╡
begin 
	x1=0:0.01:1
	x2=x1
	s(a,b)=a^2+b^2
end
  ╠═╡ =#

# ╔═╡ c77587ae-29c1-4055-89af-e6b69b80a1d2
# ╠═╡ disabled = true
#=╠═╡
surface(x1, x2, s)
  ╠═╡ =#

# ╔═╡ 06cfc4a4-5bf6-49b3-8db0-30c36a884148
# ╠═╡ disabled = true
#=╠═╡
plotly()
  ╠═╡ =#

# ╔═╡ 20fd8912-e36e-44c9-a01b-51f2685b2897
# ╠═╡ disabled = true
#=╠═╡
surface(x1, x2, s)
  ╠═╡ =#

# ╔═╡ 3931249b-4fea-4153-b78b-59a786c0e40a
md"""
## Estructura de Datos
"""

# ╔═╡ a10d2eea-5d25-4c57-b798-cd41c3e11c60
md"""
En Julia, la palabra clave `struct` define un nuevo tipo compuesto, basado en nombres de campo dados y, opcionalmente, tipos individuales.

De forma predeterminada, las estructuras no se pueden modificar una vez inicializadas (es decir, son inmutables a menos que se definan explícitamente como una `mutable struct`)
"""

# ╔═╡ fd6093f9-4024-4a22-9bc0-f1626c1da7de
# ╠═╡ disabled = true
#=╠═╡
struct Estudiante
    nombre::String
    edad::Int
    carrera::String
	promedio::Float64
end
  ╠═╡ =#

# ╔═╡ 57bf6e4e-b27a-4284-be0c-b02eb0eee822
md"""
Para inicializar una estructura con valores, el constructor predeterminado simplemente usa el nombre de la estructura como lo haría con una función:
"""

# ╔═╡ 95d0efb4-686e-4209-855a-4b62e5ada030
# ╠═╡ disabled = true
#=╠═╡
estudiante1 = Estudiante("Juan",27,"Matematica",9.3)
  ╠═╡ =#

# ╔═╡ 4dd535d2-3c9a-440d-b05a-9af5f24ed6c0
# ╠═╡ disabled = true
#=╠═╡
estudiante1.nombre
  ╠═╡ =#

# ╔═╡ d6a0933e-0f85-4433-abf8-2d486f9a0545
# ╠═╡ disabled = true
#=╠═╡
estudiante1.promedio
  ╠═╡ =#

# ╔═╡ bf5e0064-db20-4b80-9c44-bf96d076a82d
# ╠═╡ disabled = true
#=╠═╡
mutable struct mEstudiante
    nombre::String
    edad::Int
    carrera::String
	promedio::Float64
end
  ╠═╡ =#

# ╔═╡ 9c97d92c-5917-418d-b7bf-0a25622adc21
# ╠═╡ disabled = true
#=╠═╡
estudiante2 = mEstudiante("Pedro",26,"Datos",9.1)
  ╠═╡ =#

# ╔═╡ b9a02e5a-1d7b-4f36-8d36-c03a3cb23718
# ╠═╡ disabled = true
#=╠═╡
estudiante1.promedio = 9.5
  ╠═╡ =#

# ╔═╡ 2d23d765-b660-4200-ab30-054f4dd8c2fd
# ╠═╡ disabled = true
#=╠═╡
estudiante2.promedio = 9.5
  ╠═╡ =#

# ╔═╡ 5f09dc1f-3df1-45b7-a344-32e93131c7b5
# ╠═╡ disabled = true
#=╠═╡
estudiante2
  ╠═╡ =#

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
BenchmarkTools = "~1.5.0"
Plots = "~1.40.2"
PlutoUI = "~0.7.58"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "9450ea428e0b3b824d553d40f50a617a1707d66b"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0f748c81756f2e5e6854298f11ad8b2dfae6911a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "f1dff6729bc61f4d49e140da1af55dcd1ac97b2f"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.5.0"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a4c43f59baa34011e303e76f5c8c91bf58415aaf"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "9c4708e3ed2b799e6124b5673a712dda0b596a9b"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "0f4b5d62a88d8f59003e43c25a8a90de9eb76317"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.18"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Format]]
git-tree-sha1 = "f3cf88025f6d03c194d73f5d13fee9004a108329"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.6"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "3437ade7073682993e092ca570ad68a2aba26983"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.3"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a96d5c713e6aa28c242b0d25c1347e258d6541ab"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.3+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "3ec2a90c4b4d8e452bfd16ad9f6cb09b78256bce"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.78.3+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "db864f2d91f68a5912937af80327d288ea1f3aee"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.3"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3336abae9a713d2210bb57ab484b1e065edd7d23"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "cad560042a7cc108f5a4c24ea1431a9221f22c1b"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.2"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0a04a1318df1bf510beb2562cf90fb0c386f58c4"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.39.3+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "18144f3e9cbe9b15b070288eef858f71b291ce37"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.27"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "af81a32750ebc831ee28bdaaba6e1067decef51e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60e3045590bd104a16fefb12836c00c0ef8c7f8c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.13+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "3c403c6590dd93b36752634115e20137e79ab4df"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.40.2"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "3caa21522e7efac1ba21834a03734c57b4611c7e"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.4"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "07e470dabc5a6a4254ffebc29a1b3fc01464e105"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "31c421e5516a6248dfb22c194519e37effbf1f30"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─b4326862-dc79-11ee-310e-012976d8abde
# ╟─9ab11aa2-24a8-416e-9407-367951d5075a
# ╟─84ea2d2d-e6b3-4cc9-9abf-553b4482ba64
# ╟─6b1012a8-b313-42a6-b5ee-b7c0bd49d041
# ╟─bb582a5f-a323-4183-97ad-fc60a8855898
# ╟─9432100c-ebc2-4482-a6ab-a93de3f39e7c
# ╠═7b444b48-c22c-489b-9e19-beca9e36a201
# ╟─a351d29a-b16b-4b4e-ad0f-dd2635c27027
# ╟─d7a4b008-1e4f-492d-8947-a41afff37559
# ╟─e7233d76-5890-4a57-a220-40740991af72
# ╟─b9482f66-640c-4d8d-8fa5-20810c9abaeb
# ╠═5d49ccc0-22f3-4d3f-8a6e-6119a8ab92e0
# ╠═db4b1043-c7ed-4ecc-8399-130c2f8215cb
# ╠═c22d5215-711d-4495-aae4-c97ea00f3b95
# ╠═3bdd8245-3dbb-46e3-a1cf-791c85574bc7
# ╟─f019caa9-6a83-42a0-85e9-91f26b523970
# ╟─eba93ce6-f083-47a5-bf94-c02d60cb9d0b
# ╟─2c6111bd-5bd5-4e2a-8994-eb26c55b5471
# ╟─f5ec0d53-3bd5-4829-8d05-28f42f614a49
# ╠═526dfcf0-456f-4dfa-ae08-3e1e0f89b9af
# ╠═25ca2aaa-b74b-43ee-9deb-e1f310e79848
# ╠═e323d321-46d1-4405-8174-93b9e01ce2ff
# ╠═d21c4c93-3211-4990-a80c-ad69e5886ad2
# ╠═43cc7453-e513-4726-8d0e-d6aad9e347ce
# ╠═b170a25d-83d4-41dd-9425-2ab24f250699
# ╠═8a8ff29f-c111-4c7d-b601-f1996bdb131d
# ╟─034ed68c-53df-47ff-bb69-2fdc64d712c4
# ╟─3fe95409-4175-43cd-88e9-e09466e84940
# ╟─cd634a12-9428-48a9-875e-20f703b9b612
# ╠═010aa605-152e-41f4-bccc-e348c3201a19
# ╠═38d399d6-7d4a-4415-820f-b3742fcfab8f
# ╟─274096bd-2e01-40c9-a80c-ab222ed5c55b
# ╠═a11981c0-ce48-4949-bb10-af6df6653066
# ╠═9a3505d9-34dd-4e1d-b6c5-48272ae1ba93
# ╠═662fd73d-8904-4893-9142-a43597752ef0
# ╟─c2c9fc15-7f27-4d82-b0a4-481f74c743fb
# ╠═dfca2a45-c7ea-47ba-8cfc-2d3a4620c51c
# ╟─a10e58a2-c025-47f6-9ae9-3c9b5d963ae1
# ╠═7bc8c5b3-e59e-49d2-b8f2-8a508c83187f
# ╟─b75d3ef0-76ec-45e5-9cf0-f38cab595f0a
# ╠═3ea6f4ff-3d77-4f77-a907-00aa1b54fe3e
# ╟─bb619266-6bc4-45e5-b69a-625ca17caaa1
# ╠═68d49871-78bd-41ee-8446-91249ece09ff
# ╟─8d7c958f-4e5e-48e2-908a-d2491d1b28fb
# ╠═a3234313-3734-48e2-a58d-60d672de48e6
# ╠═fe0b9ee2-c345-49c7-867d-43905e17d40f
# ╠═05a7c95a-248e-4c0c-becd-cc6f8cba06f7
# ╟─886f45c0-26c5-4ebd-a2cf-10ca79c4c309
# ╠═a07eeae0-a41c-4bba-bbd1-2f6ffec9e951
# ╠═3b2e4ac1-d1eb-488a-9eff-d3b8460c7c06
# ╠═ea940181-1167-470f-8c55-9ca415ce3327
# ╠═89a83767-7643-4055-8f68-8c0377556643
# ╠═215b8560-98c2-43a2-88b3-2ceece763b18
# ╟─54359c18-d380-4eb7-a6c4-19c9259a18f6
# ╟─3597e0c7-e2a0-4f14-9c46-ca4391348af3
# ╠═52c13975-a864-4add-9227-75175e9a1a8b
# ╠═796576a6-3852-44ff-86a5-206bb6a1ddac
# ╠═5dbec593-c6fc-4be8-9377-52d0c83470ca
# ╠═f7611478-cf81-4849-9374-16f1ad631126
# ╠═188f3cb9-51dc-49f9-a9b6-286aa70e6d98
# ╟─471cc8b6-98df-452c-bf9d-87847b12921c
# ╟─fbe00302-ad64-4f12-8041-95ff252c70ed
# ╠═9ea1640a-3fca-44a6-9bce-c047579a2531
# ╠═9c22b068-288b-4e96-a16c-c8ed180d9b84
# ╠═638acd36-3585-4dab-a686-c7c2cd2251d3
# ╠═d9d7bd6a-ab2b-4838-ac69-91ce3b1fca0f
# ╠═6d8cf425-ddb2-4b9f-af5e-2f8c361d02c7
# ╠═53c37283-b6f8-4e23-bc1b-b218ade239ba
# ╠═2937bb42-a5d5-408c-8ad3-069c86ee109b
# ╠═04a65196-f07e-46f1-9208-f9feed4960aa
# ╟─346d3dc0-577c-4ae3-a80e-7f82f7da8a71
# ╠═10ca418d-b84b-49ca-855d-f8f3382e344d
# ╠═881ece1f-0fff-4135-bf65-5ab5be57d642
# ╠═ebad048e-1fa5-4904-af0a-2f517f72d342
# ╟─1c4bf792-c22e-4591-a9bf-2a19f0429fdc
# ╟─a8da8b14-3c8a-4cc4-8a16-87c2b0f7c442
# ╟─a5733281-c9fb-4a11-8ef7-18cede997e79
# ╠═3608dd25-3322-41cd-97e6-53c2cdc12e70
# ╠═1214e5b3-e896-4557-8770-c813009cd90c
# ╠═61edd761-adf8-46c8-a97b-164d8ce5fde6
# ╠═c290d96b-7d48-4dd6-a727-0b66cf771368
# ╠═e718da0d-025f-45f8-aa88-53d07e51a25d
# ╠═757d9c95-96d1-4e1b-8be6-c257caf52685
# ╠═87d23f82-4c3b-4596-aae3-2a8ad41f9bd7
# ╠═91685a10-41dd-4eb2-90b1-3e65ab770f35
# ╠═fd70bd2b-f5cd-4706-b4e5-0d3ccc9f601a
# ╟─9a851fd5-f515-4e6e-ac90-ea4b288867da
# ╟─921c4717-3e54-42bc-8282-b0cb5c9a85b1
# ╟─9169232a-b5df-4877-91f5-50ad4dba4ae7
# ╠═33c36924-e49f-4dd6-b920-e93bdb33a584
# ╠═5eadcbc7-3438-44c2-9ee1-1253d8afd75e
# ╠═9101fe94-e511-4589-924d-74e9344b3134
# ╟─6dfb8433-0b0f-4ab0-a5f5-e38c788d97ce
# ╠═c40b98fc-ebe7-4a72-99b7-8a112d162c44
# ╠═c77587ae-29c1-4055-89af-e6b69b80a1d2
# ╠═06cfc4a4-5bf6-49b3-8db0-30c36a884148
# ╠═20fd8912-e36e-44c9-a01b-51f2685b2897
# ╟─3931249b-4fea-4153-b78b-59a786c0e40a
# ╟─a10d2eea-5d25-4c57-b798-cd41c3e11c60
# ╠═fd6093f9-4024-4a22-9bc0-f1626c1da7de
# ╟─57bf6e4e-b27a-4284-be0c-b02eb0eee822
# ╠═95d0efb4-686e-4209-855a-4b62e5ada030
# ╠═4dd535d2-3c9a-440d-b05a-9af5f24ed6c0
# ╠═d6a0933e-0f85-4433-abf8-2d486f9a0545
# ╠═bf5e0064-db20-4b80-9c44-bf96d076a82d
# ╠═9c97d92c-5917-418d-b7bf-0a25622adc21
# ╠═b9a02e5a-1d7b-4f36-8d36-c03a3cb23718
# ╠═2d23d765-b660-4200-ab30-054f4dd8c2fd
# ╠═5f09dc1f-3df1-45b7-a344-32e93131c7b5
# ╟─3f22e159-451b-4f89-a509-ba455f498c7f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
