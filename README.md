# sketch-code-test
Elixir code test for sketch

To run this solution you'll need Elixir, Erlang, SQLite installed. There are 2 applications, a Canvas API and a very simple elixir script that will call the API and output a canvas to STOUT.

#### Commentary

It was a fun little problem to solve, I'm a little concerned about performance on bigger canvases of say 100x100, while it runs it's not as immediate as I'd like. I've tried to keep things as simple as possible by just using Phoenix and SQLite off the shelf. I worked on this over a number of days when I had a spare hour here and there. I found the instructions a little unclear as to what I was supposed to implement for the server but I took my best shot after reading them over several times. 

## 1. Running the Canvas API application

First things first get the API running

```sh
# First open a terminal in the correct folder
cd canvas_api

# Get and compile dependencies
mix deps.get && mix deps.compile

# Create a local dev database
mix setup

# Run the tests
mix test

# Run the server
mix phx.server
```

### 2. Add some canvases to the database

Run the following commands, we're opening IEX and adding some pre-rolled canvases

```sh
# open another terminal in the correct folder
cd canvas_api

# Start an IEX session
iex -S mix

# Now add some canvases to the database by running these commands
alias CanvasApi.Canvases
canvas_1 = %{
    rectangles: [
        %{left: 3, top: 2, width: 5, height: 3, outline: "@", fill: "X"},
        %{left: 10, top: 3, width: 14, height: 6, outline: "X", fill: "O"}
    ]
}
canvas_2 = %{
    rectangles: [
        %{left: 14, top: 0, width: 7, height: 6, outline: "", fill: "."},
        %{left: 0, top: 3, width: 8, height: 4, outline: "O", fill: ""},
        %{left: 5, top: 5, width: 5, height: 3, outline: "X", fill: "X"}
    ]
}
canvas_3 = %{
    rectangles: [
        %{left: 14, top: 0, width: 7, height: 6, outline: "", fill: "."},
        %{left: 0, top: 3, width: 8, height: 4, outline: "O", fill: ""},
        %{left: 5, top: 5, width: 5, height: 3, outline: "X", fill: "X"},
        %{left: 60, top: 30, width: 20, height: 40, outline: "-", fill: ""},
        %{left: 65, top: 65, width: 10, height: 10, outline: "", fill: "="},
        %{left: 20, top: 60, width: 7, height: 10, outline: "P", fill: "L"}
    ]
}
{:ok, result_1} = Canvases.create_canvas(canvas_1)
{:ok, result_2} = Canvases.create_canvas(canvas_2)
{:ok, result_3} = Canvases.create_canvas(canvas_3)

IO.puts("Canvas 1 - id: #{result_1.id}")
IO.puts("Canvas 2 - id: #{result_2.id}")
IO.puts("Canvas 3 - id: #{result_3.id}")
```

## 3. Display the canvases

The read only client is a very bare bones elixir script. In the previous IEX code it should have printed the IDs of the canvases it created. These should be passed into the script below as an argument.

```sh
# Open a third terminal window in the right directory
cd client_cli

# Get and compile dependencies
mix deps.get && mix deps.compile

# Run the CLI passing in the ID of the canvas you want displayed
mix run ./scripts/cli.exs --canvas 1
```