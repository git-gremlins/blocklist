import { UpdateUser } from "../../../routers/users/update";
import p from "../../../utils/prisma";

export const updateUser = ({ userId, ...updateUser }: UpdateUser) => {
  return p.user.update({ data: updateUser, where: { userId: userId } });
};
