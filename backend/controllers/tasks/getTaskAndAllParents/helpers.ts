import { Task } from "@prisma/client";
import { TaskWithChild } from ".";

export const orderTasks = (
  tasks: Task[],
  orderedTasks: Task[] = []
): Task[] => {
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

export const nestTasks = (orderedTasks: Task[]) => {
  let result = orderedTasks.at(-1) as TaskWithChild;
  for (let i = orderedTasks.length - 2; i >= 0; i--) {
    result = { ...orderedTasks[i], child: result };
  }
  return result;
};
