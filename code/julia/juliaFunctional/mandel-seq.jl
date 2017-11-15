function getenv(var::AbstractString)
    val = ccall((:getenv, "libc"), Cstring, (Cstring,), var)
    if val == C_NULL
        error("getenv: undefined variable: ", var)
    end
    unsafe_string(val)
end

rows = parse(Int32, getenv("INPUTMAT_ROWS"))
columns = parse(Int32, getenv("INPUTMAT_COLS"))

function mandelbrotorbit(c)
    z = Complex128(0,0) + c
    for k = 1:100
        if abs(z) > 2
            return k-1
        end
        z = z^2 + c
    end
    return 100
end

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

function mandelbrot(x::Float64)
    Z = [complex(x,y) for y in Y]
    return map(mandelbrotorbit, Z)
end

N = map(mandelbrot, X)
if "-export" in ARGS
    writedlm("output-file.csv", N, ';')
end
