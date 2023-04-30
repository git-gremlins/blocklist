import trpcClient from "../../utils/trpc/trpsTestClient";
import { zTask } from "./userTasksRouter.test";

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
    const tasks = await trpcClient.tasks.getTasks.query();
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});

describe("getParentTasks", () => {
  it("should return an array", async () => {
    const parentTasks = await trpcClient.tasks.getParentTasks.query();
    expect(Array.isArray(parentTasks)).toBe(true);
  });
  it("array should have a length of 10", async () => {
    const parentTasks = await trpcClient.tasks.getParentTasks.query();
    expect(parentTasks).toHaveLength(10);
  });
  it("each tasks should have null in parentTaskId field", async () => {
    const parentTasks = await trpcClient.tasks.getParentTasks.query();
    expect(parentTasks).toHaveLength(10);
    parentTasks.forEach((parentTask) =>
      expect(parentTask.parentTaskId).toBe(null)
    );
  });
});
