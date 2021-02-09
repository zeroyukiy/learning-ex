defmodule Math do
    def sum(a, b) do
        do_sum(a, b)
    end

    defp do_sum(a, b) do
        a + b
    end

    def zero?(0) do
        true
    end

    def zero?(x) when is_integer(x), do: false
end



IO.puts Math.sum(1, 2) #=> 3
# Io.puts Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)

# Because we used elixir instead of elixirc, 
# the module was compiled and loaded into memory, 
# but no .beam file was written to disk. 

IO.puts Math.zero?(0) #=> true
IO.puts Math.zero?(1) #=> false
# IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
# IO.puts Math.zero?(0.0) #=> ** (FunctionClauseError)

# The trailing question mark in zero? means that this function returns a boolean; see Naming Conventions.
# Giving an argument that does not match any of the clauses raises an error.

# You may use do: for one-liners but always use do/end for functions spanning multiple lines.

# Note the capture syntax can also be used as a shortcut for creating functions:
fun = &("Hello #{&1}")
IO.puts fun.("world")

# fun = &(&1 + 1)
# IO.puts fun.(1)

# The &1 represents the first argument passed into the function. 
# &(&1 + 1) above is exactly the same as fn x -> x + 1 end. 
# The syntax above is useful for short function definitions.

fun2 = fn x -> x + 1 end
IO.puts fun2.(2)

fun3 = &List.flatten(&1, &2)
IO.puts fun3.([1, [[2], 3]], [4, 5])

# &List.flatten(&1, &2) is the same as writing 
# fn(list, tail) -> List.flatten(list, tail) end 
# which in this case is equivalent to &List.flatten/2.

# If a function with default values has multiple clauses, 
# it is required to create a function head (without an actual body) 
# for declaring defaults:

defmodule Concat do
    # def join(a, b, sep \\ " ") do
    #     a <> sep <> b
    # end

    # A function head declaring defaults
    def join(a, b \\ nil, sep \\ " ")

    def join(a, b, _sep) when is_nil(b) do # The leading underscore in _sep means that the variable will be ignored in this function;
        a
    end
    
    def join(a, b, sep) do
        a <> sep <> b
    end

end

IO.puts Concat.join("Hello", "world") #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat.join("Hello") #=> Hello

defmodule DefaultTest do
    def dowork(x \\ "hello") do
        x
    end

    def do_work_again(x \\ "hello", sep \\ " ", y \\ "world") do
        x <> sep <> y
    end
end

IO.puts DefaultTest.dowork()
IO.puts DefaultTest.dowork("something else")
IO.puts DefaultTest.do_work_again()
IO.puts DefaultTest.do_work_again("something else", "***", "trallala")