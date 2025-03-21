### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ bd57d4b1-7048-4e84-8da3-0a47299a4f4c
begin	
	using Pkg
	Pkg.add("AlgebraicPetri")
	Pkg.add("Catlab")
	Pkg.add("Latexify")
	Pkg.add("LaTeXFigures")
	Pkg.add("LaTeXStrings")
	Pkg.add("TikzPictures")
	Pkg.add("TikzGraphs")
	Pkg.add("PGFPlots")
end

# ╔═╡ 62549710-8684-11ef-1ce8-afafaf3bbed0
begin
	using Catlab
	using AlgebraicPetri
	using Catlab.Graphics.Graphviz
	using Catlab.CategoricalAlgebra.StructuredCospans
	using Catlab.Programs
	using Catlab.Theories
	using LaTeXFigures
	using LaTeXStrings
	using TikzPictures
end

# ╔═╡ 6b0b6745-28f7-4010-97a4-8d85d389037f
PLUTO_TEX_USE_PACKAGES = ["tikz"]

# ╔═╡ 241257fc-879e-46b0-bbf6-803adaa6d10f


# ╔═╡ 2031cd0e-295b-40af-bea0-03cf659c14f8
md"""
| **Component**    | **Type**                | **Description**                                   | **Example**                                      |
|------------------|-------------------------|---------------------------------------------------|--------------------------------------------------|
| **Places**       | `Symbol`                | Nodes in the Petri net where tokens are held.     | `:OrderQueue`, `:BreadedChicken`                 |
| **Transitions**  | `Symbol`                | Nodes representing events or actions that process tokens. | `:TakeOrder`, `:CookChicken`               |
| **Arcs**         | `Tuple{Symbol, Symbol}` | Connections between places and transitions.       | `(:OrderQueue, :TakeOrder)`, `(:CookChicken, :CookedChicken)` |
"""

# ╔═╡ 95fe2e67-e37c-45ed-ade0-1a0bda06cd77


# ╔═╡ 7739cd44-6f82-4a3c-a86c-75ce41471035
methods(OpenPetriNet)

# ╔═╡ 7ddc5189-ede7-4289-96d8-77d1c42aedf1
methods(add_place)

# ╔═╡ c0c59e6c-3936-4a70-a950-b11ed1cdddbf
methods(add_transition)

# ╔═╡ e828b03a-1166-4d1d-b291-4a92fe95f43f
methods(add_input_arc)

# ╔═╡ 59b6a389-7df4-4dcc-a21d-fe78f0b194ac
methods(add_output_arc)

# ╔═╡ 5b3d380d-c7e1-41a9-9c2f-71e6c0bc69b6
PetriNetSchema = FreeSchema((
    :Place => (),                 # Places
    :Transition => (),            # Transitions
    :InputArc => (:Transition => :Place),    # Arcs from transitions to places
    :OutputArc => (:Place => :Transition)    # Arcs from places to transitions
))

# ╔═╡ 2e7e87cd-6006-4d3e-9e22-ccd3f2135574
function define_places(place_list::Vector{Symbol})
    return place_list
end

# ╔═╡ c263c940-086c-42a3-8531-190d4def6a6e
function define_transitions(transition_list::Vector{Symbol})
    return transition_list
end

# ╔═╡ 99dd301a-2078-42fb-95de-a51213e2eab0
function define_arcs(arc_list::Vector{Tuple{Symbol, Symbol}})
    return arc_list
end

# ╔═╡ 209837e9-040f-49e2-a01d-75e86b80c606
function build_petri_net(places::Vector{Symbol}, transitions::Vector{Symbol}, arcs::Vector{Tuple{Symbol, Symbol}})
	petri_net = OpenPetriNet()
 
	
	# Adding places to the Petri net
	for place in places
	    petri_net = add_place(petri_net, place)
	end
		for transition in transitions
	    petri_net = add_transition(petri_net, transition)
	end
	  
	# Add arcs to the Petri net
	for (src, tgt) in arcs
	    if src in places && tgt in transitions
	        petri_net = add_input_arc(petri_net, src, tgt)  # Place -> Transition
	    elseif src in transitions && tgt in places
	        petri_net = add_output_arc(petri_net, src, tgt)  # Transition -> Place
	    else
	        error("Invalid arc definition between $src and $tgt")
	    end
	end
	return petri_net
end

# ╔═╡ 25d5092a-93d5-489b-9415-0814942cf899
methods(OpenPetriNet)

# ╔═╡ 9be4da49-f98e-40b1-9d11-1e29d288de83
methods(add_species!)

# ╔═╡ 8ff71f26-9688-4839-ac36-498dc0d56f95
methods(add_transition!)

# ╔═╡ b3b72fdf-0333-465b-9d09-e2a5dc2455af
methods(add_input!)

# ╔═╡ 922eb99a-2a39-4d05-9b57-3e94a36b8d10
methods(add_output!)

# ╔═╡ 99bac2de-cbc3-402c-8c19-d162a7e0fddd
dependency_methods = map(method -> try method() catch err err end, [
    () -> methods(OpenPetriNet),
    () -> methods(add_species!),
    () -> methods(add_transition!),
    () -> methods(add_input!),
    () -> methods(add_output!),
	() -> methods(add_place) # Expected to fail
])

# ╔═╡ 8baf5246-8f1b-4af6-807a-49eb15f3f9b3
map(dep_doc_result -> begin print(dep_doc_result); return dep_doc_result end,dependency_methods)

# ╔═╡ a19e52fd-8362-4d27-a4d9-99b08356afe3


# ╔═╡ 9fb34466-129d-44c8-ba72-60f962e2bb68
?FreeSchema

# ╔═╡ 63116d11-c2b6-4fca-99df-9e92d192c5a0
function visualize_petri_net(pn)
    graph = to_graphviz(pn)
    render(graph)
end


# ╔═╡ 0a938530-5a3f-430e-8ff2-8e68725efefa
places = define_places([:OrderQueue, :StaffAvailable, :IngredientsAvailable, 
	                        :BreadedChicken, :CookedChicken, :PackedOrder, 
	                        :DriveThroughQueue, :Wastage])

# ╔═╡ 0dd2a512-404a-4020-af71-55e3142ea062
transitions = define_transitions([:TakeOrder, :BreadChicken, :CookChicken, 
	                                  :PackOrder, :ServeCustomer, :DiscardExpiredChicken])

# ╔═╡ a60b1264-41c4-4dc8-b59f-7ffec848fd1e
arcs = define_arcs([
	    (:OrderQueue, :TakeOrder), (:StaffAvailable, :TakeOrder), 
	    (:TakeOrder, :IngredientsAvailable),
	    (:IngredientsAvailable, :BreadChicken), (:StaffAvailable, :BreadChicken),
	    (:BreadChicken, :BreadedChicken),
	    (:BreadedChicken, :CookChicken), (:CookChicken, :CookedChicken),
	    (:CookedChicken, :PackOrder), (:PackOrder, :PackedOrder),
	    (:PackedOrder, :ServeCustomer), (:DriveThroughQueue, :ServeCustomer),
	    (:CookedChicken, :DiscardExpiredChicken), (:DiscardExpiredChicken, :Wastage)
	])

# ╔═╡ 49babca6-de40-48b0-98a0-0c907081570d
	# Build the Petri net
	pn = build_petri_net(places, transitions, arcs)
	
	

# ╔═╡ a645cd33-a293-487c-8ea0-a8bcb48705f6


# ╔═╡ be3ddf35-8933-4c85-80e4-2fd8d27189c0
# Visualize the Petri net
	visualize_petri_net(pn)

# ╔═╡ 5ac85cb7-69c4-48c4-80e5-75ba653b8212


# ╔═╡ da018536-234e-4139-a0c1-6efe37416e41


# ╔═╡ e81b941d-bb24-4ba6-9ba3-85297c5f34b9
pic = TikzPicture("""\\begin{tikzpicture} 
node (SystemOfInterest) {System-of-Interest}
node (Architecture) [right=of SystemOfInterest] {Architecture}
node (Stakeholder) [below=of SystemOfInterest] {Stakeholder}
node (ArchitectureDescription) [below=of Architecture] {Architecture Description}
node (Concern) [below=of Stakeholder] {Concern}
node (ArchitectureView) [below=of ArchitectureDescription] {Architecture View}
node (ArchitectureViewpoint) [below=of Concern] {Architecture Viewpoint}
node (ModelKind) [below left=of ArchitectureViewpoint] {Model Kind}
node (ArchitectureModel) [below right=of ArchitectureViewpoint] {Architecture Model}
//draw
	(SystemOfInterest) -- node[above] {exhibits} (Architecture)
	(SystemOfInterest) -- node[left] {has interest in} (Stakeholder)
	(Stakeholder) -- node[above] {identifies} (ArchitectureDescription)
	(ArchitectureDescription) -- node[right] {identifies} (Architecture)
	(Concern) -- node[left] {frames} (ArchitectureViewpoint)
	(ArchitectureDescription) -- node[right] {addresses} (Concern)
	(ArchitectureViewpoint) -- node[left] {governs} (ArchitectureView)
	(ArchitectureView) -- node[right] {governs} (ArchitectureModel)
	(ModelKind) -- node[above] {governs} (ArchitectureModel)
};
\\end{tikzpicture}"""; options="""node distance=2cm, every node/.style={draw, rectangle}""", preamble="""\\usetikzlibrary{positioning,arrows.meta}""")

# ╔═╡ d6a55766-27ee-478e-b362-6ee4f0ada294
Markdown(pic)

# ╔═╡ d9de1cb6-871d-4c04-bb88-2219ae441e12


# ╔═╡ Cell order:
# ╠═6b0b6745-28f7-4010-97a4-8d85d389037f
# ╠═bd57d4b1-7048-4e84-8da3-0a47299a4f4c
# ╠═241257fc-879e-46b0-bbf6-803adaa6d10f
# ╠═62549710-8684-11ef-1ce8-afafaf3bbed0
# ╠═2031cd0e-295b-40af-bea0-03cf659c14f8
# ╠═95fe2e67-e37c-45ed-ade0-1a0bda06cd77
# ╠═7739cd44-6f82-4a3c-a86c-75ce41471035
# ╠═7ddc5189-ede7-4289-96d8-77d1c42aedf1
# ╠═c0c59e6c-3936-4a70-a950-b11ed1cdddbf
# ╠═e828b03a-1166-4d1d-b291-4a92fe95f43f
# ╠═59b6a389-7df4-4dcc-a21d-fe78f0b194ac
# ╠═5b3d380d-c7e1-41a9-9c2f-71e6c0bc69b6
# ╠═2e7e87cd-6006-4d3e-9e22-ccd3f2135574
# ╠═c263c940-086c-42a3-8531-190d4def6a6e
# ╠═99dd301a-2078-42fb-95de-a51213e2eab0
# ╠═209837e9-040f-49e2-a01d-75e86b80c606
# ╠═25d5092a-93d5-489b-9415-0814942cf899
# ╠═9be4da49-f98e-40b1-9d11-1e29d288de83
# ╠═8ff71f26-9688-4839-ac36-498dc0d56f95
# ╠═b3b72fdf-0333-465b-9d09-e2a5dc2455af
# ╠═922eb99a-2a39-4d05-9b57-3e94a36b8d10
# ╠═99bac2de-cbc3-402c-8c19-d162a7e0fddd
# ╠═8baf5246-8f1b-4af6-807a-49eb15f3f9b3
# ╠═a19e52fd-8362-4d27-a4d9-99b08356afe3
# ╠═9fb34466-129d-44c8-ba72-60f962e2bb68
# ╠═63116d11-c2b6-4fca-99df-9e92d192c5a0
# ╠═0a938530-5a3f-430e-8ff2-8e68725efefa
# ╠═0dd2a512-404a-4020-af71-55e3142ea062
# ╠═a60b1264-41c4-4dc8-b59f-7ffec848fd1e
# ╠═49babca6-de40-48b0-98a0-0c907081570d
# ╠═a645cd33-a293-487c-8ea0-a8bcb48705f6
# ╠═be3ddf35-8933-4c85-80e4-2fd8d27189c0
# ╠═5ac85cb7-69c4-48c4-80e5-75ba653b8212
# ╠═da018536-234e-4139-a0c1-6efe37416e41
# ╠═e81b941d-bb24-4ba6-9ba3-85297c5f34b9
# ╠═d6a55766-27ee-478e-b362-6ee4f0ada294
# ╠═d9de1cb6-871d-4c04-bb88-2219ae441e12
