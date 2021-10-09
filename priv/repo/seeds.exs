# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Todo.Repo.insert!(%Todo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Todo.Repo
alias Todo.Category


categories = ["Critical incident with very high impact",
 "Major incident with significant impact", "Minor incident with low impact"]
for category <- categories do
    Repo.get_by(Category, name: category) ||
        Repo.insert!(%Category{name: category})
    
end