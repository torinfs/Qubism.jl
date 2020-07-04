using Parsers
export print_smart, parse_operator_string


"""
Wrapper for julia's base display() function 
to make it more user friendly.
"""
function print_smart(M::AbstractVecOrMat, header::String="Data")
    println(header * ": ")
    display(M)
    println()
end

"""
Parses strings of operators seperated by spaces into a
list of tuples. creation operator denoted with '^' is
represented by '1' and annhilation operators are '0'
Ex: "3^ 1^ 2 4" => [(4, 0), (2, 0), (1, 1), (3, 1)]
"""
function parse_operator_string(s::String)
    sites = split(s, ' ', keepempty=false)
    
    operators = Tuple[]

    # create array of tuples
    # Second value denotes annhiliate/create: 0/1
    for num in sites
        if occursin("^", num)
            pushfirst!(operators, (parse(Int, chop(num)), 1))
        else
            pushfirst!(operators, (parse(Int, num), 0))
        end
    end

    return operators
end

