import p from "../../../utils/prisma";

export const getTasks = async (userId?: string) => {
  const tasks = await p.task.findMany({
    where: {
      userId: userId,
    },
  });
  return tasks;
};
