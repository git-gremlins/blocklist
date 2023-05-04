import { CreateUser } from "../../../routers/users/post";
import p from "../../../utils/prisma";

export const postUser = (newUser: CreateUser) => {
  return p.user.create({ data: newUser });
};
