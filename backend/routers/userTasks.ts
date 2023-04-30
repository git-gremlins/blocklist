import { router, publicProcedure } from "../utils/trpc";
import {
  getTasks,
  getTopLevelTasks,
} from "../controllers/tasks";

const userTasksRouter = router({
  getTasks: publicProcedure.query(({ ctx: { userId } }) => getTasks(userId)),
  getParentTasks: publicProcedure.query(({ ctx: { userId } }) =>
    getTopLevelTasks(userId)
  ),
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

export default userTasksRouter;
