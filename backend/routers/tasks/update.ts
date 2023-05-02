import z from "zod";
import { TaskUncheckedUpdateManyInputSchema } from "../../prisma/generated/zod";
import { router, publicProcedure } from "../../utils/trpc";
import { updateTask } from "../../controllers/tasks";

export const UpdateTask = TaskUncheckedUpdateManyInputSchema.and(
  z.object({ taskId: z.number() })
);

const tasksUpdateRouter = router({
  task: publicProcedure
    .input(UpdateTask)
    .mutation(({ input }) => updateTask(input)),
});

export default tasksUpdateRouter;
