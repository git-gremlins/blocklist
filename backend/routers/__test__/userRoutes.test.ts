import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";

describe("getUsers", () => {
  it("should return an array", async () => {
    const users = await trpcClient.users.getUsers.query();
    expect(Array.isArray(users)).toBe(true);
  });
  it("returned array should have length of 3", async () => {
    const users = await trpcClient.users.getUsers.query();
    expect(users).toHaveLength(3);
  });
  it("Each task array element should match our object type of user", async () => {
    const zUser = z.object({
      userId: z.number(),
      name: z.string(),
      surname: z.string(),
      settings: z.string(),
    });
    const users = await trpcClient.users.getUsers.query();
    users.map((user) => {
      expect(zUser.safeParse(user)).not.toBeUndefined();
    });
  });
});
