export printSmart


"""
Wrapper for julia's base display() function 
to make it more user friendly.
"""
function printSmart(M::AbstractVecOrMat, header::String="data")
    println(header * ": ")
    display(M)
    println()
end
