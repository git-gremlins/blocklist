import { router } from "../../utils/trpc";
import get from "./get";
import post from "./post";

const usersRouter = router({ get, post });

export default usersRouter;
