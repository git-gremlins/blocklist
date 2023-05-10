import { router } from "../../utils/trpc";
import get from "./get";
import post from "./post";
import update from "./update";

const usersRouter = router({ get, post, update });

export default usersRouter;
