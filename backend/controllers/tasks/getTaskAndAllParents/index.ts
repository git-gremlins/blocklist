import { Task } from "@prisma/client";
import { nestTasks, orderTasks } from "./helpers";
import p from "../../../utils/prisma";

export type TaskWithChild = Task & { child?: TaskWithChild };
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
