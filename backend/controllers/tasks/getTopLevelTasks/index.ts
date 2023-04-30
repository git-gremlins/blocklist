import p from "../../../utils/prisma";

export const getTopLevelTasks = async (userId?: number) => {
  const parentTasks = await p.task.findMany({
    where: {
      parentTask: null,
      userId: userId,
    },
  });
  return parentTasks;
};
