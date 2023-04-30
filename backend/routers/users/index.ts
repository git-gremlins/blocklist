import { router } from "../../utils/trpc";
import get from "./get";

const usersRouter = router({ get });

export default usersRouter;
