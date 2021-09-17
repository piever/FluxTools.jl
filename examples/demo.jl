using Flux, FluxTools

# Explicit model definition
m0 = Model((Dense(3, 5), Dense(5, 4), Dense(3, 1))) do x, (l1, l2, l3)
    x = l1(x)
    x = l2(x)
    return l3(x[1:3, :])
end

m0(rand(3, 12))

@show m0.layers

# Model definition via macro. As many layers as there are `$` signs.
m1 = @model x begin
    y = $(Dense(2, 3))(x)
    z = y .* 1.2
    return $(Dense(3, 4))(abs.(z))
end

m1(rand(2, 10))

@show m1.layers

# Nested example

m2 = @model x begin
    y = $m1(x)
    return softmax($(Dense(4, 2))(y))
end

m2(rand(2, 10))

@show length(params(m2)) == length(params(m1)) + length(params(Dense(4, 2)))