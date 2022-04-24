defmodule MultipleSelectWeb.LangsLive do
  use MultipleSelectWeb, :live_view
  import Phoenix.LiveView

  @langs Translator.languages_demo()

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:langs, @langs)
     |> assign(:translations, [])
     |> assign(:toggle_ids, [])}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("submit", %{"translate" => %{"words" => words}}, socket) do
    IO.inspect(Translator.get_translations(words, socket.assigns.toggle_ids))

    {:noreply,
     socket
     |> assign(:translations, Translator.get_translations(words, socket.assigns.toggle_ids))}
  end

  def handle_event("toggle-all", %{"value" => "on"}, socket) do
    {:noreply, assign(socket, :toggle_ids, @langs |> Enum.map(& &1.code))}
  end

  def handle_event("toggle-all", %{}, socket) do
    {:noreply, assign(socket, :toggle_ids, [])}
  end

  def handle_event("toggle", %{"toggle-id" => id}, socket) do
    toggle_ids = socket.assigns.toggle_ids

    toggle_ids =
      if id in toggle_ids do
        Enum.reject(toggle_ids, &(&1 == id))
      else
        [id | toggle_ids]
      end

    {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end
end
