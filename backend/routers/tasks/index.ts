import get from "./get";
import post from "./post";
import update from "./update";
import remove from "./remove";
import { router } from "../../utils/trpc";

const tasksRouter = router({
  get,
  post,
  update,
  remove,
});

export default tasksRouter;
