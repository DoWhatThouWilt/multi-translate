defmodule MultipleSelect.Repo do
  use Ecto.Repo,
    otp_app: :multiple_select,
    adapter: Ecto.Adapters.Postgres
end
