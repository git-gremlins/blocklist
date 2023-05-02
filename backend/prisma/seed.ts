import { PrismaClient } from "@prisma/client";
import { users, tasks } from "./seedData";

const p = new PrismaClient();

async function main() {
  await seedUsers();
  await seedTasks();
}

async function seedUsers() {
  // users.forEach(async (user) => await p.user.create({ data: user }));
  for (let user of users) {
    await p.user.create({ data: user });
  }
}

async function seedTasks() {
  for (let task of tasks) {
    await p.task.create({ data: task });
  }
}

main()
  .then(async () => {
    await p.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await p.$disconnect();
    process.exit(1);
  });
