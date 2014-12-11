defmodule AjsTPTest do
  use ExUnit.Case
  require AjsTP

  test "encode" do
    assert AjsTP.encode(%{a: [], b: 321}) == 
    	[%{	label: "Root",
    		fileicon: "false",
    	 	expanded: "false", 
    	 	childs: [%{label: "b : 321", expanded: "false", childs: [], fileicon: "true"}, %{label: "a : ", expanded: "false", childs: [], fileicon: "false"}]}]
  end

end
