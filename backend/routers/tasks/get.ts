import {
  getTaskAndAllParents,
  getTaskAndChildren,
  getTasks,
  getTopLevelTasks,
} from "../../controllers/tasks";
import { router, publicProcedure } from "../../utils/trpc";
import z from "zod";

const tasksGetRouter = router({
  tasks: publicProcedure.query(() => getTasks()),
  parentTasks: publicProcedure.query(() => getTopLevelTasks()),
  taskAndChildren: publicProcedure
    .input(z.number())
    .query(({ input: taskId }) => getTaskAndChildren(taskId)),
  taskAndParents: publicProcedure
    .input(z.number())
    .query(({ input: taskId }) => getTaskAndAllParents(taskId)),
});

export default tasksGetRouter;
