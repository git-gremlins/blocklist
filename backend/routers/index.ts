import { router } from "../utils/trpc";
import userTasksRouter from "./userTasks";
import usersRouter from "./users";

export const appRouter = router({
  userTasks: userTasksRouter,
  users: usersRouter,
});

export type AppRouter = typeof appRouter;
