import { router } from "../utils/trpc";
import tasksRouter from "./tasks";
import usersRouter from "./users";

export const appRouter = router({
  tasks: tasksRouter,
  users: usersRouter,
});

export type AppRouter = typeof appRouter;
