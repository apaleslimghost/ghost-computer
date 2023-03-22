-- DropForeignKey
ALTER TABLE "posts_tags" DROP CONSTRAINT "posts_tags_post_id_fkey";

-- DropForeignKey
ALTER TABLE "posts_tags" DROP CONSTRAINT "posts_tags_tag_id_fkey";

ALTER TABLE "posts_tags" RENAME COLUMN "post_id" TO "A";
ALTER TABLE "posts_tags" RENAME COLUMN "tag_id" TO "B";
ALTER TABLE "posts_tags" RENAME TO "_PostToTag";

-- CreateIndex
CREATE UNIQUE INDEX "_PostToTag_AB_unique" ON "_PostToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_PostToTag_B_index" ON "_PostToTag"("B");

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;
