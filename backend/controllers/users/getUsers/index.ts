import p from "../../../utils/prisma";

export const getUsers = async () => {
  const users = await p.user.findMany();
  return users;
};

