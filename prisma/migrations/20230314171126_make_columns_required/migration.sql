/*
  Warnings:

  - Made the column `likes` on table `posts` required. This step will fail if there are existing NULL values in that column.
  - Made the column `name` on table `tags` required. This step will fail if there are existing NULL values in that column.
  - Made the column `username` on table `users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `password_digest` on table `users` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "posts" ALTER COLUMN "likes" SET NOT NULL;

-- AlterTable
ALTER TABLE "tags" ALTER COLUMN "name" SET NOT NULL;

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "username" SET NOT NULL,
ALTER COLUMN "password_digest" SET NOT NULL;
