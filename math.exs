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

# => 3
IO.puts(Math.sum(1, 2))
# Io.puts Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)

# Because we used elixir instead of elixirc,
# the module was compiled and loaded into memory,
# but no .beam file was written to disk.

# => true
IO.puts(Math.zero?(0))
# => false
IO.puts(Math.zero?(1))
# IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
# IO.puts Math.zero?(0.0) #=> ** (FunctionClauseError)

# The trailing question mark in zero? means that this function returns a boolean; see Naming Conventions.
# Giving an argument that does not match any of the clauses raises an error.

# You may use do: for one-liners but always use do/end for functions spanning multiple lines.

# Note the capture syntax can also be used as a shortcut for creating functions:
fun = &"Hello #{&1}"
IO.puts(fun.("world"))

# fun = &(&1 + 1)
# IO.puts fun.(1)

# The &1 represents the first argument passed into the function.
# &(&1 + 1) above is exactly the same as fn x -> x + 1 end.
# The syntax above is useful for short function definitions.

fun2 = fn x -> x + 1 end
IO.puts(fun2.(2))

fun3 = &List.flatten(&1, &2)
IO.puts(fun3.([1, [[2], 3]], [4, 5]))

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

  # The leading underscore in _sep means that the variable will be ignored in this function;
  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

# => Hello world
IO.puts(Concat.join("Hello", "world"))
# => Hello_world
IO.puts(Concat.join("Hello", "world", "_"))
# => Hello
IO.puts(Concat.join("Hello"))

defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end

  def do_work_again(x \\ "hello", sep \\ " ", y \\ "world") do
    x <> sep <> y
  end
end

IO.puts(DefaultTest.dowork())
IO.puts(DefaultTest.dowork("something else"))
IO.puts(DefaultTest.do_work_again())
IO.puts(DefaultTest.do_work_again("something else", "***", "trallala"))

# pipeline operator
defmodule Pipeline do
  def operator(a) do
    a |> abs() |> Integer.to_string() |> IO.puts()
  end

  def operator do
    -5
    |> abs()
    |> Integer.to_string()
    |> IO.puts()
  end
end

# It's the same of doing IO.puts(Integer.to_string(abs(-5)))
Pipeline.operator(-5)
Pipeline.operator()

# Function arity
defmodule Rectangle do
  def area(a), do: area(a, a)
  def area(a, b), do: a * b
end

# The function Rectangle.area receives two arguments,
# so it’s said to be a function of arity 2

IO.puts(Rectangle.area(2))

defmodule Calculator do
  def sum(a, b \\ 0) do
    a + b
  end
end

defmodule MyModule do
  # import module and using my custom alias
  # import IO
  alias IO, as: MyIO

  def fun(a, b \\ 1, c, d \\ 2) do
    a + b + c + d
  end

  def my_function do
    MyIO.puts("Calling imported function.")
  end
end

IO.puts(MyModule.fun(2, 5))
MyModule.my_function()

# Module attributes
defmodule Circle do
  @moduledoc "Implements basic circle functions"
  @pi 3.14159

  @doc "Computes the area of a circle"
  @spec area(number) :: number
  def area(r), do: r * r * @pi

  @doc "Computes the circumference of a circle"
  def circumference(r), do: 2 * r * @pi
end

IO.puts(Circle.area(5))
IO.puts(Circle.circumference(5))

# .
