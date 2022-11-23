defmodule Loop do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [loop: 1]
    end
  end

  defmacro loop(block) do
    quote do
      unquote(__MODULE__).do_loop(fn ->
        import unquote(__MODULE__), only: [break: 0, break: 1, next: 0, next: 1]
        unquote(block)
      end)
    end
  end

  defmacro break() do
    quote do
      unquote(__MODULE__).do_throw(:break)
    end
  end

  defmacro break({type, _, [condition]}) do
    quote do
      unquote(type)(unquote(condition)) do
        unquote(__MODULE__).do_throw(:break)
      end
    end
  end

  defmacro next do
    quote do
      unquote(__MODULE__).do_throw(:next)
    end
  end

  defmacro next({type, _, [condition]}) do
    quote do
      unquote(type)(unquote(condition)) do
        unquote(__MODULE__).do_throw(:next)
      end
    end
  end

  @doc false
  def do_throw(type) do
    throw({:loop, type})
  end

  @doc false
  def do_loop(callback) do
    callback.()

    do_loop(callback)
  catch
    {:loop, :break} ->
      :ok

    {:loop, :next} ->
      do_loop(callback)

    thrown ->
      throw(thrown)
  end
end
