import { PrismaClient } from "@prisma/client";
import { users, tasks } from "./seedData";

const p = new PrismaClient();

async function main() {
  await seedUsers();
  await seedTasks();
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
