# Elixir Commands Cheatsheet

## IEx (Interactive Elixir Shell)

```bash
iex                              # start basic shell
iex -S mix                       # start shell with project loaded
iex -S mix phx.server            # start shell with Phoenix server running
```

### Inside IEx

```elixir
recompile                        # recompile all changed modules
r MyModule                       # recompile a specific module
c "path/to/file.ex"              # compile a single file
h Enum.map                       # docs for a function
h Enum.map/2                     # docs for specific arity
i [1, 2, 3]                      # inspect type info of a value
t Enum.t()                       # show type specs
v                                # last evaluated result
v(3)                             # result from line 3

# history & navigation
#iex:break                       # cancel stuck multiline input (type on new line)
Ctrl+C Ctrl+C                    # quit iex
Ctrl+G                           # user switch command (job control)
Ctrl+L                           # clear screen
```

### IEx Debugging

```elixir
break! MyModule.func/2           # set breakpoint
breaks()                         # list all breakpoints
remove_breaks()                  # remove all breakpoints
remove_breaks(MyModule)          # remove breakpoints for a module
continue                         # continue after hitting breakpoint
respawn                          # restart the iex shell process
whereami                         # show current location in code (at breakpoint)
open MyModule                    # open module source in editor
exports MyModule                 # list all exported functions
```

### IEx Configuration

```elixir
# in ~/.iex.exs (runs on every iex start)
IEx.configure(inspect: [limit: :infinity])   # don't truncate output
IEx.configure(history_size: 100)             # increase history
```

---

## Mix (Build Tool)

### Project Management

```bash
mix new my_app                   # create new project
mix new my_app --sup             # create with supervision tree
mix new my_app --umbrella        # create umbrella project
mix deps.get                     # fetch dependencies
mix deps.update --all            # update all deps
mix deps.update some_dep         # update specific dep
mix deps.clean --all             # clean all deps
mix deps.tree                    # show dependency tree
mix deps.unlock --all            # unlock all deps
```

### Compilation

```bash
mix compile                      # compile the project
mix compile --force              # force recompile everything
mix compile --warnings-as-errors # fail on warnings
mix clean                        # remove compiled files
```

### Testing

```bash
mix test                         # run all tests
mix test test/my_test.exs        # run specific file
mix test test/my_test.exs:14     # run test at specific line
mix test --trace                 # show test names as they run
mix test --failed                # rerun only failed tests
mix test --stale                 # run only tests affected by changes
mix test --cover                 # run with code coverage
mix test --max-failures 3        # stop after 3 failures
mix test --seed 12345            # run with specific seed
mix test --only tag_name         # run tests with specific tag
mix test --exclude tag_name      # exclude tests with specific tag
mix test --timeout 10000         # set timeout in ms
```

### Formatting

```bash
mix format                       # auto-format all files
mix format --check-formatted     # check without modifying
mix format lib/my_file.ex        # format specific file
mix format --dot-formatter path  # use specific formatter config
```

### Documentation

```bash
mix docs                         # generate docs (needs ex_doc dep)
mix hex.docs online some_lib     # open hex docs in browser
```

### Other Mix Tasks

```bash
mix run                          # run the project
mix run -e "IO.puts(:hello)"     # run inline expression
mix run path/to/script.exs       # run a script
mix app.tree                     # show app supervision tree
mix xref graph                   # show module cross-references
mix xref callers MyModule        # who calls this module
mix profile.fprof -e "MyMod.f()" # profile function calls
mix hex.info some_package        # info about a hex package
mix hex.search search_term       # search hex packages
mix local.hex                    # install/update hex
mix archive.install hex phx_new  # install an archive (e.g. phoenix generator)
mix local.rebar                  # install/update rebar
```

---

## Phoenix Framework

### Project Creation

```bash
mix phx.new my_app               # create new phoenix project
mix phx.new my_app --no-ecto     # without database
mix phx.new my_app --no-html     # API only (no HTML views)
mix phx.new my_app --no-assets   # without asset pipeline
mix phx.new my_app --no-live     # without LiveView
mix phx.new my_app --no-mailer   # without mailer
mix phx.new my_app --binary-id   # use binary UUIDs
mix phx.new my_app --database mysql  # use mysql instead of postgres
mix phx.new my_app --live        # with LiveView (default now)
```

### Server

```bash
mix phx.server                   # start the server
iex -S mix phx.server            # start server with iex shell
MIX_ENV=prod mix phx.server      # start in production mode
```

### Code Generators

```bash
# HTML resource (context + schema + controller + views + templates)
mix phx.gen.html Accounts User users name:string email:string age:integer

# JSON API resource
mix phx.gen.json Accounts User users name:string email:string

# LiveView resource
mix phx.gen.live Accounts User users name:string email:string

# Context + schema only (no web layer)
mix phx.gen.context Accounts User users name:string email:string

# Schema + migration only
mix phx.gen.schema Accounts.User users name:string email:string

# Embedded schema (no migration)
mix phx.gen.embedded Accounts.User name:string email:string

# Authentication system
mix phx.gen.auth Accounts User users

# Channel
mix phx.gen.channel Room

# Presence
mix phx.gen.presence

# Notifier (email)
mix phx.gen.notifier Accounts UserNotifier welcome_user reset_password

# Release config
mix phx.gen.release

# Certificate for HTTPS dev
mix phx.gen.cert

# Secret key
mix phx.gen.secret
```

### Phoenix Field Types (for generators)

```
:string, :text, :integer, :float, :decimal, :boolean,
:date, :time, :naive_datetime, :utc_datetime,
:uuid, :binary, :array, :map, :references,
:enum (Ecto 3.5+)

# examples
name:string
bio:text
age:integer
score:float
price:decimal
active:boolean
born_on:date
login_at:utc_datetime
role:enum:admin:user:guest
tags:array:string
metadata:map
user_id:references:users
```

### Routes

```bash
mix phx.routes                   # list all routes
mix phx.routes MyAppWeb.Router   # specify router
```

---

## Ecto (Database)

### Setup

```bash
mix ecto.create                  # create the database
mix ecto.drop                    # drop the database
mix ecto.reset                   # drop + create + migrate
mix ecto.setup                   # create + migrate + seed (if defined in aliases)
```

### Migrations

```bash
mix ecto.gen.migration create_users    # generate a migration
mix ecto.migrate                       # run pending migrations
mix ecto.rollback                      # rollback last migration
mix ecto.rollback --step 3             # rollback last 3 migrations
mix ecto.rollback --to 20210101000000  # rollback to specific version
mix ecto.migrations                    # show migration status
```

### Migration Field Types

```elixir
# inside a migration
create table(:users) do
  add :name, :string, null: false
  add :email, :string, size: 255
  add :age, :integer, default: 0
  add :score, :float
  add :price, :decimal, precision: 10, scale: 2
  add :active, :boolean, default: true
  add :bio, :text
  add :data, :map                   # JSON/JSONB
  add :tags, {:array, :string}      # array of strings
  add :role, :string, default: "user"
  add :born_on, :date
  add :login_at, :utc_datetime
  add :metadata, :binary
  add :team_id, references(:teams, on_delete: :delete_all)

  timestamps()                      # adds inserted_at, updated_at
end

create unique_index(:users, [:email])
create index(:users, [:team_id])
```

### Ecto in IEx

```elixir
# basic queries
alias MyApp.Repo
alias MyApp.Accounts.User

Repo.all(User)                           # get all users
Repo.get(User, 1)                        # get by id
Repo.get!(User, 1)                       # get by id (raises if not found)
Repo.get_by(User, email: "a@b.com")      # get by field
Repo.one(query)                          # expect exactly one result
Repo.insert(%User{name: "Mo"})           # insert
Repo.update(changeset)                   # update
Repo.delete(user)                        # delete
Repo.aggregate(User, :count)             # count all

# query building
import Ecto.Query

User
|> where([u], u.age > 18)
|> where([u], u.active == true)
|> order_by([u], desc: u.inserted_at)
|> limit(10)
|> select([u], {u.name, u.email})
|> Repo.all()

# preloading associations
Repo.all(User) |> Repo.preload(:posts)
Repo.all(from u in User, preload: [:posts])
```

---

## Debugging

```elixir
# IO.inspect - prints and returns (pipe-friendly)
IO.inspect(value)
IO.inspect(value, label: "debug")
IO.inspect(value, limit: :infinity)        # don't truncate
IO.inspect(value, printable_limit: :infinity)  # full strings

# mid-pipeline debugging
data
|> transform()
|> IO.inspect(label: "after transform")
|> save()

# dbg macro (Elixir 1.14+) - shows each step in a pipeline
data
|> transform()
|> filter()
|> dbg()

# Logger
require Logger
Logger.debug("something happened")
Logger.info("user signed in")
Logger.warning("disk almost full")
Logger.error("connection lost")
Logger.debug(fn -> "expensive: #{inspect(big_data)}" end)  # lazy

# :observer (GUI) - system monitor
:observer.start()

# runtime info
Process.list() |> length()         # number of processes
:erlang.memory()                   # memory usage
System.system_time(:second)        # current unix timestamp
```

---

## OTP & Processes

```elixir
# spawn a process
pid = spawn(fn -> IO.puts("hello") end)
Process.alive?(pid)

# send and receive messages
send(self(), {:hello, "world"})
receive do
  {:hello, msg} -> IO.puts(msg)
after
  1000 -> IO.puts("timeout")
end

# tasks (async work)
task = Task.async(fn -> expensive_work() end)
result = Task.await(task)
result = Task.await(task, 10_000)  # with timeout in ms

# GenServer
# see: mix new my_app --sup
# or:  mix phx.gen.context

# Agent (simple state)
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn state -> Map.put(state, :key, "val") end)
Agent.get(pid, fn state -> state end)
```

---

## Releases & Deployment

```bash
# build a release
MIX_ENV=prod mix release

# run release commands
_build/prod/rel/my_app/bin/my_app start
_build/prod/rel/my_app/bin/my_app stop
_build/prod/rel/my_app/bin/my_app restart
_build/prod/rel/my_app/bin/my_app remote    # attach iex to running node
_build/prod/rel/my_app/bin/my_app eval "MyApp.Release.migrate()"

# docker
mix phx.gen.release --docker     # generate Dockerfile
```

---

## Environment & Config

```bash
MIX_ENV=dev mix test             # run in specific env
MIX_ENV=prod mix compile         # compile for prod
MIX_ENV=test iex -S mix          # iex in test env
```

```elixir
# check environment at runtime
Mix.env()                        # :dev, :test, :prod
Application.get_env(:my_app, :key)
Application.fetch_env!(:my_app, :key)
System.get_env("DATABASE_URL")
```

---

## Hex (Package Manager)

```bash
mix hex.info                     # your hex info
mix hex.info package_name        # info about a package
mix hex.search term              # search packages
mix hex.outdated                 # check for outdated deps
mix hex.user register            # register hex account
mix hex.publish                  # publish your package
mix hex.retire pkg ver reason    # retire a version
```

---

## Common Erlang/OTP Commands (usable in Elixir)

```elixir
:timer.sleep(1000)               # sleep 1 second
:crypto.strong_rand_bytes(16)    # random bytes
:erlang.system_info(:process_count)  # process count
:ets.new(:my_table, [:set, :public]) # create ETS table
:sys.get_state(pid)              # get GenServer state (debug only)
:sys.trace(pid, true)            # trace a process
```

---

## Useful One-Liners

```bash
# format all files
mix format

# find unused deps
mix deps.unlock --check-unused

# list all mix tasks
mix help

# see info about a task
mix help compile

# run a one-off script
mix run priv/scripts/seed.exs

# generate a random secret
mix phx.gen.secret
```
