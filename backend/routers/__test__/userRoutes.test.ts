import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";

const zUser = z.object({
  userId: z.number(),
  name: z.string(),
  surname: z.string(),
  settings: z.any(),
});

describe("getUsers", () => {
  it("should return an array", async () => {
    const users = await trpcClient.users.get.users.query();
    expect(Array.isArray(users)).toBe(true);
  });
  it("returned array should have length of 7", async () => {
    const users = await trpcClient.users.get.users.query();
    expect(users).toHaveLength(3);
  });
  it("Each task array element should match our object type of user", async () => {
    const users = await trpcClient.users.get.users.query();
    users.map((user) => {
      expect(zUser.parse(user)).not.toBeUndefined();
    });
  });
});

describe("get.user", () => {
  const query = trpcClient.users.get.user.query(1);
  it("should return an object", async () => {
    const user = await query;
    expect(typeof user).toBe("object");
  });
  it("user object should match the first user data in the database", async () => {
    const user = await query;
    expect(user).toEqual({
      userId: 1,
      name: "John",
      surname: "Doe",
      settings: {},
    });
  });
});
