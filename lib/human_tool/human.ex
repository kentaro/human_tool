defmodule HumanTool.Human do
  def start do
    pid = spawn(fn -> loop() end)
    :global.register_name(:human, pid)
  end

  def loop do
    receive do
      {sender, msg} ->
        # [IO.gets on iex session - Questions / Help - Elixir Programming Language Forum](https://elixirforum.com/t/io-gets-on-iex-session/34396)
        fix_group_leader()
        IO.puts("Received: #{msg}")
        answer = IO.gets("Answer: ")
        send(sender, {:ok, answer})
        loop()
    end
  end

  defp fix_group_leader, do: :user_drv |> Process.whereis() |> set_group_leader()

  # we are in a iex session, we should get shell group leader and set it for current process
  defp set_group_leader(pid) when is_pid(pid) do
    iex_group_leader = pid |> Process.info() |> get_in([:dictionary, :current_group])
    Process.group_leader(self(), iex_group_leader)
  end

  # no iex session
  defp set_group_leader(_), do: :ok
end

Node.connect(:plugin@localhost)
HumanTool.Human.start()
