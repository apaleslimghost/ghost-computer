-- CreateTable
CREATE TABLE "mentions" (
    "id" BIGSERIAL NOT NULL,
    "post_id" BIGINT NOT NULL,
    "source" VARCHAR,
    "data" JSONB,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "mentions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "posts" (
    "id" BIGSERIAL NOT NULL,
    "title" VARCHAR,
    "posted" TIMESTAMP(6),
    "body" TEXT,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "author_id" BIGINT NOT NULL,
    "likes" INTEGER DEFAULT 0,

    CONSTRAINT "posts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "posts_tags" (
    "post_id" BIGINT,
    "tag_id" BIGINT
);

-- CreateTable
CREATE TABLE "tags" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" BIGSERIAL NOT NULL,
    "username" VARCHAR,
    "password_digest" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "active_storage_attachments" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "record_type" VARCHAR NOT NULL,
    "record_id" BIGINT NOT NULL,
    "blob_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "active_storage_attachments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "active_storage_blobs" (
    "id" BIGSERIAL NOT NULL,
    "key" VARCHAR NOT NULL,
    "filename" VARCHAR NOT NULL,
    "content_type" VARCHAR,
    "metadata" TEXT,
    "service_name" VARCHAR NOT NULL,
    "byte_size" BIGINT NOT NULL,
    "checksum" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "active_storage_blobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "active_storage_postgresql_files" (
    "id" BIGSERIAL NOT NULL,
    "oid" OID,
    "key" VARCHAR,

    CONSTRAINT "active_storage_postgresql_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "active_storage_variant_records" (
    "id" BIGSERIAL NOT NULL,
    "blob_id" BIGINT NOT NULL,
    "variation_digest" VARCHAR NOT NULL,

    CONSTRAINT "active_storage_variant_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ar_internal_metadata" (
    "key" VARCHAR NOT NULL,
    "value" VARCHAR,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "ar_internal_metadata_pkey" PRIMARY KEY ("key")
);

-- CreateTable
CREATE TABLE "good_jobs" (
    "id" UUID NOT NULL DEFAULT public.gen_random_uuid(),
    "queue_name" TEXT,
    "priority" INTEGER,
    "serialized_params" JSONB,
    "scheduled_at" TIMESTAMP(6),
    "performed_at" TIMESTAMP(6),
    "finished_at" TIMESTAMP(6),
    "error" TEXT,
    "created_at" TIMESTAMP(6) NOT NULL,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "active_job_id" UUID,
    "concurrency_key" TEXT,
    "cron_key" TEXT,

    CONSTRAINT "good_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "schema_migrations" (
    "version" VARCHAR NOT NULL,

    CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version")
);

-- CreateIndex
CREATE INDEX "index_mentions_on_post_id" ON "mentions"("post_id");

-- CreateIndex
CREATE INDEX "index_posts_on_author_id" ON "posts"("author_id");

-- CreateIndex
CREATE INDEX "index_posts_tags_on_post_id" ON "posts_tags"("post_id");

-- CreateIndex
CREATE INDEX "index_posts_tags_on_tag_id" ON "posts_tags"("tag_id");

-- CreateIndex
CREATE UNIQUE INDEX "index_tags_on_name" ON "tags"("name");

-- CreateIndex
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments"("blob_id");

-- CreateIndex
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments"("record_type", "record_id", "name", "blob_id");

-- CreateIndex
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs"("key");

-- CreateIndex
CREATE UNIQUE INDEX "index_active_storage_postgresql_files_on_key" ON "active_storage_postgresql_files"("key");

-- CreateIndex
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records"("blob_id", "variation_digest");

-- CreateIndex
CREATE INDEX "index_good_jobs_on_active_job_id_and_created_at" ON "good_jobs"("active_job_id", "created_at");

-- CreateIndex
CREATE INDEX "index_good_jobs_on_cron_key_and_created_at" ON "good_jobs"("cron_key", "created_at");

-- AddForeignKey
ALTER TABLE "mentions" ADD CONSTRAINT "fk_rails_4308a5edca" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "posts" ADD CONSTRAINT "fk_rails_04d13ef8c7" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "active_storage_attachments" ADD CONSTRAINT "fk_rails_c3b3935057" FOREIGN KEY ("blob_id") REFERENCES "active_storage_blobs"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "active_storage_variant_records" ADD CONSTRAINT "fk_rails_993965df05" FOREIGN KEY ("blob_id") REFERENCES "active_storage_blobs"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

