import { tasksRouter } from "./tasks";
import { router } from "../utils/trpc";

export const appRouter = router({
  tasks: tasksRouter,
});

export type AppRouter = typeof appRouter;
