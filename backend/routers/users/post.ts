import z from "zod";
import { publicProcedure, router } from "../../utils/trpc";
import { UserCreateWithoutTasksInputSchema } from "../../prisma/generated/zod";
import { postUser } from "../../controllers/users";

export type CreateUser = z.infer<typeof UserCreateWithoutTasksInputSchema>;

const usersPostRouter = router({
  user: publicProcedure
    .input(UserCreateWithoutTasksInputSchema)
    .mutation(({ input: newUser }) => postUser(newUser)),
});

export default usersPostRouter;
