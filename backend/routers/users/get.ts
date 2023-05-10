import z from "zod";
import { getUser, getUsers } from "../../controllers/users";
import { userProcedure, router } from "../../utils/trpc";

const usersGetRouter = router({
  users: userProcedure.query(getUsers),
  user: userProcedure.input(z.string()).query(async ({ input: userId }) => {
    const user = await getUser(userId);
    return user;
  }),
});

export default usersGetRouter;
