import { router, publicProcedure } from "../../utils/trpc";
import get from "./get";

const userTasksRouter = router({
  get,
});

export default userTasksRouter;
