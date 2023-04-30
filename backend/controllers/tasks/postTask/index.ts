import p from "../../../utils/prisma";
import { TaskCreateInput } from "../../../prisma/seedData/tasksData";

export const postTask = (task: TaskCreateInput) => {
  return p.task.create({ data: task });
};
