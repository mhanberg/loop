# Loop

Blursed be the loop...

The most blursed of all programming constructs, the infinite loop.

```elixir
use Loop

counter = :counters.new(1, [])

loop do
  count = :counters.get(counter, 1)
  # Break the loop completely
  break if count == 10

  if Enum.random(1..100) < 20 do
    IO.puts "Sleeping..."
    Process.sleep(2000)

    # Proceed directly to the next iteration of the loop
    next()
  end

  IO.puts "Incrementing!"

  :counters.add(counter, 1, 1)
end
```
