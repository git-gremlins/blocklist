import z from "zod";
import { router, publicProcedure } from "../utils/trpc";
import { getTasks } from "../controllers/tasks";

const tasksRouter = router({
  getTasks: publicProcedure.query(getTasks),
  // post: publicProcedure
  //   .input(
  //     z.object({
  //       name: z.string(),
  //       description: z.string(),
  //       parentTaskId: z.optional(z.number()),
  //     })
  //   )
  //   .mutation(async ({ input }) => {
  //     const newTask = await p.task.create({
  //       data: {
  //         ...input,
  //       },
  //     });
  //     return newTask;
  //   }),
});

export default tasksRouter;
