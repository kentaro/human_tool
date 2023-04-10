defmodule HumanTool.Human do
  def start do
    pid = spawn(fn -> loop() end)
    :global.register_name(:human, pid)
  end

  def loop do
    receive do
      {sender, msg} ->
        IO.puts("Received: #{msg}")
        answer = IO.gets("Answer: ")
        send(sender, {:ok, answer})
        loop()
      end
  end
end

Node.connect(:plugin@localhost)
HumanTool.Human.start()
