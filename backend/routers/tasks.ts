import z from "zod";
import p from "../utils/prisma";
import { router, publicProcedure } from "../utils/trpc";

export const tasksRouter = router({
  get: publicProcedure.query(async () => {
    const tasks = await p.task.findMany();
    return tasks;
  }),
  post: publicProcedure
    .input(
      z.object({
        name: z.string(),
        description: z.string(),
        parentTaskId: z.optional(z.number()),
      })
    )
    .mutation(async ({ input }) => {
      const newTask = await p.task.create({
        data: {
          ...input,
        },
      });
      return newTask;
    }),
});
