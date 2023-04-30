import { getTasks, getTopLevelTasks } from "../../controllers/tasks";
import { router, publicProcedure } from "../../utils/trpc";
const userTasksGet = router({
  tasks: publicProcedure.query(({ ctx: { userId } }) => getTasks(userId)),
  parentTasks: publicProcedure.query(({ ctx: { userId } }) =>
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

export default userTasksGet;
