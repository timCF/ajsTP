defmodule AjsTPTest do
  use ExUnit.Case
  require AjsTP

  test "encode" do
    assert AjsTP.encode(%{a: [], b: 321}) == 
    	%{	label: "Root",
    	 	expanded: "false", 
    	 	childs: [%{label: "b : 321", expanded: "false", childs: []}, %{label: "a : ", expanded: "false", childs: []}]}
  end

end
