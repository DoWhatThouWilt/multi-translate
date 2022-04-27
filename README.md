# Demo is [here](https://multi-translate.fly.dev/).



# About

Multi-Translate does speedy translation of text into multiple languages at the same by utilizing python workers using [translatepy](https://github.com/Animenosekai/translate) running inside concurrent elixir processes, which are called asynchronously. What inspired me to create this app was the limitation of translatepy being synchronous, only being able to translate a text into one language at a time.  Here, erlport is used to facilitate communication between elixir and python. Poolboy is used to manage the pool of python workers.



# Multi-Translate

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
