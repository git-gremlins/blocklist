import z from "zod";
import { UpdateTask } from "../../../routers/tasks/update";
import p from "../../../utils/prisma";
import { TRPCError } from "@trpc/server";

type UpdateTask = z.infer<typeof UpdateTask>;

export const updateTask = async ({ taskId, ...input }: UpdateTask) => {
  if (taskId == input.parentTaskId)
    throw new TRPCError({
      message: "Tasks cannot assign themselves as a parent",
      code: "BAD_REQUEST",
    });

  return p.task.update({
    where: { taskId },
    data: input,
  });
};
