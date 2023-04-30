import get from "./get";
import { router } from "../../utils/trpc";

const tasksRouter = router({
  get,
});

export default tasksRouter;
