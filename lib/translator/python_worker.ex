defmodule Translator.PythonWorker do
  use GenServer

  require Logger

  @timeout 60_000

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def call(word, lang) do
    Task.async(fn ->
      :poolboy.transaction(
        :python_worker,
        fn pid ->
          GenServer.call(pid, {:translate, word, lang})
        end,
        @timeout
      )
    end)

    # |> Task.await(@timeout)
  end

  #############
  # Callbacks #
  #############

  @impl true
  def init(_) do
    path =
      [:code.priv_dir(:multiple_select), "python"]
      |> Path.join()

    with {:ok, pid} <- :python.start([{:python_path, to_charlist(path)}, {:python, 'python3'}]) do
      Logger.info("[#{__MODULE__} #{inspect(pid)}] Started python worker")
      {:ok, pid}
    end
  end

  @impl true
  def handle_call({:translate, word, lang}, _from, pid) do
    {lang, translation} = :python.call(pid, :python_translator, :translate_tuple, [word, lang])
    Logger.info("[#{__MODULE__} #{inspect(pid)}] Handled call")
    {:reply, %{name: to_string(lang), translation: to_string(translation)}, pid}
  end
end
