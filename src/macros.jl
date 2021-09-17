
function parse_function_call(x, expr)
    syms = Pair[]
    res = parse_function_call!(syms, expr)
    func = Expr(:(->), Expr(:tuple, x, Expr(:tuple, map(last, syms)...)), res)
    return func, syms
end

function parse_function_call!(syms, expr::Expr)
    if expr.head == :$ && length(expr.args) == 1
        sym = gensym()
        push!(syms, expr.args[1] => sym)
        return sym
    else
        return Expr(expr.head, (parse_function_call!(syms, arg) for arg in expr.args)...)
    end
end

parse_function_call!(_, expr) = expr

function model_helper(x, expr)
    func, syms = parse_function_call(x, expr)
    Expr(:call, :Model, esc(func), Expr(:tuple, map(esc∘first, syms)...))
end

macro model(x, expr)
    model_helper(x, expr)
end