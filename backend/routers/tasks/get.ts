import {
  getTaskAndAllParents,
  getTaskAndChildren,
  getTasks,
  getTopLevelTasks,
} from "../../controllers/tasks";
import { router, userProcedure } from "../../utils/trpc";
import z from "zod";

const tasksGetRouter = router({
  tasks: userProcedure.query(() => getTasks()),
  parentTasks: userProcedure.query(() => getTopLevelTasks()),
  taskAndChildren: userProcedure
    .input(z.number())
    .query(({ input: taskId }) => getTaskAndChildren(taskId)),
  taskAndParents: userProcedure
    .input(z.number())
    .query(({ input: taskId }) => getTaskAndAllParents(taskId)),
});

export default tasksGetRouter;
