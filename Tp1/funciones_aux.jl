#Funciones correspondientes  al 
# Ej1
function Datos()::Vector{Any}
	D = [] 
	for i in 1:10 
		push!(D, readdlm("datos/datos$i.csv", ','))
		#println(size(D[i]))
	end
	return D
end

function grafico(D::Vector{Any})
	scatter(D[1][:,1],D[1][:,2],label="Dataset 1")
	for i in 2:10 
		scatter!(D[i][:,1],D[i][:,2],label="Dataset $i")
	end
	plot!(legend = :topleft, clear = true)
end

# Ej2 
#circImpli(x,y,a,b,c) =  x^2 + y^2 -2*a*x -2*b*y -c
function plot_algebraico(D::Vector{Any},i::Integer)::String  
	if !isfile("graficos/ajus_alg_$i.png")
		#println("Existe el grafico!!")
		#img = load("graficos/ajus_alg_$i.png")
		#display(img)
		a,b,c = ajuste_alg(D)
		r = √(c+a^2+b^2)
		#x = range(-r+a,a+r,length=100)
		#y = range(-r+b,b+r,length=100)
		#z = [circImpli(i,j,a,b,c) for i in x, j in y]
		Θ = 0:0.1:2*π
		X = a .+ r*cos.(Θ)
		Y = b .+ r*sin.(Θ)
		scatter(D[:,1],D[:,2],label="Dataset $i")
		plot!(X,Y,label="Ajuste Algebraico")
		savefig("graficos/ajus_alg_$i.png")	 
	end
	return "graficos/ajus_alg_$i.png"
end

# Ej8 

function plot_conjunto(Dats::Vector{Any},i::Int)
	if !isfile("graficos/ajus_conj_$i.png") 
		D = Dats[i]
		a,b,c = ajuste_alg(D)
		r = √(c+a^2+b^2)
		Θ = 0:0.1:2*π
		X = a .+ r*cos.(Θ)
		Y = b .+ r*sin.(Θ)
		obj = ajuste_geom(D,1000,1e-1)
		if(obj == "Numero de condicion muy alto")
			return "No se pudo"
		end
		A,B,R = obj
		Z = A .+ R*cos.(Θ)
		W = B .+ R*sin.(Θ)
		scatter(D[:,1],D[:,2],label = "Dataset $i")
		plot!(X,Y, label = "Ajuste Algebraico")
		plot!(Z,W,label = "Ajuste Geometrico")
		savefig("graficos/ajus_conj_$i.png")	 
	end
	return "graficos/ajus_conj_$i.png"
end
# Ej10
function plot_conjunto2(Dats::Vector{Any},i::Int)
	D = Dats[i]
	a,b,r = ajuste_mejorado(D,1000,1e-1)
	Θ = 0:0.1:2*π
	X = a .+ r*cos.(Θ)
	Y = b .+ r*sin.(Θ)
	scatter(D[:,1],D[:,2],label = "Dataset $i")
	plot!(X,Y,label = "Ajuste Mejorado")
	#plot!(Z,W,label = "Ajuste Geometrico")
	savefig("graficos/ajus_conj2_$i.png")	 

	return "graficos/ajus_conj2_$i.png"
end 
