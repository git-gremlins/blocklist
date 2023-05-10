import { publicProcedure, router } from "../../utils/trpc";
import { UserUncheckedCreateInputSchema } from "../../prisma/generated/zod";
import { updateUser } from "../../controllers/users";
import z from "zod";

export type UpdateUser = Omit<
  z.infer<typeof UserUncheckedCreateInputSchema>,
  "Tasks"
>;

const updateUserRouter = router({
  user: publicProcedure
    .input(UserUncheckedCreateInputSchema)
    .mutation(({ input }) => {
      return updateUser(input);
    }),
});

export default updateUserRouter;
