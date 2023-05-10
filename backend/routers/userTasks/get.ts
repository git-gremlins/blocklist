import z from "zod";
import { getTasks, getTopLevelTasks } from "../../controllers/tasks";
import { router, userProcedure } from "../../utils/trpc";
const userTasksGet = router({
  tasks: userProcedure.query(({ ctx: { userId } }) => getTasks(userId)),
  // parentTasks: publicProcedure.query(({ ctx: { userId } }) =>
  //   getTopLevelTasks(userId)
  // ),
  parentTasks: userProcedure
    .input(z.string())
    .query(({ input: userId }) => getTopLevelTasks(userId)),
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
