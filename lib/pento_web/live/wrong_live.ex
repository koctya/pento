defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  alias Pento.Accounts

  def mount(_params, session, socket) do
    # user = Accounts.get_user_by_session_token(session["user_token"])
    time = time()
    {:ok,
      assign(
        socket,
        score: 0,
        message: "Make a guess:",
        time: time,
        session_id: session["live_socket_id"]
        # current_user: user
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    time = time()
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time
      )
    }
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= time() %>
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
      <.link class="bg-blue-500 hover:bg-blue-700
      text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
      phx-click="guess" phx-value-number= {n} >
        <%= n %>
      </.link>
    <% end %>
    </h2>
    <br/>
    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def time() do
    DateTime.utc_now |> to_string()
  end
end
