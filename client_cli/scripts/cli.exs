{[canvas: canvas_id], _, _} = OptionParser.parse(System.argv(), strict: [canvas: :integer])
IO.inspect("Loading Canvas #{canvas_id}")

%{body: body} = HTTPoison.get!("http://localhost:4000/api/render/#{canvas_id}")

%{"data" => data} = Jason.decode!(body)

for row <- data, do: IO.puts(row)
