struct Model{F, L}
    f::F
    layers::L
end

@functor Model (layers,)

(m::Model)(x) = m.f(x, m.layers)
