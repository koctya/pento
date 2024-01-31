defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
    socket
    # |> assign(form: to_form(Promo.change_recipient(%Recipient{})))
    |> assign_recipient()
    |> clear_form()}
  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def clear_form(socket) do
    form =
      socket.assigns.recipient
      |> Promo.change_recipient()
      |> to_form()

    assign(socket, :form, form)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:form, to_form(Promo.change_recipient(recipient)))
  end

  def handle_event("save", %{"recipient" => _recipient_params}, _socket) do
    :timer.sleep(1000)
    # ...
  end

  def handle_event(
      "validate",
      %{"recipient" => recipient_params},
      %{assigns: %{recipient: recipient}} = socket) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end
end
