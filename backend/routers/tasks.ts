import { router, publicProcedure } from "../utils/trpc";
import {
  getTaskAndChildren,
  getTasks,
  getTopLevelTasks,
} from "../controllers/tasks";
import z from "zod";

const tasksRouter = router({
  getTasks: publicProcedure.query(() => getTasks()),
  getParentTasks: publicProcedure.query(() => getTopLevelTasks()),
  getTaskAndChildren: publicProcedure
    .input(z.number())
    .query(({ input: taskId }) => getTaskAndChildren(taskId)),
});

export default tasksRouter;
