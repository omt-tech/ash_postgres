defmodule AshPostgres.TestRepo.Migrations.MigrateResources44 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:co_authored_posts, primary_key: false) do
      add(:role, :text, null: false)
      add(:was_cancelled_at, :utc_datetime)

      add(
        :author_id,
        references(:authors,
          column: :id,
          name: "co_authored_posts_author_id_fkey",
          type: :uuid,
          prefix: "public"
        ),
        primary_key: true,
        null: false
      )

      add(
        :post_id,
        references(:posts,
          column: :id,
          name: "co_authored_posts_post_id_fkey",
          type: :uuid,
          prefix: "public"
        ),
        primary_key: true,
        null: false
      )
    end
  end

  def down do
    drop(constraint(:co_authored_posts, "co_authored_posts_author_id_fkey"))

    drop(constraint(:co_authored_posts, "co_authored_posts_post_id_fkey"))

    drop(table(:co_authored_posts))
  end
end