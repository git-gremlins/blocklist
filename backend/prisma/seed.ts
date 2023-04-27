import { PrismaClient } from "@prisma/client";

const p = new PrismaClient();

const seedData = [
  {
    name: "Task 1",
    description: "This is the first task in the project",
  },
  {
    name: "Task 2",
    description: "This is the second task in the project",
  },
  {
    name: "Task 3",
    description: "This is the third task in the project",
  },
  {
    name: "Task 4",
    description: "This is the fourth task in the project",
  },
  // {
  //   name: "Subtask 1.1",
  //   description: "This is a subtask of Task 1",
  //   parentTaskId: 1,
  // },
  // {
  //   name: "Subtask 1.2",
  //   description: "This is another subtask of Task 1",
  //   parentTaskId: 1,
  // },
  // {
  //   name: "Subtask 2.1",
  //   description: "This is a subtask of Task 2",
  //   parentTaskId: 2,
  // },
  // {
  //   name: "Subtask 2.2",
  //   description: "This is another subtask of Task 2",
  //   parentTaskId: 2,
  // },
  // {
  //   name: "Subtask 3.1",
  //   description: "This is a subtask of Task 3",
  //   parentTaskId: 3,
  // },
  // {
  //   name: "Subtask 3.2",
  //   description: "This is another subtask of Task 3",
  //   parentTaskId: 3,
  // },
  // {
  //   name: "Subtask 4.1",
  //   description: "This is a subtask of Task 4",
  //   parentTaskId: 4,
  // },
  // {
  //   name: "Subtask 4.2",
  //   description: "This is another subtask of Task 4",
  //   parentTaskId: 4,
  // },
  // {
  //   name: "Task 5",
  //   description: "This is the fifth task in the project",
  // },
  // {
  //   name: "Task 6",
  //   description: "This is the sixth task in the project",
  // },
  // {
  //   name: "Subtask 1.1.1",
  //   description: "This is a subtask of Subtask 1.1",
  //   parentTaskId: 5,
  // },
  // {
  //   name: "Subtask 1.1.2",
  //   description: "This is another subtask of Subtask 1.1",
  //   parentTaskId: 5,
  // },
  // {
  //   name: "Subtask 2.1.1",
  //   description: "This is a subtask of Subtask 2.1",
  //   parentTaskId: 3,
  // },
  // {
  //   name: "Subtask 2.1.2",
  //   description: "This is another subtask of Subtask 2.1",
  //   parentTaskId: 3,
  // },
];

async function main() {
  seedData.forEach(
    async (data) =>
      await p.task.create({
        data: {
          ...data,
        },
      })
  );
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
