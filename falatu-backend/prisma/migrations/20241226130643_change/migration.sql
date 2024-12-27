/*
  Warnings:

  - You are about to drop the column `message` on the `messages` table. All the data in the column will be lost.
  - You are about to drop the column `pictureBytes` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "messages" DROP COLUMN "message",
ADD COLUMN     "text" TEXT;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "pictureBytes";
