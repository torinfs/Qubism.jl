using Parsers
export print_smart, parse_ints


"""
Wrapper for julia's base display() function 
to make it more user friendly.
"""
function print_smart(M::AbstractVecOrMat, header::String="")
    println(header * ": ")
    display(M)
    println()
end


function parse_ints(s)
    numbers = split(s, ' ', keepempty=false)
    map(numbers) do num
        Parsers.parse(Int, num)
    end
end
