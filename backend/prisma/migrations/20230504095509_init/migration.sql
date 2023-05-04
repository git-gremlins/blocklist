-- CREATE SCHEMA IF NOT EXISTS "auth";
--
-- CREATE SCHEMA IF NOT EXISTS "extensions";
--
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;
--
-- CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;
--
-- CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;
--
-- GRANT usage ON SCHEMA public TO postgres, anon, authenticated, service_role;
--
-- GRANT usage ON SCHEMA extensions TO postgres, anon, authenticated, service_role;
--
-- ALTER USER supabase_admin SET search_path TO public, extensions;
--
-- -- don't include the "auth" schema
-- GRANT ALL privileges ON ALL tables IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;
--
-- GRANT ALL privileges ON ALL functions IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;
--
-- GRANT ALL privileges ON ALL sequences IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;
--
-- ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON tables TO postgres, anon, authenticated, service_role;
--
-- ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON functions TO postgres, anon, authenticated, service_role;
--
-- ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON sequences TO postgres, anon, authenticated, service_role;
--
-- ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON sequences TO postgres, anon, authenticated, service_role;
--
-- ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON tables TO postgres, anon, authenticated, service_role;
--
-- ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON functions TO postgres, anon, authenticated, service_role;
--
-- ALTER ROLE anon SET statement_timeout = '3s';
--
-- ALTER ROLE authenticated SET statement_timeout = '8s';

-- CreateEnum
CREATE TYPE "Importance" AS ENUM (
    'low',
    'medium',
    'high'
);

-- CreateTable
CREATE TABLE "User" (
    "userId" text NOT NULL,
    "name" text NOT NULL,
    "surname" text NOT NULL,
    "settings" jsonb NOT NULL DEFAULT '{}',
    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Task" (
    "taskId" serial NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "parentTaskId" integer,
    "userId" text NOT NULL,
    "importance" "Importance" NOT NULL,
    "deadline" timestamp(3),
    "startRow" integer NOT NULL,
    "startCol" integer NOT NULL,
    "endRow" integer NOT NULL,
    "endCol" integer NOT NULL,
    CONSTRAINT "Task_pkey" PRIMARY KEY ("taskId")
);

-- AddForeignKey
ALTER TABLE "Task"
    ADD CONSTRAINT "Task_parentTaskId_fkey" FOREIGN KEY ("parentTaskId") REFERENCES "Task" ("taskId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task"
    ADD CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("userId") ON DELETE CASCADE ON UPDATE CASCADE;
