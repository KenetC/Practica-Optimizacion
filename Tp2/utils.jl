using CUDA, Random, Flux 

gpu_available = CUDA.has_cuda()

function to_device(x)
    if gpu_available
        return x |> gpu
    else
        return x
    end
end
function mostrar10(X_prueba,y_prueba,numero::Int)
	zero_i = findall(x->x==numero,y_prueba)
	zero_10 = zero_i[1:10]
		
	num_images = 10
	num_cols = min(4, num_images)  
	num_rows = ceil(Int, num_images / num_cols)  

	ps = [heatmap(Gray.(X_prueba[:,:,i])) for i in zero_10]
	plot(
		ps..., layout=(num_rows, num_cols)
	)
end
function load_data(dataset;train_size=0.8,onehot=true,seed=1234)
	Random.seed!(seed)
	X,y = dataset  
	Instances = [X[:,:,findall(x->x==i,y)] for i in 0:9]
	Instances = [I[:,:,shuffle(1:size(I,3))] for I in Instances]
	
	train_ind = [Int(floor(size(I,3)*train_size)) for I in Instances]
	
	Xs_train = [I[:,:,1:train_ind[i]] for (i,I) in enumerate(Instances)]
	ys_train = [fill(i-1,cant) for (i,cant) in enumerate(train_ind)]
	Xs_val = [I[:,:,train_ind[i]+1:end] for (i,I) in enumerate(Instances)]
	ys_val = [fill(i-1,Int(size(I,3))-train_ind[i]) for (i,I) in enumerate(Instances)]

	X_train,y_train = cat(Xs_train...,dims=3),cat(ys_train...,dims=1)  # concatenamos
	X_val,y_val = cat(Xs_val...,dims=3),cat(ys_val...,dims=1)
	
	trainShuffle = shuffle(1:size(X_train,3))
	valShuffle = shuffle(1:size(X_val,3))
	
	y_train = y_train[trainShuffle]
	y_val = y_val[valShuffle]
	
	if onehot 
		y_train = Flux.onehotbatch(y_train,0:9)
		y_val = Flux.onehotbatch(y_val,0:9)
	end
	
	return X_train[:,:,trainShuffle],y_train , X_val[:,:,valShuffle], y_val
end

function predictions(model,MLPorCNN::Bool)
	res = zeros(10)
	for i in 0:9 
		x = Float32.(channelview(load("imagenes_tp2/$i.png")))
		if MLPorCNN # suponemos true cuando es MLP
			X = to_device(reshape(x[:,:,1:end],28*28,size(x,3)))
		else 
			X = to_device(reshape(x[:,:,1:end],(28,28,1,size(x,3))))
		end 
		res[i+1] = Flux.onecold(model(X)|>cpu,0:9)[1] 
	end
	return res
end