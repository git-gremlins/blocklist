import p from "../utils/prisma";

export const getTasks = async () => {
  const tasks = await p.task.findMany();
  return tasks;
};
