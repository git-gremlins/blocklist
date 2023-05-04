import { PrismaClient } from "@prisma/client";
import { users, tasks } from "./seedData";

const p = new PrismaClient();

async function main() {
  // await clearTables();
  // await resetPermissions();
  await seedUsers();
  await seedTasks();
}

// async function resetPermissions() {
//   await p.$queryRaw`CREATE SCHEMA IF NOT EXISTS "auth";`;
//   await p.$queryRaw`CREATE SCHEMA IF NOT EXISTS "extensions";`;
//   await p.$queryRaw`CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;`;
//   await p.$queryRaw`CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;`;
//   await p.$queryRaw`CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;`;
//   await p.$queryRaw`GRANT usage ON SCHEMA public TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`GRANT usage ON SCHEMA extensions TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER USER supabase_admin SET search_path TO public, extensions;`;
//   await p.$queryRaw`GRANT ALL privileges ON ALL tables IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;`;
//   await p.$queryRaw`GRANT ALL privileges ON ALL functions IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;`;
//   await p.$queryRaw`GRANT ALL privileges ON ALL sequences IN SCHEMA public TO postgres, anon, authenticated, service_role, supabase_admin;`;
//   await p.$queryRaw`ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON tables TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON functions TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER DEFAULT privileges IN SCHEMA public GRANT ALL ON sequences TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON sequences TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON tables TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER DEFAULT privileges FOR USER supabase_admin IN SCHEMA public GRANT ALL ON functions TO postgres, anon, authenticated, service_role;`;
//   await p.$queryRaw`ALTER ROLE anon SET statement_timeout = '3s';`;
//   await p.$queryRaw`ALTER ROLE authenticated SET statement_timeout = '8s';`;
// }

async function clearTables() {
  await p.task.deleteMany();
  await p.$executeRaw`ALTER SEQUENCE "User_userId_seq" RESTART WITH 1`;
  await p.user.deleteMany();
  await p.$executeRaw`ALTER SEQUENCE "Task_taskId_seq" RESTART WITH 1`;
}

async function seedUsers() {
  for (let user of users) await p.user.create({ data: user });
}

async function seedTasks() {
  for (let task of tasks) await p.task.create({ data: task });
}

if (require.main === module) {
  main()
    .then(async () => {
      await p.$disconnect();
    })
    .catch(async (e) => {
      console.error(e);
      await p.$disconnect();
      process.exit(1);
    });
}

export default main;
