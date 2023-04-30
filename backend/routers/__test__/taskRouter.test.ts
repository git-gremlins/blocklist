import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";
import { zTask } from "./userTasksRouter.test";
import { TaskWithChild } from "../../controllers/tasks/getTaskAndAllParents";

describe("getTasks", () => {
  const query = trpcClient.tasks.get.tasks.query();
  it("should return an array", async () => {
    const tasks = await query;
    expect(Array.isArray(tasks)).toBe(true);
  });
  it("returned array should have length of 20", async () => {
    const tasks = await query;
    expect(tasks).toHaveLength(20);
  });
  it("Each task array element should match our object type of task", async () => {
    const tasks = await query;
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});

describe("getParentTasks", () => {
  const query = trpcClient.tasks.get.parentTasks.query();
  it("should return an array", async () => {
    const parentTasks = await query;
    expect(Array.isArray(parentTasks)).toBe(true);
  });
  it("array should have a length of 10", async () => {
    const parentTasks = await query;
    expect(parentTasks).toHaveLength(10);
  });
  it("each tasks should have null in parentTaskId field", async () => {
    const parentTasks = await query;
    expect(parentTasks).toHaveLength(10);
    parentTasks.forEach((parentTask) =>
      expect(parentTask.parentTaskId).toBe(null)
    );
  });
});

describe("getTaskAndChildren", () => {
  const query = trpcClient.tasks.get.taskAndChildren.query(10);
  it("should return an object", async () => {
    const taskAndChildren = await query;
    expect(Array.isArray(taskAndChildren)).toBe(false);
    expect(typeof taskAndChildren).toBe("object");
  });
  it("all tasks in child tasks should reference the parent task as their foreign key", async () => {
    const taskAndChildren = await query;
    const childrenTasks = taskAndChildren.childTasks;
    expect(childrenTasks).toHaveLength(9);
    childrenTasks?.forEach((task) => expect(task.parentTaskId).toBe(10));
  });
});

describe("getTaskAndParents", () => {
  const queryRoute = trpcClient.tasks.get.taskAndParents;
  it("should return an object", async () => {
    const taskAndChildren = await queryRoute.query(19);
    expect(Array.isArray(taskAndChildren)).toBe(false);
    expect(typeof taskAndChildren).toBe("object");
  });
  it("all child keys should return an object", async () => {
    const checkChildType = (parentTask: TaskWithChild) => {
      if (!parentTask.child) return;
      expect(typeof parentTask.child).toBe("object");
    };
    const taskAndChildren = (await queryRoute.query(19)) as TaskWithChild;
    checkChildType(taskAndChildren);
  });
  it("all child objects should match Task object", async () => {
    const checkChildStructure = (parentTask: TaskWithChild) => {
      if (!parentTask.child) return;
      const zTaskWithChild = zTask.merge(
        z.object({ child: z.optional(z.any()) })
      );
      zTaskWithChild.parse(parentTask);
    };
    const taskAndChildren = (await queryRoute.query(19)) as TaskWithChild;
    checkChildStructure(taskAndChildren);
  });
  it("each child task should reference its direct parent", async () => {
    const checkChildReference = (parentTask: TaskWithChild) => {
      if (!parentTask.child) return;
      expect(parentTask.taskId).toBe(parentTask.child.parentTaskId);
    };
    const taskAndChildren = (await queryRoute.query(
      19
    )) as TaskWithChild;
    checkChildReference(taskAndChildren);
  });
});
