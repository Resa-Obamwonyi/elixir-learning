defmodule HelloWeb.HelloHTML do
  use HelloWeb, :html

  # use the ~H sigil to put the contents we want to render. Inside the ~H sigil, we use a templating language called HEEx,
  # which stands for "HTML+EEx"

  # USING A FUNCTION COMPONENT
  # def index(assigns) do
  #   ~H"""
  #   Hello Theresa's World!
  #   """
  # end

  # USING AN EMBEDDED TEMPLATE
  embed_templates "hello_html/*"
end
