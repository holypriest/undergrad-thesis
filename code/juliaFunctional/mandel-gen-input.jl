function getenv(var::AbstractString)
    val = ccall((:getenv, "libc"), Cstring, (Cstring,), var)
    if val == C_NULL
        error("getenv: undefined variable: ", var)
    end
    unsafe_string(val)
end

rows = parse(Int32, getenv("INPUTMAT_ROWS"))
columns = parse(Int32, getenv("INPUTMAT_COLS"))

function linspace(start::Float64, finish::Float64, n::Integer)
    linspace = [start]
    distance = (finish - start) / Float64(n-1)
    next = start
    while abs(next - finish) > 0.000000000001
        next = next + distance
        linspace = append!(linspace, next)
    end
    return linspace
end

X = linspace(-2.5, 1.0, rows)
Y = linspace(-1.25, 1.25, columns)
Z = [complex(x,y) for x in X, y in Y]