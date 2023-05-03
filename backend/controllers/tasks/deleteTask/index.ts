import p from "../../../utils/prisma";


export const deleteTask = async (taskId: number) => {
    return p.task.delete({
        where: {taskId: taskId}
    })
}