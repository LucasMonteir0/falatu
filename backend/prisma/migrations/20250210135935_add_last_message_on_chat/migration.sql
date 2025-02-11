/*
  Warnings:

  - A unique constraint covering the columns `[lastMessageId]` on the table `chats` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "chats" ADD COLUMN     "lastMessageId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "chats_lastMessageId_key" ON "chats"("lastMessageId");

-- AddForeignKey
ALTER TABLE "chats" ADD CONSTRAINT "chats_lastMessageId_fkey" FOREIGN KEY ("lastMessageId") REFERENCES "messages"("id") ON DELETE SET NULL ON UPDATE CASCADE;
