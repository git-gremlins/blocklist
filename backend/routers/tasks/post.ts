import { publicProcedure, router } from "../../utils/trpc";
import { TaskCreateManyUserInputSchema } from "../../prisma/generated/zod";
import { postTask } from "../../controllers/tasks/postTask";

const tasksPostRouter = router({
  task: publicProcedure
    .input(TaskCreateManyUserInputSchema)
    // because I can't find a zod type without taskId so we destructure it out
    .mutation(({ ctx: { userId }, input: { taskId, ...input } }) => {
      const user = { userId, ...input };
      return postTask(user);
    }),
});

export default tasksPostRouter;
