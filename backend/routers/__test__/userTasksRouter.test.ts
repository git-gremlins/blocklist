import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";

export const zTask = z.object({
  taskId: z.number(),
  name: z.string(),
  description: z.string(),
  parentTaskId: z.number().nullable(),
  userId: z.number(),
  importance: z.string(),
  deadline: z.date().nullable(),
});

describe("getTasks", () => {
  it("should return an array", async () => {
    const tasks = await trpcClient.userTasks.getTasks.query();
    expect(Array.isArray(tasks)).toBe(true);
  });
  it("returned array should have length of 7", async () => {
    const tasks = await trpcClient.userTasks.getTasks.query();
    expect(tasks).toHaveLength(17);
  });
  it("Each task array element should match our object type of task", async () => {
    const tasks = await trpcClient.userTasks.getTasks.query();
    expect(tasks).toHaveLength(17);
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});

describe("getUserParentTasks", () => {
  it("should return an array", async () => {
    const parentTasks = await trpcClient.userTasks.getParentTasks.query();
    expect(Array.isArray(parentTasks)).toBe(true);
  });
  it("array should have a length of 7", async () => {
    const parentTasks = await trpcClient.userTasks.getParentTasks.query();
    expect(parentTasks).toHaveLength(7);
  });
  it("each tasks should have null in parentTaskId field", async () => {
    const parentTasks = await trpcClient.userTasks.getParentTasks.query();
    expect(parentTasks).toHaveLength(7);
    parentTasks.forEach((parentTask) =>
      expect(parentTask.parentTaskId).toBe(null)
    );
  });
});
