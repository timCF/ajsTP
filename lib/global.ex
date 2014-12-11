defmodule AjsTP.Global do
	defmacro __using__(_) do
		quote location: :keep do
			use Hashex, [__MODULE__.AjsTree]
			defmodule AjsTree do
				defstruct 	label: nil,
							childs: nil
			end
			
			defmacro encode(term) do
				Exutils.prepare_to_jsonify(term, %{tuple_values_to_lists: true})
			end
		end
	end
end