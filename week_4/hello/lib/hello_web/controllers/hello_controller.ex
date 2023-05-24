defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger}) do
    # render phoenix view, defaults html
    # In order for this to work, the controller and view must share the same root name, in this case, "Hello"
    render(conn, :show, messenger: messenger)

    # render text
    # text(conn, "From messenger #{messenger}")

    # render json
    # json(conn, %{id: messenger})

  end
end
