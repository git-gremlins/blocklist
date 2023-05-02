import get from "./get";
import post from "./post";
import update from "./update";
import { router } from "../../utils/trpc";

const tasksRouter = router({
  get,
  post,
  update,
});

export default tasksRouter;
