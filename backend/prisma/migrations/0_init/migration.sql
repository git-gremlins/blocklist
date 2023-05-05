-- Add extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "auth";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "storage";

-- CreateEnum
CREATE TYPE "auth"."aal_level" AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);

-- CreateEnum
CREATE TYPE "auth"."code_challenge_method" AS ENUM (
    's256',
    'plain'
);

-- CreateEnum
CREATE TYPE "auth"."factor_status" AS ENUM (
    'unverified',
    'verified'
);

-- CreateEnum
CREATE TYPE "auth"."factor_type" AS ENUM (
    'totp',
    'webauthn'
);

-- CreateTable
CREATE TABLE "auth"."audit_log_entries" (
    "instance_id" uuid,
    "id" uuid NOT NULL,
    "payload" json,
    "created_at" timestamptz(6),
    "ip_address" varchar(64) NOT NULL DEFAULT '',
    CONSTRAINT "audit_log_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."flow_state" (
    "id" uuid NOT NULL,
    "user_id" uuid,
    "auth_code" text NOT NULL,
    "code_challenge_method" "auth"."code_challenge_method" NOT NULL,
    "code_challenge" text NOT NULL,
    "provider_type" text NOT NULL,
    "provider_access_token" text,
    "provider_refresh_token" text,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    "authentication_method" text NOT NULL,
    CONSTRAINT "flow_state_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."identities" (
    "id" text NOT NULL,
    "user_id" uuid NOT NULL,
    "identity_data" jsonb NOT NULL,
    "provider" text NOT NULL,
    "last_sign_in_at" timestamptz(6),
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    -- "email" text DEFAULT lower((identity_data ->> 'email'::text)),
    "email" text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    CONSTRAINT "identities_pkey" PRIMARY KEY ("provider", "id")
);

-- CreateTable
CREATE TABLE "auth"."instances" (
    "id" uuid NOT NULL,
    "uuid" uuid,
    "raw_base_config" text,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    CONSTRAINT "instances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."mfa_amr_claims" (
    "session_id" uuid NOT NULL,
    "created_at" timestamptz(6) NOT NULL,
    "updated_at" timestamptz(6) NOT NULL,
    "authentication_method" text NOT NULL,
    "id" uuid NOT NULL,
    CONSTRAINT "amr_id_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."mfa_challenges" (
    "id" uuid NOT NULL,
    "factor_id" uuid NOT NULL,
    "created_at" timestamptz(6) NOT NULL,
    "verified_at" timestamptz(6),
    "ip_address" inet NOT NULL,
    CONSTRAINT "mfa_challenges_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."mfa_factors" (
    "id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "friendly_name" text,
    "factor_type" "auth"."factor_type" NOT NULL,
    "status" "auth"."factor_status" NOT NULL,
    "created_at" timestamptz(6) NOT NULL,
    "updated_at" timestamptz(6) NOT NULL,
    "secret" text,
    CONSTRAINT "mfa_factors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."refresh_tokens" (
    "instance_id" uuid,
    "id" bigserial NOT NULL,
    "token" varchar(255),
    "user_id" varchar(255),
    "revoked" boolean,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    "parent" varchar(255),
    "session_id" uuid,
    CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."saml_providers" (
    "id" uuid NOT NULL,
    "sso_provider_id" uuid NOT NULL,
    "entity_id" text NOT NULL,
    "metadata_xml" text NOT NULL,
    "metadata_url" text,
    "attribute_mapping" jsonb,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    CONSTRAINT "saml_providers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."saml_relay_states" (
    "id" uuid NOT NULL,
    "sso_provider_id" uuid NOT NULL,
    "request_id" text NOT NULL,
    "for_email" text,
    "redirect_to" text,
    "from_ip_address" inet,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    CONSTRAINT "saml_relay_states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."schema_migrations" (
    "version" varchar(255) NOT NULL,
    CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version")
);

-- CreateTable
CREATE TABLE "auth"."sessions" (
    "id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    "factor_id" uuid,
    "aal" "auth"."aal_level",
    "not_after" timestamptz(6),
    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."sso_domains" (
    "id" uuid NOT NULL,
    "sso_provider_id" uuid NOT NULL,
    "domain" text NOT NULL,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    CONSTRAINT "sso_domains_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."sso_providers" (
    "id" uuid NOT NULL,
    "resource_id" text,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    CONSTRAINT "sso_providers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth"."users" (
    "instance_id" uuid,
    "id" uuid NOT NULL,
    "aud" varchar(255),
    "role" varchar(255),
    "email" varchar(255),
    "encrypted_password" varchar(255),
    "email_confirmed_at" timestamptz(6),
    "invited_at" timestamptz(6),
    "confirmation_token" varchar(255),
    "confirmation_sent_at" timestamptz(6),
    "recovery_token" varchar(255),
    "recovery_sent_at" timestamptz(6),
    "email_change_token_new" varchar(255),
    "email_change" varchar(255),
    "email_change_sent_at" timestamptz(6),
    "last_sign_in_at" timestamptz(6),
    "raw_app_meta_data" jsonb,
    "raw_user_meta_data" jsonb,
    "is_super_admin" boolean,
    "created_at" timestamptz(6),
    "updated_at" timestamptz(6),
    "phone" text,
    "phone_confirmed_at" timestamptz(6),
    "phone_change" text DEFAULT '',
    "phone_change_token" varchar(255) DEFAULT '',
    "phone_change_sent_at" timestamptz(6),
    -- "confirmed_at" TIMESTAMPTZ(6) DEFAULT LEAST(email_confirmed_at, phone_confirmed_at),
    "confirmed_at" timestamptz(6) GENERATED ALWAYS AS (LEAST (email_confirmed_at, phone_confirmed_at)) STORED,
    "email_change_token_current" varchar(255) DEFAULT '',
    "email_change_confirm_status" smallint DEFAULT 0,
    "banned_until" timestamptz(6),
    "reauthentication_token" varchar(255) DEFAULT '',
    "reauthentication_sent_at" timestamptz(6),
    "is_sso_user" boolean NOT NULL DEFAULT FALSE,
    "deleted_at" timestamptz(6),
    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storage"."buckets" (
    "id" text NOT NULL,
    "name" text NOT NULL,
    "owner" uuid,
    "created_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
    "public" boolean DEFAULT FALSE,
    "avif_autodetection" boolean DEFAULT FALSE,
    "file_size_limit" bigint,
    "allowed_mime_types" text[],
    CONSTRAINT "buckets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storage"."migrations" (
    "id" integer NOT NULL,
    "name" varchar(100) NOT NULL,
    "hash" varchar(40) NOT NULL,
    "executed_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "storage"."objects" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4 (),
    "bucket_id" text,
    "name" text,
    "owner" uuid,
    "created_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
    "last_accessed_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
    "metadata" jsonb,
    -- "path_tokens" text[] DEFAULT string_to_array(name, '/'::text),
    "path_tokens" text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    "version" text,
    CONSTRAINT "objects_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "audit_logs_instance_id_idx" ON "auth"."audit_log_entries" ("instance_id");

-- CreateIndex
CREATE INDEX "idx_auth_code" ON "auth"."flow_state" ("auth_code");

-- CreateIndex
CREATE INDEX "idx_user_id_auth_method" ON "auth"."flow_state" ("user_id", "authentication_method");

-- CreateIndex
CREATE INDEX "identities_email_idx" ON "auth"."identities" ("email");

-- CreateIndex
CREATE INDEX "identities_user_id_idx" ON "auth"."identities" ("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "mfa_amr_claims_session_id_authentication_method_pkey" ON "auth"."mfa_amr_claims" ("session_id", "authentication_method");

-- CreateIndex
CREATE INDEX "factor_id_created_at_idx" ON "auth"."mfa_factors" ("user_id", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "refresh_tokens_token_unique" ON "auth"."refresh_tokens" ("token");

-- CreateIndex
CREATE INDEX "refresh_tokens_instance_id_idx" ON "auth"."refresh_tokens" ("instance_id");

-- CreateIndex
CREATE INDEX "refresh_tokens_instance_id_user_id_idx" ON "auth"."refresh_tokens" ("instance_id", "user_id");

-- CreateIndex
CREATE INDEX "refresh_tokens_parent_idx" ON "auth"."refresh_tokens" ("parent");

-- CreateIndex
CREATE INDEX "refresh_tokens_session_id_revoked_idx" ON "auth"."refresh_tokens" ("session_id", "revoked");

-- CreateIndex
CREATE UNIQUE INDEX "saml_providers_entity_id_key" ON "auth"."saml_providers" ("entity_id");

-- CreateIndex
CREATE INDEX "saml_providers_sso_provider_id_idx" ON "auth"."saml_providers" ("sso_provider_id");

-- CreateIndex
CREATE INDEX "saml_relay_states_for_email_idx" ON "auth"."saml_relay_states" ("for_email");

-- CreateIndex
CREATE INDEX "saml_relay_states_sso_provider_id_idx" ON "auth"."saml_relay_states" ("sso_provider_id");

-- CreateIndex
CREATE INDEX "sessions_user_id_idx" ON "auth"."sessions" ("user_id");

-- CreateIndex
CREATE INDEX "user_id_created_at_idx" ON "auth"."sessions" ("user_id", "created_at");

-- CreateIndex
CREATE INDEX "sso_domains_sso_provider_id_idx" ON "auth"."sso_domains" ("sso_provider_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_phone_key" ON "auth"."users" ("phone");

-- CreateIndex
CREATE INDEX "users_instance_id_idx" ON "auth"."users" ("instance_id");

-- CreateIndex
CREATE UNIQUE INDEX "bname" ON "storage"."buckets" ("name");

-- CreateIndex
CREATE UNIQUE INDEX "migrations_name_key" ON "storage"."migrations" ("name");

-- CreateIndex
CREATE INDEX "name_prefix_search" ON "storage"."objects" ("name");

-- CreateIndex
CREATE UNIQUE INDEX "bucketid_objname" ON "storage"."objects" ("bucket_id", "name");

-- AddForeignKey
ALTER TABLE "auth"."identities"
    ADD CONSTRAINT "identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_auth_factor_id_fkey" FOREIGN KEY ("factor_id") REFERENCES "auth"."mfa_factors" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."sessions"
    ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "storage"."buckets"
    ADD CONSTRAINT "buckets_owner_fkey" FOREIGN KEY ("owner") REFERENCES "auth"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "storage"."objects"
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "storage"."objects"
    ADD CONSTRAINT "objects_owner_fkey" FOREIGN KEY ("owner") REFERENCES "auth"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
