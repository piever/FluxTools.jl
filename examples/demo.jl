using Flux, FluxTools

m = Model((Dense(3, 5), Dense(5, 4), Dense(3, 1))) do x, (l1, l2, l3)
    x = l1(x)
    x = l2(x)
    return l3(x[1:3, :])
end

m(rand(3, 12))

m = @model x begin
    y = $(Dense(2, 3))(x)
    z = y .* 1.2
    return $(Dense(3, 1))(abs.(z))
end

m(rand(2, 10))