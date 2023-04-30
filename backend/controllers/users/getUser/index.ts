import p from "../../../utils/prisma";

export const getUser = async (userId: number) => {
  const user = await p.user.findUnique({
    where: { userId: userId },
  });
  return user;
};
