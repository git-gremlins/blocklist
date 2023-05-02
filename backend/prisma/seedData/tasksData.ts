import z from "zod";
import { TaskCreateManyInputSchema } from "../generated/zod";

export type TaskCreateInput = Omit<
  z.infer<typeof TaskCreateManyInputSchema>,
  "taskId"
>;

const tasks: TaskCreateInput[] = [
  {
    name: "Finish project",
    description: "Complete all the outstanding tasks and submit the project",
    importance: "high",
    userId: 1,
  },
  {
    name: "Research",
    description: "Do research on a new topic for the next project",
    importance: "medium",
    userId: 1,
  },
  {
    name: "Prepare presentation",
    description: "Prepare a presentation for the next meeting",
    importance: "high",
    userId: 1,
  },
  {
    name: "Email clients",
    description:
      "Send an email to all the clients to update them on the project",
    importance: "low",
    userId: 2,
  },
  {
    name: "Schedule meeting",
    description: "Schedule a meeting with the team to discuss the project",
    importance: "medium",
    userId: 2,
  },
  {
    name: "Create new design",
    description: "Create a new design for the next project",
    importance: "high",
    userId: 2,
  },
  {
    name: "Complete task 1",
    description: "Finish task 1 on the list",
    importance: "low",
    userId: 1,
  },
  {
    name: "Complete task 2",
    description: "Finish task 2 on the list",
    importance: "medium",
    userId: 1,
  },
  {
    name: "Complete task 3",
    description: "Finish task 3 on the list",
    importance: "medium",
    userId: 1,
  },
  {
    name: "Complete task 4",
    description: "Finish task 4 on the list",
    importance: "high",
    userId: 1,
  },
  {
    name: "Complete subtask 1",
    description: "Finish subtask 1 under task 4",
    importance: "medium",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 2",
    description: "Finish subtask 2 under task 4",
    importance: "low",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 3",
    description: "Finish subtask 3 under task 4",
    importance: "medium",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 4",
    description: "Finish subtask 4 under task 4",
    importance: "high",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 5",
    description: "Finish subtask 5 under task 4",
    importance: "medium",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 6",
    description: "Finish subtask 6 under task 4",
    importance: "low",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 7",
    description: "Finish subtask 7 under task 4",
    importance: "medium",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 8",
    description: "Finish subtask 8 under task 4",
    importance: "high",
    parentTaskId: 10,
    userId: 1,
  },
  {
    name: "Complete subtask 9",
    description: "Finish subtask 9 under task 4",
    importance: "medium",
    parentTaskId: 11,
    userId: 1,
  },
  {
    name: "Complete subtask 10",
    description: "Finish subtask 10 under task 4",
    importance: "low",
    parentTaskId: 10,
    userId: 1,
  },
];

export default tasks;
