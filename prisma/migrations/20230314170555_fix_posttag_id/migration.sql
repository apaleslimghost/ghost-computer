/*
  Warnings:

  - Made the column `post_id` on table `posts_tags` required. This step will fail if there are existing NULL values in that column.
  - Made the column `tag_id` on table `posts_tags` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "posts_tags" ALTER COLUMN "post_id" SET NOT NULL,
ALTER COLUMN "tag_id" SET NOT NULL,
ADD CONSTRAINT "posts_tags_pkey" PRIMARY KEY ("post_id", "tag_id");
