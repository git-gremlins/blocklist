import { Task } from "@prisma/client";
import p from "../utils/prisma";

export const getTasks = async (userId?: number) => {
  const tasks = await p.task.findMany({
    where: {
      userId: userId,
    },
  });
  return tasks;
};

export const getTopLevelTasks = async (userId?: number) => {
  const parentTasks = await p.task.findMany({
    where: {
      parentTask: null,
      userId: userId,
    },
  });
  return parentTasks;
};

type TaskWithChildren = Task & { childTasks?: TaskWithChildren[] };
const constructParentWithChildren = (
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

export const getTaskAndChildren = async (taskId: number) => {
  const parentAndChildren: Task[] = await p.$queryRaw`
    WITH RECURSIVE task_tree AS (
      SELECT *
      FROM "Task"
      WHERE "taskId" = ${taskId}
      UNION ALL
      SELECT t.*
      FROM "Task" t
      JOIN task_tree tt ON t."parentTaskId" = tt."taskId"
    )
    SELECT *
    FROM task_tree;
  `;
  return {
    ...parentAndChildren.find((task) => task.taskId === taskId),
    childTasks: [...constructParentWithChildren(parentAndChildren, taskId)],
  } as TaskWithChildren;
};
