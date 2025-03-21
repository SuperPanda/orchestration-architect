### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ dee3703a-e72e-4b84-8bfb-c80262550ba1
begin
	using LaTeXFigures
	using LaTeXStrings
	using TikzPictures
	using TikzGraphs
end

# ╔═╡ 8f14c3e9-4e12-440a-be26-62ad43daf664
PLUTO_TEX_USE_PACKAGES = ["tikz"]

# ╔═╡ 7d3cbfa8-01a5-4707-a92a-f62181650f2d
begin
    # Test mindmap-style syntax with no explicit \begin{tikzpicture}
    tp2 = TikzPicture("""
    \\usetikzlibrary{mindmap}
    \\draw [
        mindmap,
        black!10,
        root concept/.append style={concept color=red!80},
        level 1 concept/.append style={concept color=black!100},
        clockwise from=0
    ]
    node [concept] (root) {Root Concept}
    	child {
			node [concept] {Child 1}
		}
    	child {
			node [concept] {Child 2}
		}
    	child {
			node [concept] {Child 3}
		};
    """, options="scale=1", preamble="")
    
    tp2
end


# ╔═╡ 3eda0838-6fee-4ae2-b9b9-b93d559ed6ca
begin
    # Test tree-style syntax using the trees library with adjusted colors
    tp1 = TikzPicture("
    \\usetikzlibrary{trees, mindmap}
    \\draw [
        black!100,
        root concept/.append style={concept color=cyan!100},
        level 1 concept/.append style={concept color=lime!100},
		level 1 something/.append style={concept color=red!100},
        level 2 concept/.append style={concept color=yellow!100},
		mindmap,
        grow cyclic, align=center,
        level distance=1cm,
        sibling angle=120
    ]
    
    node [concept] (root) {Root Concept}
    child { node [concept] {Child 1}
        child { node [concept] {Grandchild 1} }
        child { node [concept] {Grandchild 2} }
    }
    child { node [concept] {Child 2} }
    child { node [concept] {Child 3} };
    ", options="scale=1", preamble="")
    
    tp1
end


# ╔═╡ 5d46bc23-7357-4d37-aa5a-1d6fc26f0452
begin

    tp = TikzPicture("""
    \\usetikzlibrary{mindmap}
    \\draw [
        black!100,
        root concept/.append style={concept color=cyan!100},
        level 1 concept/.append style={concept color=lime!100},
        level 2 concept/.append style={concept color=yellow!100},
        mindmap,
        grow cyclic, align=center,
        level distance=3cm,
        sibling angle=90
    ]
    
    node [concept] {Root Concept}
    child { node [concept] {Child 1}
        child { node [concept] {Grandchild 1} }
        child { node [concept] {Grandchild 2} }
    }
    child { node [concept] {Child 2} }
    child { node [concept] {Child 3} };
    """, options="scale=1", preamble="")
    
    tp
end


# ╔═╡ 80f56313-7587-4756-a208-80a61102a746
TikzPicture("
\\usetikzlibrary{backgrounds, positioning, arrows.meta, graphs, trees, graphdrawing, shapes, mindmap}
\\draw [help lines] (0,0) { grid(15,15) };
\\draw[mindmap, grow cyclic] (2,8) {
	node [concept] {Root}
	child { 
		node {Child 1}
		child { node {GrandChild 1.1} }
		child { node {GrandChild 1.2} }
	}
	child { 
		node {Child 2}
		child { node {GrandChild 2.1} }
	}
};
", options="scale=1, cyan!60, sibling distance=1, level distance=10, every node/.style={circle, fill=black!80, draw=yellow!100}")

# ╔═╡ a6ae3162-7af3-4d88-80ed-91c87f2dbfe9
abstract_concrete_matrix = TikzPicture("
\\usetikzlibrary{backgrounds, positioning, arrows.meta, graphs, trees, graphdrawing}
\\usegdlibrary{layered, trees}

\\draw [help lines] (-1,0) grid (7,8)
{
graph [layered layout, grow=down] {
i[y=7.5,x=-0.5]->{7->6->5->4->3->2->1};
}
graph [layered layout, grow=down] {
j[x=3.5,y=8.5]->{a,b,c,d,e,f,g};
}
graph [] {
	g7[x=6.5,y=6.5]->7[x=-1.5,y=6.5],
	g7->g[x=6.5,y=8.5];
}
};
\\draw (3.5,9.5) node (6,7) {Heterarchy (Domains) and Hierarchy (Layers)};
", options="scale=1,red!60, draw=white!100, node distance=1cm, thick, every node/.style={draw, rectangle},text height=.7em, text depth=.2em, draw=purple!50, thick, fill=gray!50")

# ╔═╡ 2e86bd5e-c48c-40e7-bb2f-1c026d639f40
# Insert a TikZ diagram placeholder
abstract_framework_template_generator(){

	preamble = [
        "\\usetikzlibrary{backgrounds, positioning, arrows.meta, graphs, trees, graphdrawing, shapes}"
        "\\usegdlibrary{layered, trees}"
    ];

	generate_system_levels(n) = return "\\node (" * string(n) * ") at (" * string(n) * ", 0) {" * string(n) * "}";
	
	generate_horizontal_connections(n) = return "\\draw[->] (" * string(n) * ") -- (" * string(n-1) * ")"  ;
	
	generate_heterarchy_nodes(j, name) = return "\\node (" * name * ") at (2, " * string(8-j) * ") {" * name * " }" ;
	
	generate_heterarchy_connections(name, next_name) = return "\\draw[->] (" * name * ") -- (" * next_name * ")" ;

    generate_cross_connections = n -> "\\draw[->, dashed] (" * string(n) * ") -- (" * string(Char(96 + n)) * ")" ;
    
    content = [
        "% System Levels (Initial Object 'i' structure rotated)",
        map(generate_system_levels, 1:7) |> join,
        "% Connections for the horizontal hierarchy",
        map(generate_horizontal_connections, 2:7) |> join,
        "% Define the heterarchy (abstract nodes for a, b, c...g, rotated)",
        map(generate_heterarchy_nodes, enumerate(["a", "b", "c", "d", "e", "f", "g"], 1)) |> join,
        "% Connections for the heterarchy",
        map(generate_heterarchy_connections, zip(["a", "b", "c", "d", "e", "f"], ["b", "c", "d", "e", "f", "g"])) |> join,
        "% Cross-connections (product of domains)",
        map(generate_cross_connections, 1:7) |> join
    ];
    
    style = "\\color=red, scale=1.0, every node/.style={draw, minimum size=1cm}" ;
    preamble_str = join(preamble, "\n") ;
    content_str = join(content, "\n") ;
    return NamedTuple{(:preamble, :content, :style)}((preamble_str, content_str, style));
}

# ╔═╡ 643cdb1c-fb63-4208-9064-5f21c97d6c31

# Generate the diagram
generate_abstract_concept_matrix()

# ╔═╡ 7550b27b-194a-44b7-8cd1-8d4a8ef18efa
the_matrix_product = TikzPicture("
\\usetikzlibrary{backgrounds, positioning, arrows.meta, graphs, trees, graphdrawing, shapes}
\\usegdlibrary{layered, trees}
\\draw [help lines] (0,0) (7,7)
{
graph [layered layout] {
heterachy->{a,b,c,d,e,f,g},
hierarchy->{1,2,3,4,5,6,7},
1->2->3->4->5->6->7,
a->b->c->d->e->f->g,
c3 <- {c,3};
}};
\\draw[node/.style=red!100] (10,8) node {Heuristically use to map iteratively to matrix};
", options="scale=1,red!100, draw=white!100, node distance=1cm, thick, every node/.style={draw, rectangle},text height=.7em, text depth=.2em, draw=purple!50, thick, fill=red!50")

# ╔═╡ b8ba60c9-f63d-44e0-accc-a6e4bb778ff0
pic = TikzPicture("
\\usetikzlibrary{backgrounds, positioning, arrows.meta, graphs, trees, graphdrawing}
\\usegdlibrary{layered}
\\node (SystemOfInterest) {System-of-Interest};
\\node (Architecture) [right=of SystemOfInterest] {Architecture};
\\node (Stakeholder) [below=of SystemOfInterest] {Stakeholder};
\\node (ArchitectureDescription) [below=of Architecture] {Architecture Description};
\\node (Concern) [below=of Stakeholder] {Concern};
\\node (ArchitectureView) [below=of ArchitectureDescription]{Architecture View};
\\node (ArchitectureViewpoint) [below=of Concern] {Architecture Viewpoint};
\\node (ModelKind) [below left=of ArchitectureViewpoint] {Model Kind};
\\node (ArchitectureModel) [below right=of ArchitectureViewpoint] {Architecture Model};

\\draw (SystemOfInterest) -- node[above] {exhibits} (Architecture)
(SystemOfInterest) -- node[left] {has interest in} (Stakeholder);
(Stakeholder) -- node[above]{identifies} (ArchitectureDescription)
	(ArchitectureDescription) -- node[right] {identifies} (Architecture)
	(Concern) -- node[left] {frames} (ArchitectureViewpoint)
	(ArchitectureDescription) -- node[right] {addresses} (Concern)
	(ArchitectureViewpoint) -- node[left] {governs} (ArchitectureView)
	(ArchitectureView) -- node[right] {governs} (ArchitectureModel)
	(ModelKind) -- node[above] {governs} (ArchitectureModel);", options="red!100, draw=white!100, node distance=2cm, every node/.style={draw, rectangle}")

# ╔═╡ 839f675d-8e6c-414d-82cb-4eae9fe0062e


# ╔═╡ f762794d-827b-4871-a179-cbc75a850325
# Sample DSL input
dsl_input = """
Node Root
  Node Child 1
    Node Grandchild 1
  Node Child 2
"""


# ╔═╡ 6a042392-8cbe-44ab-a82a-4192a2408cb1
md"""
```
node {DSLGeneration}
    child { node {Overview}
        child { node {Purpose}
            child { node {"The DSL defines hierarchical relationships between concepts."} }
            child { node {Concept: "Indentation in the DSL specifies parent-child relationships."} }
            child { node {Concept: "The goal is to convert this structure into a TikZ tree diagram."} }
        }
        child { node {DSLStructure}
            child { node {Concept: "Concepts are defined by a 'Concept' keyword followed by a name."} }
            child { node {Concept: "Each concept can have child concepts indented underneath it."} }
            child { node {Concept: "The root concept represents the top-level node in the TikZ diagram."} }
        }
        child { node {ParsingMechanism}
            child { node {Concept: "A parser will process the DSL input to identify concept hierarchies."} }
            child { node {Concept: "The parser will convert indented relationships into a tree structure."} }
        }
        child { node {TikZMapping}
            child { node {Concept: "Each concept in the DSL will map to a 'node' in the TikZ diagram."} }
            child { node {Concept: "Child concepts will map to 'child { node {ConceptName} }' blocks in TikZ."} }
        }
    }
    child { node {Components}
        child { node {DSLDefinition}
            child { node {Concept: "Define the structure and rules of the DSL (e.g., Concept, indentation)."} }
        }
        child { node {GrammarRules}
            child { node {Concept: "Create grammar rules to parse the DSL and extract relationships."} }
            child { node {Concept: "The grammar will ensure that each concept is linked to its parent."} }
        }
        child { node {Parsing}
            child { node {Concept: "Implement a parser that takes the DSL input and generates a tree."} }
        }
        child { node {TikZGenerator}
            child { node {Concept: "Generate TikZ code from the parsed DSL structure."} }
        }
    }
    child { node {FutureEnhancements}
        child { node {ErrorHandling}
            child { node {Concept: "Ensure the parser provides meaningful error messages for incorrect input."} }
        }
        child { node {Extensibility}
            child { node {Concept: "Allow for additional concept types (e.g., attributes, properties)."} }
        }
        child { node {FunctorMapping}
            child { node {Concept: "Extend the system to map between different representations, such as DSL to RDF."} }
        }
    }
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXFigures = "5d2f8d0c-8a3d-45b5-9848-1a5a591485bf"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
TikzGraphs = "b4f28e30-c73f-5eaf-a395-8a9db949a742"
TikzPictures = "37f6aa50-8035-52d0-81c2-5a1d08754b2d"

[compat]
LaTeXFigures = "~0.1.0"
LaTeXStrings = "~1.3.1"
TikzGraphs = "~1.4.0"
TikzPictures = "~3.5.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "f34da3cd91094a5e444f4b4bf28c791a8264f1d7"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "d57bd3762d308bded22c3b82d033bff85f6195c6"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.4.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "2ac646d71d0d24b44f3f8c84da8c9f4d70fb67df"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.4+0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d55dffd9ae73ff72f1c0482454dcf2ec6c6c4a63"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.5+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b0036b392358c80d2d2124746c2bf3d48d457938"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.4+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1dc470db8b1131cfc7fb4c115de89fe391b9e780"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.12.0"

[[deps.HarfBuzz_ICU_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "HarfBuzz_jll", "ICU_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "6ccbc4fdf65c8197738c2d68cc55b74b19c97ac2"
uuid = "655565e8-fb53-5cb3-b0cd-aec1ca0647ea"
version = "2.8.1+0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.ICU_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "20b6765a3016e1fca0c9c93c80d50061b94218b7"
uuid = "a51ab1cf-af8e-5615-a023-bc2c838bba6b"
version = "69.1.0+0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXFigures]]
git-tree-sha1 = "a2bff0722041715b889e0fae3180a60a0cf92adf"
uuid = "5d2f8d0c-8a3d-45b5-9848-1a5a591485bf"
version = "0.1.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "27ecae93dd25ee0909666e6835051dd684cc035e"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+2"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "df37206100d39f79b3376afb6b9cee4970041c61"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.51.1+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "89211ea35d9df5831fca5d33552c02bd33878419"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e888ad02ce716b319e6bdb985d2ef300e7089889"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.3+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg"]
git-tree-sha1 = "110897e7db2d6836be22c18bffd9422218ee6284"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.12.0+0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "76374b6e7f632c130e78100b166e5a48464256f8"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.4.0+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ad31332567b189f508a3ea8957a2640b1147ab00"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Poppler_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "02148a0cb2532f22c0589ceb75c110e168fb3d1f"
uuid = "9c32591e-4766-534b-9725-b71a8799265b"
version = "21.9.0+0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "0feb6b9031bd5c51f9072393eb5ab3efd31bf9e4"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.13"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TikzGraphs]]
deps = ["Graphs", "LaTeXStrings", "TikzPictures"]
git-tree-sha1 = "e8f41ed9a2cabf6699d9906c195bab1f773d4ca7"
uuid = "b4f28e30-c73f-5eaf-a395-8a9db949a742"
version = "1.4.0"

[[deps.TikzPictures]]
deps = ["LaTeXStrings", "Poppler_jll", "Requires", "tectonic_jll"]
git-tree-sha1 = "79e2d29b216ef24a0f4f905532b900dcf529aa06"
uuid = "37f6aa50-8035-52d0-81c2-5a1d08754b2d"
version = "3.5.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "b8b243e47228b4a3877f1dd6aee0c5d56db7fcf4"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.6+1"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+3"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e9216fdcd8514b7072b43653874fd688e4c6c003"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.12+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "89799ae67c17caa5b3b5a19b8469eeee474377db"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.5+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+3"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c57201109a9e4c0585b208bb408bc41d205ac4e9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.2+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+3"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6dba04dbfb72ae3ebe5418ba33d087ba8aa8cb00"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.1+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "068dfe202b0a05b8332f1e8e6b4080684b9c7700"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.47+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.tectonic_jll]]
deps = ["Artifacts", "Fontconfig_jll", "FreeType2_jll", "Graphite2_jll", "HarfBuzz_ICU_jll", "HarfBuzz_jll", "ICU_jll", "JLLWrappers", "Libdl", "OpenSSL_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "54867b00af20c70b52a1f9c00043864d8b926a21"
uuid = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"
version = "0.13.1+0"
"""

# ╔═╡ Cell order:
# ╠═8f14c3e9-4e12-440a-be26-62ad43daf664
# ╠═dee3703a-e72e-4b84-8bfb-c80262550ba1
# ╠═7d3cbfa8-01a5-4707-a92a-f62181650f2d
# ╠═3eda0838-6fee-4ae2-b9b9-b93d559ed6ca
# ╠═5d46bc23-7357-4d37-aa5a-1d6fc26f0452
# ╠═80f56313-7587-4756-a208-80a61102a746
# ╠═a6ae3162-7af3-4d88-80ed-91c87f2dbfe9
# ╠═2e86bd5e-c48c-40e7-bb2f-1c026d639f40
# ╠═643cdb1c-fb63-4208-9064-5f21c97d6c31
# ╠═7550b27b-194a-44b7-8cd1-8d4a8ef18efa
# ╠═b8ba60c9-f63d-44e0-accc-a6e4bb778ff0
# ╠═839f675d-8e6c-414d-82cb-4eae9fe0062e
# ╠═f762794d-827b-4871-a179-cbc75a850325
# ╠═6a042392-8cbe-44ab-a82a-4192a2408cb1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
