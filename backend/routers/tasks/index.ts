import get from "./get";
import post from "./post";
import { router } from "../../utils/trpc";

const tasksRouter = router({
  get,
  post
});

export default tasksRouter;
