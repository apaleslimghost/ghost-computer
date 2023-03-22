/*
  Warnings:

  - The primary key for the `_PostToTag` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropIndex
DROP INDEX "index_posts_tags_on_post_id";

-- AlterTable
ALTER TABLE "_PostToTag" DROP CONSTRAINT "posts_tags_pkey";
