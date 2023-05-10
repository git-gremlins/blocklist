import z from "zod";
import { router, userProcedure } from "../../utils/trpc";
import { deleteTask } from "../../controllers/tasks/deleteTask";

const taskDeleteRouter = router({
  task: userProcedure
    .input(z.object({ taskId: z.number() }))
    .mutation(({ input: { taskId } }) => deleteTask(taskId)),
});

export default taskDeleteRouter;
