import { Task } from "@prisma/client";
import { constructParentWithChildren } from "./helpers";
import p from "../../../utils/prisma";

export type TaskWithChildren = Task & { childTasks?: TaskWithChildren[] };

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
