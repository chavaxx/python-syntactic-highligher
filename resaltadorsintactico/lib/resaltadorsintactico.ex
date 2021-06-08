defmodule Resaltadorsintactico do
  @doctype "<!DOCTYPE html>
  <head>
    <title>Resaltador sitactico python</title>
    <link rel='stylesheet' href='tags.css'>
  </head>
  <body>
    <pre>
    <code>

  "
    @endOfFile "
      </code>
      </pre>
    </body>
  </html>"

  def tagType({:specialCaracter,_Tokenline, list}), do: "#{list}"

  def tagType({token,_Tokenline, list}) do
    "<i class ='#{token}'>#{HtmlEntities.encode(List.to_string(list))}</i>"
  end


  def createHTML(sample, name) do
    File.open!(name <> ".html", [:write]) |> IO.binwrite(@doctype <> sample <> @endOfFile)
  end

  def newFile() do
     Path.wildcard("lib/*/*.py")|>
     Enum.map(fn file -> readFile(file)end)
  end

  def newFileParallel() do
    Path.wildcard("lib/*/*.py")|>
    Enum.map(fn file -> Task.async(fn -> readFile(file)end)end)|>
    Enum.map(fn task -> Task.await(task) end)
 end

  def readFile(path)do
    #IO.puts(path)
    text = File.read!(path)
     |> to_charlist|> :lexer.string |> elem(1)
     |> Enum.map(fn token -> tagType(token) end )
     |> Enum.reduce("", fn html, final -> final <> html end)
     |> createHTML(path)
  end

  def extime() do
    Benchee.run(
      %{
        "concurrente" => fn -> newFileParallel() end,
        "secuencial" => fn -> newFile() end
      },
      memory_time: 2
    )
  end
end
