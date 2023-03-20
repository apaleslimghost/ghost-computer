/*
  Warnings:

  - The primary key for the `active_storage_attachments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `active_storage_attachments` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `record_id` on the `active_storage_attachments` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `blob_id` on the `active_storage_attachments` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `active_storage_blobs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `active_storage_blobs` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `byte_size` on the `active_storage_blobs` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `active_storage_postgresql_files` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `active_storage_postgresql_files` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `active_storage_variant_records` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `active_storage_variant_records` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `blob_id` on the `active_storage_variant_records` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `mentions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `mentions` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `post_id` on the `mentions` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `posts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `posts` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `author_id` on the `posts` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `posts_tags` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `post_id` on the `posts_tags` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - You are about to alter the column `tag_id` on the `posts_tags` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `tags` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `tags` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `users` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.

*/
-- DropForeignKey
ALTER TABLE "active_storage_attachments" DROP CONSTRAINT "fk_rails_c3b3935057";

-- DropForeignKey
ALTER TABLE "active_storage_variant_records" DROP CONSTRAINT "fk_rails_993965df05";

-- DropForeignKey
ALTER TABLE "mentions" DROP CONSTRAINT "fk_rails_4308a5edca";

-- DropForeignKey
ALTER TABLE "posts" DROP CONSTRAINT "fk_rails_04d13ef8c7";

-- DropForeignKey
ALTER TABLE "posts_tags" DROP CONSTRAINT "posts_tags_post_id_fkey";

-- DropForeignKey
ALTER TABLE "posts_tags" DROP CONSTRAINT "posts_tags_tag_id_fkey";

-- AlterTable
ALTER TABLE "active_storage_attachments" DROP CONSTRAINT "active_storage_attachments_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ALTER COLUMN "record_id" SET DATA TYPE INTEGER,
ALTER COLUMN "blob_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "active_storage_attachments_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "active_storage_attachments_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "active_storage_blobs" DROP CONSTRAINT "active_storage_blobs_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ALTER COLUMN "byte_size" SET DATA TYPE INTEGER,
ADD CONSTRAINT "active_storage_blobs_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "active_storage_blobs_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "active_storage_postgresql_files" DROP CONSTRAINT "active_storage_postgresql_files_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "active_storage_postgresql_files_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "active_storage_postgresql_files_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "active_storage_variant_records" DROP CONSTRAINT "active_storage_variant_records_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ALTER COLUMN "blob_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "active_storage_variant_records_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "active_storage_variant_records_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "mentions" DROP CONSTRAINT "mentions_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ALTER COLUMN "post_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "mentions_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "mentions_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "posts" DROP CONSTRAINT "posts_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ALTER COLUMN "author_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "posts_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "posts_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "posts_tags" DROP CONSTRAINT "posts_tags_pkey",
ALTER COLUMN "post_id" SET DATA TYPE INTEGER,
ALTER COLUMN "tag_id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "posts_tags_pkey" PRIMARY KEY ("post_id", "tag_id");

ALTER SEQUENCE "posts_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "tags" DROP CONSTRAINT "tags_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "tags_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "tags_id_seq" as INTEGER;

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ALTER COLUMN "id" SET DATA TYPE INTEGER,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

ALTER SEQUENCE "users_id_seq" as INTEGER;

-- AddForeignKey
ALTER TABLE "mentions" ADD CONSTRAINT "fk_rails_4308a5edca" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "posts" ADD CONSTRAINT "fk_rails_04d13ef8c7" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "posts_tags" ADD CONSTRAINT "posts_tags_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "posts_tags" ADD CONSTRAINT "posts_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "active_storage_attachments" ADD CONSTRAINT "fk_rails_c3b3935057" FOREIGN KEY ("blob_id") REFERENCES "active_storage_blobs"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "active_storage_variant_records" ADD CONSTRAINT "fk_rails_993965df05" FOREIGN KEY ("blob_id") REFERENCES "active_storage_blobs"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
