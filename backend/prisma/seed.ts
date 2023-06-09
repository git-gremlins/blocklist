import { PrismaClient } from "@prisma/client";
import { users, tasks } from "./seedData";

const p = new PrismaClient();

async function main() {
  await clearTables();
  await enableRealtime("Task");
  await seedUsers();
  await seedTasks();
}

async function enableRealtime(...tables: string[]) {
  for (let table of tables) {
    await p.$executeRawUnsafe(`begin;`);
    await p.$executeRawUnsafe(`drop publication if exists supabase_realtime;`);
    await p.$executeRawUnsafe(`create publication supabase_realtime;`);
    await p.$executeRawUnsafe(`commit;`);
    await p.$executeRawUnsafe(
      `alter publication supabase_realtime add table "${table}";`
    );
  }
}

async function clearTables() {
  await p.task.deleteMany();
  await p.$executeRaw`ALTER SEQUENCE "Task_taskId_seq" RESTART WITH 1`;
  await p.user.deleteMany();
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
