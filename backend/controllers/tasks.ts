import p from "../utils/prisma";

export const getTasks = async (userId?: number) => {
  const tasks = await p.task.findMany({
    where: {
      userId: userId,
    },
  });
  return tasks;
};

export const getParentTasks = async (userId?: number) => {
  const parentTasks = await p.task.findMany({
    where: {
      parentTask: null,
      userId: userId,
    },
  });
  return parentTasks;
};
