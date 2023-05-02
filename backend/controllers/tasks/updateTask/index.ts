import z from "zod";
import { UpdateTask } from "../../../routers/tasks/update";
import p from "../../../utils/prisma";

type UpdateTask = z.infer<typeof UpdateTask>;

export const updateTask = async ({ taskId, ...input }: UpdateTask) => {
  return p.task.update({
    where: { taskId },
    data: input,
  });
};
