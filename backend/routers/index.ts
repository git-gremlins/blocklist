import { router } from "../utils/trpc";
import tasksRouter from "./tasks";
import userTasksRouter from "./userTasks";
import usersRouter from "./users";

export const appRouter = router({
  tasks: tasksRouter,
  userTasks: userTasksRouter,
  users: usersRouter,
});

export type AppRouter = typeof appRouter;
