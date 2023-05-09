-- DropForeignKey
ALTER TABLE "public"."Task" DROP CONSTRAINT "Task_parentTaskId_fkey";

-- AddForeignKey
ALTER TABLE "public"."Task" ADD CONSTRAINT "Task_parentTaskId_fkey" FOREIGN KEY ("parentTaskId") REFERENCES "public"."Task"("taskId") ON DELETE CASCADE ON UPDATE CASCADE;
