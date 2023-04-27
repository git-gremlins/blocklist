-- CreateTable
CREATE TABLE "Task" (
    "taskId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "parentTaskId" INTEGER,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("taskId")
);

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_parentTaskId_fkey" FOREIGN KEY ("parentTaskId") REFERENCES "Task"("taskId") ON DELETE SET NULL ON UPDATE CASCADE;
