### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 2c705f30-1181-11ef-3583-ad9dca279bb1
md"""
# Métodos de descenso coordenado
"""

# ╔═╡ 4916bc0c-4562-44b4-81f7-7aa233db919c
md"""
Se parte de un punto inicial $x^1 = x^1_1,...,x^1_n$  y a continuación resolvemos el problema 

$$\min_{α} f(x^1 +αe_j)$$

Una vez encontrado el punto que resuelve el problema anterior, tomamos ese nuevo punto como punto de partida y elegimos, según el método, otra dirección de minimización.

1. **Descenso coordenado cíclico**. Minimiza la función $f$ en cada dirección de forma ordenada, desde la coordenada 1 hasta la coordenada $n$. Posteriormente se repite el proceso comenzando de nuevo desde la primera coordenada. 

2. **Doble recorrido de Aitken**. En esta variante del método de descenso coordenado, se minimiza la función en todas las direcciones coordenadas, $e_1,...,e_n$, para a continuación volver a minimizar hacia atrás, en la dirección $e_{n−1}$ hasta la $e_1$. En este método se requieren $n − 1$ búsquedas lineales en cada iteración. Obviamente para $n=2$ este método y el anterior coinciden. 

3. **Método de Gauss-Southwell**. Si la función es diferenciable y podemos calcular el gradiente, esta variante recomienda la selección de la coordenada del gradiente en cada punto con mayor magnitud (mayor valor absoluto) como la dirección de búsqueda.
"""

# ╔═╡ bf1d8262-654e-4c8d-8fe2-080fcf1fc9eb
md"""
*Algoritmo del método de descenso coordenado cíclico*


>**Inicio** tomar $ε>0$, $e_1,...,e_n$ como las direcciones de búsqueda. Elegir un punto inicial $x_1$. $y_1 = x_1$, $k=j=1$ e ir al paso 1.

>**Paso 1** Calcular $α_j$ con una busqueda lineal usando $f(y_j + αe_j)$. Hacer $y_{j+1} = y_j +α_je_j$. Si $j<n$, reemplazar $j$ por $j +1$ y repetir el **paso 1**. Si $j = n$ ir al **Paso 2**.

>**Paso 2** Hacer $x_{k+1} = y_{n+1}$. Si $\|x_{k+1} − x_k\|<ε$, parar. En otro caso, hacer $y_1 = x_{k+1}$, $j=1$, reemplazar $k$ por $k+1$ e ir al **Paso 1**.


"""

# ╔═╡ adeaccdf-4931-4169-a245-e58aa8077c9f
function CC(f,x;ϵ=0.01,t=0.1)
	y = x
	n = size(y)
	j = 1; k = j
	
end

# ╔═╡ 6db01147-5934-4c8a-ae9d-62990674c8e4
md"""
*Algoritmo método de descenso coordenado cíclico discreto*

En esta variante del método de descenso coordenado, no se utiliza ningún método de búsqueda lineal a lo largo de los ejes coordenados $\{e1,...,en\}$, en este caso se utiliza un desplazamiento discreto a lo largo de las direcciones de búsqueda, que siguen siendo los ejes.

>**Inicio.** Elegir un escalar $\varepsilon>0$. Elegir un tamaño inicial del paso, $t ≥ \varepsilon$ y un punto de partida $x_1$. Hacer $y_1 = x_1$, $k= j =1$ e ir al **paso 1**.

>**Paso 1** Si $f(y_j +te_j) <f(y_j)$, gane; hacer $y_{j+1} = y_j +te_j$, e ir al **Paso 2**. Si $f(y_j+te_j) ≥ f(y_j)$, en este caso, si $f(y_j−te_j) <f(y_j)$; hacer $y_{j+1} = y_j −te_j$, e ir al **Paso 2**; si $f(y_j −te_j) ≥ f(y_j)$, $y_{j+1} = y_j$ e ir al **Paso 2**.

>**Paso 2** Si $j<n$, reemplazar $j$ por $j+1$ y repetir **Paso 1**. En caso contrario, si $$f(y_{n+1}) <f(x_k)$$, reemplazar $k$ por $k+1$, $j=1$ e ir al **Paso 1**, si $f(y_{n+1}) ≥ f(x_k)$ ir al **Paso 3**.

>**Paso 3** Si $t ≤\varepsilon$ parar; $x_k$ es la solución. En otro caso, sustituir $t$ por $t/2$, $y_1 = x_{k+1} = x_k$. Reemplazar $k$ por $k+1$, $j=1$ e ir al **Paso 1**.
"""

# ╔═╡ d2aaba5e-1ac4-4175-b70b-eec3e16548e2
function CCdiscreto(f,x;ϵ=0.01,t=0.1)
	y = x
	n = size(y)
	
	j = 1; k = j
	while t > ϵ 
		ej = zeros(n)
		ej[j] = 1 
		
		if f(y + t*ej) < f(y)
			y += t*ej
		elseif f(y - t*ej) < f(y)
				y -= t*ej	
		end
		
		if j < n
			j += 1
			continue 
		elseif f(y) < f(x)
			k += 1 
			x = y
			j = 1
			continue 
		end 
		t /= 2
		x = y
		y = x 
		
		k += 1 
		j = 1 
		
	end
	return x 
end

# ╔═╡ 1c596fc7-2a1f-4365-bcf6-ab5fc1ff89d2
begin 
	i = 1 
	i += 1
	println(i)
end 

# ╔═╡ d3f77c8a-8318-453b-b832-9410a4cb2673
md"""
!!! note "Ejercicio"
	Considerar la función $f(x)=(x_1-2)^4+(x_1-2x_2)^2$ y aplicar las variantes del método cíclico comenzando con $x_0=(0,3)$.

	Tener en cuenta que el mínimo se alcanza en $(2,1)$ y el calor de la $f$ es 0 en ese punto.

	Comparar el método continuo y discreto (imprimir cantidad de iteraciones y valor de la función objetivo en cada $x_k$).
"""

# ╔═╡ e470cc9b-5b3b-4ec5-9100-9f80fd5e03df
begin 
	f((x,y)) = (x-2)^4 + (x-2y)^4
	
end

# ╔═╡ c6db700d-8b4d-434a-aff0-9eff34e316aa
md"""
!!! note "Ejercicio"
	Implementar el método de Gauss-Southwell y comparar con el método cíclico. ¿Cuál es mejor?.
"""

# ╔═╡ a867c94c-c3a7-4ed4-be93-2ad6923fdcbe
#completar

# ╔═╡ 99f73cbd-7965-4214-99c0-a2f855dff5df
md"""
#### Método de Hooke & Jeeves
"""

# ╔═╡ 6ba9d896-e758-4978-8d8c-692c3e222071
md"""
El método de descenso coordenado, cuando se aplica sobre funciones diferenciables, converg. Sin embargo, en ausencia de diferenciabilidad, el método puede situarse en un punto no óptimo. Esta dificultad puede evitarse buscando en la dirección $x_{k+1} −x_k$. Podemos por tanto introducir una búsqueda en la dirección $x_{k+1} − x_k$ en cada paso del algoritmo, para evitar problemas con puntos donde la función objetivo no es diferenciable. Este paso se suele denominar paso de aceleración o patrón de búsqueda.
"""

# ╔═╡ 50106c9d-a02d-4bbe-bef3-262d13cc7da9
md"""
*Algoritmo método de Hooke & Jeeves continuo*

>**Inicio**. Tomar $ε>0$. Elegir un punto de partida $x_1$ ,hacer $y_1 = x_1$, $k= j =1$ e ir al **paso 1**.

>**Paso 1** Calcular $α_j haciendo una busqueda lineal de $f(y_j + αe_j)$. Hacer $y_{j+1} = y_j+α_je_j$. Si $j<n$, reemplazar $j$ por $j+1$ y repetir el **Paso 1**. En otro caso, si $j = n$, hacer $x_{k+1} = y_{n+1}$. Si $\|x_{k+1} −x_k\| <ε$ parar; en caso contrario ir al **Paso 2**.

>**Paso 2** Hacer $d = x_{k+1} −x_k$, y calcular $\hat{α}$ por busqueda lineal de $f(x_{k+1} + αd)$. Hacer $y_1 = x_{k+1} +\hat{α}d$, $j=1$, reemplazar $k$ por $k +1$ e ir al **Paso 1.**
"""

# ╔═╡ 68e3d832-bbe7-4e2b-bb80-256423c07fed
md"""
!!! note "Ejercicio"
	Implementar el método de Hooke & Jeeves y comparar con los anteriores. Pensar como sería la versión discreta.
"""

# ╔═╡ 1ba161d8-9cf4-4e00-a884-a1f2042957e1
#completar

# ╔═╡ Cell order:
# ╟─2c705f30-1181-11ef-3583-ad9dca279bb1
# ╟─4916bc0c-4562-44b4-81f7-7aa233db919c
# ╟─bf1d8262-654e-4c8d-8fe2-080fcf1fc9eb
# ╠═adeaccdf-4931-4169-a245-e58aa8077c9f
# ╟─6db01147-5934-4c8a-ae9d-62990674c8e4
# ╠═d2aaba5e-1ac4-4175-b70b-eec3e16548e2
# ╠═1c596fc7-2a1f-4365-bcf6-ab5fc1ff89d2
# ╟─d3f77c8a-8318-453b-b832-9410a4cb2673
# ╠═e470cc9b-5b3b-4ec5-9100-9f80fd5e03df
# ╟─c6db700d-8b4d-434a-aff0-9eff34e316aa
# ╠═a867c94c-c3a7-4ed4-be93-2ad6923fdcbe
# ╟─99f73cbd-7965-4214-99c0-a2f855dff5df
# ╟─6ba9d896-e758-4978-8d8c-692c3e222071
# ╟─50106c9d-a02d-4bbe-bef3-262d13cc7da9
# ╟─68e3d832-bbe7-4e2b-bb80-256423c07fed
# ╠═1ba161d8-9cf4-4e00-a884-a1f2042957e1
