import z from "zod";
import { publicProcedure, router } from "../../utils/trpc";
import { UserCreateManyInputSchema } from "../../prisma/generated/zod";
import { postUser } from "../../controllers/users";

export type CreateUser = z.infer<typeof UserCreateManyInputSchema>;

const usersPostRouter = router({
  user: publicProcedure
    .input(UserCreateManyInputSchema)
    .mutation(({ input: newUser }) => postUser(newUser)),
});

export default usersPostRouter;
