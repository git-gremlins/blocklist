-- CreateTable
CREATE TABLE "public"."User" (
    "userId" UUID NOT NULL,
    "name" TEXT,
    "surname" TEXT,
    "settings" JSONB NOT NULL DEFAULT '{}',

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "public"."Task" (
    "taskId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "parentTaskId" INTEGER,
    "userId" UUID NOT NULL,
    "deadline" TIMESTAMP(3),
    "startRow" INTEGER NOT NULL,
    "startCol" INTEGER NOT NULL,
    "endRow" INTEGER NOT NULL,
    "endCol" INTEGER NOT NULL,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("taskId")
);

-- AddForeignKey
ALTER TABLE "public"."User" ADD CONSTRAINT "User_userId_fkey" FOREIGN KEY ("userId") REFERENCES "auth"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Task" ADD CONSTRAINT "Task_parentTaskId_fkey" FOREIGN KEY ("parentTaskId") REFERENCES "public"."Task"("taskId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Task" ADD CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("userId") ON DELETE CASCADE ON UPDATE CASCADE;
