### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 6e8d4380-0093-4481-adf9-1b47d2c255c1
# Define the Node structure
struct Node
    label::String
    children::Vector{Node}
end

# ╔═╡ d7b494c1-d713-41a1-9fc0-a00ad639df2c
# Parsing Function
function parse_lines(input::String; marker::Regex=r"\s*:([^:]+):")
    splitLines = x -> split(x, "\n")
    filterEmpty = filter(x -> !isempty(strip(x)))
    markerPos = (x; r=marker) -> (
        length(x) - length(lstrip(x, [' '])), 
        match(r, x).captures[1]
    )
    
    # Apply the functions in order
    lines = input |> splitLines |> filterEmpty
    return [(i, length(line) - length(lstrip(line, [' '])), match(marker, line).captures[1]) for (i, line) in enumerate(lines)]
end


# ╔═╡ 19ae5112-bb7c-45fc-a0c7-1019b5efdc16
# Build Tree Recursive Function
function build_tree_recursive(line_info::Vector{Tuple{Int, Int, String}}, parent_indent::Int)
    if isempty(line_info)
        return (Node[], line_info)
    else
        (line_num, indent, label) = first(line_info)
        if indent <= parent_indent
            return (Node[], line_info)
        else
            (nodes, remaining_lines) = build_tree(line_info, indent)
            return (nodes, remaining_lines)
        end
    end
end

# ╔═╡ afd601f0-983f-4f45-871b-b1b4dc2960c0
# Build Tree Function
function build_tree(line_info::Vector{Tuple{Int, Int, String}}, current_indent::Int = 0)
    if isempty(line_info)
        return (Node[], line_info)
    else
        (line_num, indent, label) = first(line_info)
        if indent < current_indent
            return (Node[], line_info)
        else
            rest = line_info[2:end]
            (children, remaining_lines) = build_tree_recursive(rest, indent)
            node = Node(label, children)
            (siblings, final_remaining_lines) = build_tree(remaining_lines, current_indent)
            return ([node; siblings], final_remaining_lines)
        end
    end
end

# ╔═╡ 22b30a4b-84fd-46d8-8f2b-2c2b69a4cc0b


# ╔═╡ 55bf1845-705a-4a21-bb53-e0bbbf8ffebf


# ╔═╡ df2f7c59-ef0e-44fa-8d6e-bf070096b957
function generate_node_output(node::Node, indent_str::String)
    node_line = indent_str * "node [concept] {" * node.label * "}"
    if isempty(node.children)
        return [node_line]
    else
        child_lines = generate_output(node.children, indent_str * "    ")
        return [node_line; indent_str * "child {"; child_lines; indent_str * "}"]
    end
end

# ╔═╡ 30002bdb-5bde-41a6-aabd-ead7582db639
# Output Generation Functions
function generate_output(nodes::Tuple{Node}, indent_str::String = "  ")
	nodes |> map(node -> generate_node_output(node, indent_str)) |> reduce(vcat, [])
end

# ╔═╡ 81b8cb4c-6afe-4c02-b16f-0e7d5e28f465
function process_lines(input::String)
    line_info = parse_lines(input)
    (tree, _) = build_tree(line_info)
    output_lines = generate_output(tree)
    return output_lines
end

# ╔═╡ 987ece7a-bbef-4080-ad3b-6d5977c73fcf
input_string


# ╔═╡ b8d1738f-69c3-4eaf-a249-7130a3284a6a
output_lines = process_lines(input_string)

# ╔═╡ 0535369b-5d05-4012-8671-8d3e5cf5690a
println(join(output_lines, "\n"))

# ╔═╡ 5435f0e4-7aee-11ef-04b1-5bf345829bb6


# ╔═╡ 81b438ca-02ae-466c-a577-cb0cfa8ce8f0
# ╠═╡ disabled = true
#=╠═╡
line_info = parse_lines(input_string)

# Output:
# [
#   (1, 0, "Root Concept"),
#   (2, 2, "Child 1"),
#   (3, 4, "Grandchild 1"),
#   (4, 2, "Child 2"),
#   (5, 2, "Child 3")
# ]
  ╠═╡ =#

# ╔═╡ 7cce4309-2330-49a3-97ff-d53da3e92946
#=╠═╡
for (i, (x,y,n)) in enumerate(line_info)
	println(("." ^ y) * n)
end
  ╠═╡ =#

# ╔═╡ e3de2d98-5562-49b9-831e-ee67bf2c3349
# ╠═╡ disabled = true
#=╠═╡
input_string = """
:Root Concept:
  :Child 1:
    :Grandchild 1:
  :Child 2:
  :Child 3:
"""
  ╠═╡ =#

# ╔═╡ a7ae32a2-3e70-49af-bc02-20586d978171
# Example Usage
input_string = """
:Root Concept:
  :Child 1:
    :Grandchild 1:
  :Child 2:
  :Child 3:
"""

# ╔═╡ Cell order:
# ╠═6e8d4380-0093-4481-adf9-1b47d2c255c1
# ╠═d7b494c1-d713-41a1-9fc0-a00ad639df2c
# ╠═afd601f0-983f-4f45-871b-b1b4dc2960c0
# ╠═19ae5112-bb7c-45fc-a0c7-1019b5efdc16
# ╠═22b30a4b-84fd-46d8-8f2b-2c2b69a4cc0b
# ╠═55bf1845-705a-4a21-bb53-e0bbbf8ffebf
# ╠═30002bdb-5bde-41a6-aabd-ead7582db639
# ╠═df2f7c59-ef0e-44fa-8d6e-bf070096b957
# ╠═81b8cb4c-6afe-4c02-b16f-0e7d5e28f465
# ╠═a7ae32a2-3e70-49af-bc02-20586d978171
# ╠═987ece7a-bbef-4080-ad3b-6d5977c73fcf
# ╠═b8d1738f-69c3-4eaf-a249-7130a3284a6a
# ╠═0535369b-5d05-4012-8671-8d3e5cf5690a
# ╠═e3de2d98-5562-49b9-831e-ee67bf2c3349
# ╠═5435f0e4-7aee-11ef-04b1-5bf345829bb6
# ╠═81b438ca-02ae-466c-a577-cb0cfa8ce8f0
# ╠═7cce4309-2330-49a3-97ff-d53da3e92946
