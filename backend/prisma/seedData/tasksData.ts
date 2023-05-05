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
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 0,
    startCol: 0,
    endRow: 2,
    endCol: 1,
  },
  {
    name: "Research",
    description: "Do research on a new topic for the next project",
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 0,
    startCol: 2,
    endRow: 2,
    endCol: 3,
  },
  {
    name: "Prepare presentation",
    description: "Prepare a presentation for the next meeting",
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 3,
    startCol: 0,
    endRow: 7,
    endCol: 0,
  },
  {
    name: "Complete subtask 1",
    description: "Finish subtask 1 under task 4",
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 5,
    startCol: 3,
    endRow: 7,
    endCol: 3,
  },
  {
    name: "Complete subtask 2",
    description: "Finish subtask 2 under task 4",
    parentTaskId: 4,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
  {
    name: "Complete subtask 3",
    description: "Finish subtask 3 under task 4",
    parentTaskId: 4,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
  {
    name: "Complete subtask 4",
    description: "Finish subtask 4 under task 4",
    parentTaskId: 4,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
  {
    name: "Complete subtask 5",
    description: "Finish subtask 5 under task 4",
    parentTaskId: 4,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
  {
    name: "Complete subtask 6",
    description: "Finish subtask 6 under task 4",
    parentTaskId: 4,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
  {
    name: "Complete subtask 9",
    description: "Finish subtask 9 under task 4",
    parentTaskId: 5,
    userId: "00000000-0000-0000-0000-000000000000",
    startRow: 1,
    startCol: 1,
    endRow: 1,
    endCol: 1,
  },
];

export default tasks;
