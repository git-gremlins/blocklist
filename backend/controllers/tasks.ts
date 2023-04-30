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

export type TaskWithChild = Task & { child?: TaskWithChild };
const orderTasks = (tasks: Task[], orderedTasks: Task[] = []): Task[] => {
  if (!orderedTasks.length) {
    const rootTask = tasks.find((task) => !task.parentTaskId);
    if (!rootTask) return [];
    const remainingTasks = tasks.filter((task) => task.parentTaskId);
    return orderTasks(remainingTasks, [rootTask]);
  }

  const previousTask = orderedTasks.at(-1)!;
  const nextTask = tasks.find(
    (task) => task.parentTaskId === previousTask.taskId
  );

  if (!nextTask) return orderedTasks;
  const remainingTasks = tasks.filter(
    (task) => task.taskId !== nextTask.taskId
  );

  return orderTasks(remainingTasks, [...orderedTasks, nextTask]);
};
const nestTasks = (orderedTasks: Task[]) => {
  let result = orderedTasks.at(-1) as TaskWithChild;
  for (let i = orderedTasks.length - 2; i >= 0; i--) {
    result = { ...orderedTasks[i], child: result };
  }
  return result;
};

export const getTaskAndAllParents = async (taskId: number) => {
  const childAndParents: Task[] = await p.$queryRaw`
    WITH RECURSIVE task_path AS (
      SELECT *
      FROM "Task"
      WHERE "taskId" = ${taskId}
      UNION ALL
      SELECT t.*
      FROM "Task" t
      JOIN task_path tp ON t."taskId" = tp."parentTaskId"
    )
    SELECT *
    FROM task_path;
  `;
  const orderedTasks = orderTasks(childAndParents);
  return nestTasks(orderedTasks);
};
