defmodule Loop do
  defmacro loop(block) do
    quote do
      unquote(__MODULE__).do_loop(fn ->
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
