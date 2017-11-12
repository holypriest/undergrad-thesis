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

inputmat = [Complex128(x,y) for x in X, y in Y]
outputmat = Array{Integer}(size(inputmat))

function mandelbrot(inputmat::Array{Complex128,2}, outputmat::Array{Integer,2})
    for k=1:size(inputmat, 2)
        for j=1:size(inputmat, 1)
            @inbounds outputmat[j,k] = mandelbrotorbit(inputmat[j,k])
        end
    end
end

mandelbrot(inputmat, outputmat)
#writedlm("output-file.csv", outputmat, ';')
