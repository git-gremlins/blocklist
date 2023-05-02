import p from "../../../utils/prisma";

export const getTasks = async (userId?: number) => {
  const tasks = await p.task.findMany({
    where: {
      userId: userId,
    },
  });
  return tasks;
};
