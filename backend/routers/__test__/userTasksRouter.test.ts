import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";

export const zTask = z.object({
  taskId: z.number(),
  name: z.string(),
  description: z.string(),
  parentTaskId: z.number().nullable(),
  userId: z.string(),
  importance: z.string(),
  deadline: z.date().nullable(),
});

describe("getTasks", () => {
  const query = trpcClient.userTasks.get.tasks.query();
  it("should return an array", async () => {
    const tasks = await query;
    expect(Array.isArray(tasks)).toBe(true);
  });
  it("returned array should have length of 7", async () => {
    const tasks = await query;
    expect(tasks).toHaveLength(10);
  });
  it("Each task array element should match our object type of task", async () => {
    const tasks = await query;
    expect(tasks).toHaveLength(10);
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});

describe("getUserParentTasks", () => {
  const query = trpcClient.userTasks.get.parentTasks.query("1");
  it("should return an array", async () => {
    const parentTasks = await query;
    expect(Array.isArray(parentTasks)).toBe(true);
  });
  it("array should have a length of 4", async () => {
    const parentTasks = await query;
    expect(parentTasks).toHaveLength(4);
  });
  it("each tasks should have null in parentTaskId field", async () => {
    const parentTasks = await query;
    expect(parentTasks).toHaveLength(4);
    parentTasks.forEach((parentTask) =>
      expect(parentTask.parentTaskId).toBe(null)
    );
  });
});
