# Loop

Blursed be the loop...

The most blursed of all programming constructs, the infinite loop.

```elixir
import Loop

counter = :counters.new(1, [])

loop do
  if :counters.get(counter, 1) == 10 do
    IO.puts "We're at 10!"

    break()
  else
    IO.puts "incrementing!"

    :counters.add(counter, 1, 1)
  end
end
```
