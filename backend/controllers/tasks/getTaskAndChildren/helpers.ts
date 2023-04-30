import { Task } from "@prisma/client";

export const constructParentWithChildren = (
  heirarchicalTasks: Task[],
  rootTaskId: number
): any => {
  const directChildren = heirarchicalTasks.filter(
    (task) => task.parentTaskId === rootTaskId
  );
  return directChildren.map((task) => {
    return {
      ...task,
      childTasks: constructParentWithChildren(heirarchicalTasks, task.taskId),
    };
  });
};
