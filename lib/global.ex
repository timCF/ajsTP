defmodule AjsTP.Global do
	defmacro __using__(_) do
		quote location: :keep do
			use Hashex, [__MODULE__.AjsTree]
			defmodule AjsTree do
				defstruct 	label: nil,
							childs: nil,
							expanded: true
			end
			
			# public
			defmacro encode(term, expand_level \\ 0) do
				quote location: :keep do
					Exutils.prepare_to_jsonify(unquote(term), %{tuple_values_to_lists: true})
						|> AjsTP.encode_process(unquote(expand_level))
							|> Exutils.prepare_to_jsonify
				end
			end

			#priv
			def encode_process(term, expand_level, label \\ "Root", this_level \\ 1) do
				case (HashUtils.is_hash?(term) and term != []) do
					true -> 
						%AjsTree{	label: label, 
									expanded: (this_level <= expand_level), 
									childs: HashUtils.to_list(term) |> Enum.map(fn({k,v}) -> encode_process(v, expand_level, "#{k} : ", this_level+1) end)}
					false -> 
						case is_list(term) do
							true -> 
								%AjsTree{	label: label, 
											expanded: (this_level <= expand_level), 
											childs: Enum.map(term, fn(v) -> encode_process(v, expand_level, "", this_level+1) end)}
							false -> 
								%AjsTree{	label: "#{label}#{term}", 
											expanded: (this_level <= expand_level), 
											childs: []}
						end
				end
			end
		end
	end
end