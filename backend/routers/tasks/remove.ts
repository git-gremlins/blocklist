import z from "zod";
import { router, publicProcedure } from "../../utils/trpc";
import { deleteTask } from "../../controllers/tasks/deleteTask";

const taskDeleteRouter = router({
  task: publicProcedure
    .input(z.object({ taskId: z.number() }))
    .mutation(({ input: { taskId } }) => deleteTask(taskId)),
});

export default taskDeleteRouter;
