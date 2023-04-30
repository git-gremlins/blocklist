import { router, publicProcedure } from "../utils/trpc";
import { getTasks, getParentTasks } from "../controllers/tasks";

const tasksRouter = router({
  getTasks: publicProcedure.query(() => getTasks()),
  getParentTasks: publicProcedure.query(() => getParentTasks()),
});

export default tasksRouter
