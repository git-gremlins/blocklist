import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";

describe("getTasks", () => {
  it("should return an array", async () => {
    const tasks = await trpcClient.tasks.getTasks.query();
    expect(Array.isArray(tasks)).toBe(true);
  });
  it("returned array should have length of 20", async () => {
    const tasks = await trpcClient.tasks.getTasks.query();
    expect(tasks).toHaveLength(20);
  });
  it("Each task array element should match our object type of task", async () => {
    const zTask = z.object({
      taskId: z.number(),
      name: z.string(),
      description: z.string(),
      parentTaskId: z.number().nullable(),
      userId: z.number(),
      importance: z.string(),
      deadline: z.date().nullable(),
    });
    const tasks = await trpcClient.tasks.getTasks.query();
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});
