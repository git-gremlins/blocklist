import z from "zod";
import trpcClient from "../../utils/trpc/trpsTestClient";
import { zTask } from "./userTasksRouter.test";
import { TaskWithChild } from "../../controllers/tasks/getTaskAndAllParents";

describe("getTasks", () => {
  const query = trpcClient.tasks.get.tasks;
  it("should return an array", async () => {
    const tasks = await query.query();
    expect(Array.isArray(tasks)).toBe(true);
  });
  it("returned array should have length of 20", async () => {
    const tasks = await query.query();
    expect(tasks).toHaveLength(12);
  });
  it("Each task array element should match our object type of task", async () => {
    const tasks = await query.query();
    tasks.map((task) => {
      expect(zTask.parse(task)).not.toBeUndefined();
    });
  });
});

describe("getParentTasks", () => {
  const query = trpcClient.tasks.get.parentTasks;
  it("should return an array", async () => {
    const parentTasks = await query.query();
    expect(Array.isArray(parentTasks)).toBe(true);
  });
  it("array should have a length of 10", async () => {
    const parentTasks = await query.query();
    expect(parentTasks).toHaveLength(6);
  });
  it("each tasks should have null in parentTaskId field", async () => {
    const parentTasks = await query.query();
    expect(parentTasks).toHaveLength(6);
    parentTasks.forEach((parentTask) =>
      expect(parentTask.parentTaskId).toBe(null)
    );
  });
});

describe("getTaskAndChildren", () => {
  const query = trpcClient.tasks.get.taskAndChildren;
  it("should return an object", async () => {
    const taskAndChildren = await query.query(6);
    expect(Array.isArray(taskAndChildren)).toBe(false);
    expect(typeof taskAndChildren).toBe("object");
  });
  it("all tasks in child tasks should reference the parent task as their foreign key", async () => {
    const taskAndChildren = await query.query(6);
    const childrenTasks = taskAndChildren.childTasks;
    expect(childrenTasks).toHaveLength(5);
    childrenTasks?.forEach((task) => expect(task.parentTaskId).toBe(6));
  });
});

describe("getTaskAndParents", () => {
  const queryRoute = trpcClient.tasks.get.taskAndParents;
  it("should return an object", async () => {
    const taskAndChildren = await queryRoute.query(12);
    expect(Array.isArray(taskAndChildren)).toBe(false);
    expect(typeof taskAndChildren).toBe("object");
  });
  it("all child keys should return an object", async () => {
    const checkChildType = (parentTask: TaskWithChild) => {
      if (!parentTask.child) return;
      expect(typeof parentTask.child).toBe("object");
    };
    const taskAndChildren = (await queryRoute.query(12)) as TaskWithChild;
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
    const taskAndChildren = (await queryRoute.query(12)) as TaskWithChild;
    checkChildStructure(taskAndChildren);
  });
  it("each child task should reference its direct parent", async () => {
    const checkChildReference = (parentTask: TaskWithChild) => {
      if (!parentTask.child) return;
      expect(parentTask.taskId).toBe(parentTask.child.parentTaskId);
    };
    const taskAndChildren = (await queryRoute.query(12)) as TaskWithChild;
    checkChildReference(taskAndChildren);
  });
});
//
// describe("post.task", () => {
//   const deadline = new Date();
//   const newTask: Omit<Task, "taskId" | "userId"> = {
//     name: "Kamal's task",
//     description: "This is a test task",
//     parentTaskId: 19,
//     importance: "high",
//     deadline,
//   };
//   const query = trpcClient.tasks.post.task;
//   it("should return an object", async () => {
//     const result = await query.mutate(newTask);
//     expect(typeof result).toBe("object");
//   });
//   it("returned value should match exactly this object", async () => {
//     const result = await query.mutate(newTask);
//     expect(result).toMatchObject({
//       taskId: 21,
//       name: "Kamal's task",
//       description: "This is a test task",
//       parentTaskId: 19,
//       userId: 1,
//       importance: "high",
//       deadline: expect.any(String),
//     });
//   });
// });
