import p from "../../../utils/prisma";

export const deleteTask = async (taskId: number) => {
  return await p.task.delete({
    where: { taskId: taskId },
  });
};
