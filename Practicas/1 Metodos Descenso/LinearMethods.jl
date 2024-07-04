function wolfe(ϕ,m;c1=0.5,c2=0.75,ε=0.5,η=1.1,h=1e-8)
	#m=ϕ'(0)
	t1=0
	t2=ε
	ϕ_deriv(x)=(ϕ(x+h)-ϕ(x-h))/h
	
	# Armijo
	while ϕ(t2) ≤ ϕ(0) + t2*c1*m 
		t2 *= η
	end
	
	while true
		t = (t1+t2)/2
		if ϕ(t)≤ϕ(0)+c1*t*m && ϕ_deriv(t)≥c2*m
			return t
		elseif ϕ(t)>ϕ(0)+c1*m*t
			t2=t
		elseif ϕ(t)≤ϕ(0)+c1*m*t && ϕ_deriv(t)<c2*m
			t1=t
		end
	end
end

function goldstein(ϕ,m;β=0.55,η=1.01,h=1e-8)
	dϕ(x)=(ϕ(x+h)-ϕ(x-h))/h
	t = 0.1
	while β*m > dϕ(t)
		t *= η
	end
	while β*m < dϕ(t)
		t /= η
	end
	return t
end

function armijo(ϕ,m;ε=0.5,η=1.1)::Float64
	l(α) = ϕ(0) + ε*m*α
	t=0.1
	while ϕ(t)<l(t)
		t *= η
	end
	while ϕ(t)>l(t)
		t /= η
	end
	return t
end
