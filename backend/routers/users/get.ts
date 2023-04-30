import z from "zod";
import { getUser, getUsers } from "../../controllers/users";
import { publicProcedure, router } from "../../utils/trpc";

const usersGetRouter = router({
  users: publicProcedure.query(getUsers),
  user: publicProcedure
    .input(z.object({ userId: z.number() }))
    .query(async ({ input: { userId } }) => {
      const user = await getUser(userId);
      return user;
    }),
});

export default usersGetRouter;
