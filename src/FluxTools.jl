module FluxTools

using Functors: @functor

export Model, @model

include("model.jl")
include("macros.jl")

end