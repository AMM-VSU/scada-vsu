-- =============================================================================
-- Diagram Name: Noname1
-- Created on: 24.04.2015 20:48:49
-- Diagram Version: 
-- =============================================================================


DROP TABLE IF EXISTS "device" CASCADE;

CREATE TABLE "device" (
	"id_device" SERIAL NOT NULL,
	"ser_addr" varchar(15) NOT NULL,
	"descr" text,
	PRIMARY KEY("id_device")
);

DROP TABLE IF EXISTS "device_state" CASCADE;

CREATE TABLE "device_state" (
	"id_device_state" SERIAL NOT NULL,
	"name" varchar(15) NOT NULL,
	PRIMARY KEY("id_device_state")
);

DROP TABLE IF EXISTS "device_state_has_device" CASCADE;

CREATE TABLE "device_state_has_device" (
	"id_device_state" int4 NOT NULL,
	"id_device" int4 NOT NULL,
	"time" int4 NOT NULL,
	PRIMARY KEY("id_device_state","id_device","time")
);

DROP TABLE IF EXISTS "command_state" CASCADE;

CREATE TABLE "command_state" (
	"id_command_state" SERIAL NOT NULL,
	"name" varchar(15) NOT NULL,
	PRIMARY KEY("id_command_state")
);

DROP TABLE IF EXISTS "command" CASCADE;

CREATE TABLE "command" (
	"id_command" SERIAL NOT NULL,
	"descr" varchar(15),
	"action" varchar(15) NOT NULL,
	"id_command_state" int4 NOT NULL,
	"id_device" int4 NOT NULL,
	PRIMARY KEY("id_command")
);

DROP TABLE IF EXISTS "data" CASCADE;

CREATE TABLE "data" (
	"id_data" SERIAL NOT NULL,
	"time" int4 NOT NULL,
	"id_device" int4 NOT NULL,
	"channel" int4 NOT NULL,
	"value" int4 NOT NULL,
	"state" int4 NOT NULL,
	"descr" varchar(15),
	PRIMARY KEY("id_data")
);


ALTER TABLE "device_state_has_device" ADD CONSTRAINT "Ref_device_state_has_device_to_device_state" FOREIGN KEY ("id_device_state")
	REFERENCES "device_state"("id_device_state")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE;

ALTER TABLE "device_state_has_device" ADD CONSTRAINT "Ref_device_state_has_device_to_device" FOREIGN KEY ("id_device")
	REFERENCES "device"("id_device")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE;

ALTER TABLE "command" ADD CONSTRAINT "Ref_command_to_command_state" FOREIGN KEY ("id_command_state")
	REFERENCES "command_state"("id_command_state")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE;

ALTER TABLE "command" ADD CONSTRAINT "Ref_command_to_device" FOREIGN KEY ("id_device")
	REFERENCES "device"("id_device")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE;

ALTER TABLE "data" ADD CONSTRAINT "Ref_data_to_device" FOREIGN KEY ("id_device")
	REFERENCES "device"("id_device")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	NOT DEFERRABLE;


