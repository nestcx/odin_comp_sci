def merge(l,r,a)
	nl = l.length
	nr = r.length

	#left index
	i = 0

	#right index
	j = 0

	#new array index
	k = 0

	while (i < nl && j < nr)
		if (l[i] <= r[j])
			a[k] = l[i]
			i += 1
		elsif (r[j] <= l[i])
			a[k] = r[j]
			j += 1
		end
		k += 1
	end
	while (i < nl)
		a[k] = l[i]
		i += 1
		k += 1
	end
	while (j < nr)
		a[k] = r[j]
		j += 1
		k += 1
	end
end

def mergesort(a)
	n = a.length

	if (n < 2) #base case 
		return
	end

	mid = n / 2

	l = a[0..mid-1]
	r = a[mid..-1]

	mergesort(l)
	mergesort(r)

	merge(l,r,a)
end

mergesort([9,2,6,5])











