import { PrismaClient } from "@prisma/client";
import { users, tasks } from "./seedData";

const p = new PrismaClient();

async function main() {
  await clearTables();
  await seedUsers();
  await seedTasks();
}

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
