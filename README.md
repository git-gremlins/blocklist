# The app and why we wanted to make make

# Tech stack

## Typescript

Not much to say here. You should always be using `typescript`. If you aren't
you're probably writing bad code, you just don't even know it. And how could
you, to be fair, `javascript` is not designed in a way that makes it easy to
write good code.

## Backend

### Prisma: ORM

Allows you to define you database schema, so table columns and their relations
all in one `schema.prisma` which it then treats as a singular source of truth
for your database. Prisma then uses this schema to generate both `typescript`
and, in our case, `zod` types which are added to your project's global types.
As you use the Prisma client in your `typescript` files, you will alerted to
what fields are needed when performing any CRUD action.

### Postgres

`postgres` was almost necessitated by this app because of the hierarchical
nature of the data. After some research, other than using a graph-style
database which would be a challenge to implement, or a document style database
which felt like a lazy solution, the `postgres` SQL dialect made it relatively
easy to perform **recursive queries**. We needed this functionality so that we
could have a smooth UX by querying the primordial tasks of a user and
recursively getting all their children in once query. This create a one-time
load cost for the user.

### Supabase

Supabase is an open-source Firebase alternative. You avoid the vendor lock in as
you are simply dealing with `postgres` databases. Because of this fact, it is
relatively easy to get a `docker` instance of your entire supabase service up
and running. Theoretically, if the service suited your needs, you could deploy
your own docker image of it in any way you want. You don't need to pay supabase
a penny.

As to the actual services we utilised, we used their authentication tables and
web-socket streaming to allow for tasks to instantly render upon creation.

Finally, Prisma allows you to reflect an existing database onto a schema file.
Our Auth service [Supabase](https://supabase.com) is simply a large `postgres`
database with multiple schema. Prisma allowed us to reflect these schema and use
their fields in our defined tables as relations. This solves the issue of your
Auth tables being out of sync with your user tables.

### Server

To get our application to interact with our database, we set up a server using
`TRPC` with endpoints for our frontend to hit which would then get Prisma to
interact with our Supabase `postgres` instance. You can think of `TRPC` as an
API client that tells you the `typescript` when you make a request to an
endpoint. I.e., because Prisma returns a strongly typed `typescript` object,
a TRPC client then knows that this particular type of object is being returned.

On top of this. If you use `zod` you never have to manually validated input. You
simply specify a schema to match in your trpc route and if the request body does
not match this schema, an error is sent to your consumer.

## Frontend

The design of our app made flutter the only known option when it came to
frontend technologies. The design of our app hinges on this very malleable grid
which ruled React Native out of the question as there is no support for gird
layouts in Native.
