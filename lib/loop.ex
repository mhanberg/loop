defmodule Loop do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [loop: 1]
    end
  end
  
  defmacro loop(block) do
    quote do
      unquote(__MODULE__).do_loop(fn ->
        import unquote(__MODULE__), only: [break: 0]
        unquote(block)
      end)
    end
  end

  def break() do
    throw(:break_loop)
  end

  @doc false
  def do_loop(callback) do
    callback.()

    do_loop(callback)
  catch
    :break_loop ->
      :ok

    thrown ->
      throw(thrown)
  end
end
