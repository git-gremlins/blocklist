import { userProcedure, router } from "../../utils/trpc";
import { TaskCreateManyInputSchema } from "../../prisma/generated/zod";
import { postTask } from "../../controllers/tasks/postTask";
import z from "zod";

const tasksPostRouter = router({
  task: userProcedure
    .input(TaskCreateManyInputSchema)
    // because I can't find a zod type without taskId so we destructure it out
    .mutation(({ input: { taskId, ...input } }) => {
      return postTask(input);
    }),
});

export default tasksPostRouter;
