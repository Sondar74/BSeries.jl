using Documenter
import Pkg
using BSeries

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(BSeries,
                    :DocTestSetup, :(using BSeries); recursive = true)

# Copy some files from the top level directory to the docs and modify them
# as necessary
open(joinpath(@__DIR__, "src", "license.md"), "w") do io
    # Point to source license file
    println(io, """
    ```@meta
    EditURL = "https://github.com/ranocha/BSeries.jl/blob/main/LICENSE.md"
    ```
    """)
    # Write the modified contents
    println(io, "# License")
    println(io, "")
    for line in eachline(joinpath(dirname(@__DIR__), "LICENSE.md"))
        line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
        println(io, "> ", line)
    end
end

open(joinpath(@__DIR__, "src", "contributing.md"), "w") do io
    # Point to source license file
    println(io, """
    ```@meta
    EditURL = "https://github.com/ranocha/BSeries.jl/blob/main/CONTRIBUTING.md"
    ```
    """)
    # Write the modified contents
    println(io, "# Contributing")
    println(io, "")
    for line in eachline(joinpath(dirname(@__DIR__), "CONTRIBUTING.md"))
        line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
        println(io, "> ", line)
    end
end

# Make documentation
makedocs(modules = [BSeries],
         sitename = "BSeries.jl",
         format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true",
                                  canonical = "https://ranocha.github.io/BSeries.jl/stable",
                                  ansicolor = true),
         # Explicitly specify documentation structure
         pages = [
             "Home" => "index.md",
             # "Introduction" => "introduction.md",
             "Tutorials" => [
                 "tutorials/bseries_basics.md",
                 "tutorials/rk_order_conditions.md",
                 "tutorials/bseries_creation.md",
                 "tutorials/modified_equations.md",
                 "tutorials/modifying_integrators.md",
                 "tutorials/symbolic_computations.md",
                 "tutorials/code_generation.md",
             ],
             # "Applications & references" => "applications.md",
             "Benchmarks" => "benchmarks.md",
             "API reference" => "api_reference.md",
             "Contributing" => "contributing.md",
             "License" => "license.md",
         ],
         # to make the GitHub action fail when doctests fail
         strict = true)

deploydocs(repo = "github.com/ranocha/BSeries.jl",
           devbranch = "main",
           push_preview = true)
