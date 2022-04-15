{[canvas: canvas_id], _, _} = OptionParser.parse(System.argv(), strict: [canvas: :integer])
IO.puts("\n\nCanvas #{canvas_id}")
IO.puts("--------------------------------------------")

%{body: body} = HTTPoison.get!("http://localhost:4000/api/render/#{canvas_id}")

%{"data" => data} = Jason.decode!(body)

for row <- data, do: IO.puts(row)

IO.puts("--------------------------------------------\n\n")
