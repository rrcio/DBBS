
CREATE SEQUENCE public.level_priority_id_seq_1;

CREATE TABLE public.level_priority (
                id INTEGER NOT NULL DEFAULT nextval('public.level_priority_id_seq_1'),
                priority INTEGER NOT NULL,
                description VARCHAR(200) NOT NULL,
                CONSTRAINT level_priority_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.level_priority_id_seq_1 OWNED BY public.level_priority.id;

CREATE SEQUENCE public.part_status_id_seq_1;

CREATE TABLE public.part_status (
                id INTEGER NOT NULL DEFAULT nextval('public.part_status_id_seq_1'),
                wording VARCHAR(20) NOT NULL,
                CONSTRAINT part_status_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.part_status_id_seq_1 OWNED BY public.part_status.id;

CREATE SEQUENCE public.type_failure_id_seq_1;

CREATE TABLE public.type_failure (
                id INTEGER NOT NULL DEFAULT nextval('public.type_failure_id_seq_1'),
                location VARCHAR(100) NOT NULL,
                type VARCHAR(100) NOT NULL,
                risk INTEGER NOT NULL,
                CONSTRAINT type_failure_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.type_failure_id_seq_1 OWNED BY public.type_failure.id;

CREATE SEQUENCE public.status_id_seq_1;

CREATE TABLE public.status (
                id INTEGER NOT NULL DEFAULT nextval('public.status_id_seq_1'),
                wording VARCHAR(20) NOT NULL,
                CONSTRAINT status_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.status_id_seq_1 OWNED BY public.status.id;

CREATE SEQUENCE public.bike_id_seq_1;

CREATE TABLE public.bike (
                id INTEGER NOT NULL DEFAULT nextval('public.bike_id_seq_1'),
                brand VARCHAR(30) NOT NULL,
                model VARCHAR(30) NOT NULL,
                color VARCHAR(30) NOT NULL,
                serial_number VARCHAR(30),
                CONSTRAINT bike_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.bike_id_seq_1 OWNED BY public.bike.id;

CREATE UNIQUE INDEX bike_idx
 ON public.bike
 ( id ASC, serial_number );

CLUSTER bike_idx ON bike;

CREATE UNIQUE INDEX bike_idx1
 ON public.bike
 ( serial_number );

CREATE TABLE public.stock_database (
                sku_number INTEGER NOT NULL,
                name VARCHAR(20) NOT NULL,
                price NUMERIC(6,2) NOT NULL,
                service_package BOOLEAN NOT NULL,
                description VARCHAR(300),
                type VARCHAR(20) NOT NULL,
                quantity_available INTEGER NOT NULL,
                CONSTRAINT stock_database_pk PRIMARY KEY (sku_number)
);


CREATE TABLE public.bike_shop_staff (
                worker_id INTEGER NOT NULL,
                first_name VARCHAR(100) NOT NULL,
                last_name VARCHAR(100) NOT NULL,
                store_location VARCHAR(15) NOT NULL,
                CONSTRAINT bike_shop_staff_pk PRIMARY KEY (worker_id)
);




CREATE TABLE public.customer (
                member_number INTEGER NOT NULL,
                first_name VARCHAR(100) NOT NULL,
                last_name VARCHAR(100) NOT NULL,
                phone_number VARCHAR(20) NOT NULL,
                email_address VARCHAR(100),
                CONSTRAINT customer_pk PRIMARY KEY (member_number)
);


CREATE SEQUENCE public.work_order_number_seq;

CREATE TABLE public.work_order (
                work_order_number INTEGER NOT NULL DEFAULT nextval('public.work_order_number_seq'),
                member_number INTEGER NOT NULL,
                bike_id INTEGER NOT NULL,
                service_writer_id INTEGER NOT NULL,
                store_location_location VARCHAR(15) NOT NULL,
                date_in TIMESTAMP NOT NULL,
                date_end_estimate TIMESTAMP NOT NULL,
                keep_the_parts BOOLEAN NOT NULL,
                ticket_note VARCHAR(1000),
                price_estimate INTEGER NOT NULL,
                current_status_id INTEGER NOT NULL,
                failure BOOLEAN DEFAULT FALSE NOT NULL,
                type_failure_id INTEGER NOT NULL,
                failure_member_aknowledgement BOOLEAN,
                level_priority_id INTEGER NOT NULL,
                CONSTRAINT work_order_pk PRIMARY KEY (work_order_number)
);


ALTER SEQUENCE public.work_order_number_seq OWNED BY public.work_order.work_order_number;

CREATE SEQUENCE public.comment_id_seq;

CREATE TABLE public.comment (
                id INTEGER NOT NULL DEFAULT nextval('public.comment_id_seq'),
                description VARCHAR(500) NOT NULL,
                date_comments TIMESTAMP NOT NULL,
                worker_id INTEGER NOT NULL,
                work_order_number INTEGER NOT NULL,
                CONSTRAINT comment_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;

CREATE TABLE public.status_history (
                work_order_number INTEGER NOT NULL,
                status_id INTEGER NOT NULL,
                date TIMESTAMP NOT NULL,
                comment_id INTEGER NOT NULL,
                worker_id INTEGER NOT NULL,
                CONSTRAINT status_history_pk PRIMARY KEY (work_order_number, status_id)
);


CREATE TABLE public.work_order_associated (
                work_order_number INTEGER NOT NULL,
                work_order_associated_number INTEGER NOT NULL,
                CONSTRAINT work_order_associated_pk PRIMARY KEY (work_order_number, work_order_associated_number)
);


CREATE SEQUENCE public.work_order_unit_id_seq;

CREATE TABLE public.work_order_unit (
                id_work_order_unit INTEGER NOT NULL DEFAULT nextval('public.work_order_unit_id_seq'),
                sku_number INTEGER NOT NULL,
                work_order_number INTEGER NOT NULL,
                quantity INTEGER DEFAULT 1 NOT NULL,
                front BOOLEAN,
                to_be_ordered BOOLEAN NOT NULL,
                current_status_id INTEGER NOT NULL,
                CONSTRAINT work_order_unit_pk PRIMARY KEY (id_work_order_unit, sku_number, work_order_number)
);


ALTER SEQUENCE public.work_order_unit_id_seq OWNED BY public.work_order_unit.id_work_order_unit;

CREATE SEQUENCE public.part_order_status_history_id_part_order_status_history_seq;

CREATE TABLE public.part_order_status_history (
                id_part_order_status_history INTEGER NOT NULL DEFAULT nextval('public.part_order_status_history_id_part_order_status_history_seq'),
                id_part_status INTEGER NOT NULL,
                id_work_order_unit INTEGER NOT NULL,
                sku_number INTEGER NOT NULL,
                work_order_number INTEGER NOT NULL,
                date TIMESTAMP NOT NULL,
                CONSTRAINT part_order_status_history_pk PRIMARY KEY (id_part_order_status_history, id_part_status, id_work_order_unit, sku_number, work_order_number)
);


ALTER SEQUENCE public.part_order_status_history_id_part_order_status_history_seq OWNED BY public.part_order_status_history.id_part_order_status_history;

ALTER TABLE public.work_order ADD CONSTRAINT level_priority_work_order_fk
FOREIGN KEY (level_priority_id)
REFERENCES public.level_priority (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.part_order_status_history ADD CONSTRAINT part_status_part_order_history_fk
FOREIGN KEY (id_part_status)
REFERENCES public.part_status (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order_unit ADD CONSTRAINT part_status_work_order_unit_fk
FOREIGN KEY (current_status_id)
REFERENCES public.part_status (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order ADD CONSTRAINT type_failure_work_order_fk
FOREIGN KEY (type_failure_id)
REFERENCES public.type_failure (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order ADD CONSTRAINT status_work_order_fk
FOREIGN KEY (current_status_id)
REFERENCES public.status (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.status_history ADD CONSTRAINT status_status_history_fk
FOREIGN KEY (status_id)
REFERENCES public.status (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order ADD CONSTRAINT bike_work_order_fk
FOREIGN KEY (bike_id)
REFERENCES public.bike (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order_unit ADD CONSTRAINT service_work_order_service_fk
FOREIGN KEY (sku_number)
REFERENCES public.stock_database (sku_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order ADD CONSTRAINT bike_shop_staff_work_order_fk2
FOREIGN KEY (service_writer_id)
REFERENCES public.bike_shop_staff (worker_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comment ADD CONSTRAINT bike_shop_staff_comment_fk
FOREIGN KEY (worker_id)
REFERENCES public.bike_shop_staff (worker_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.status_history ADD CONSTRAINT bike_shop_staff_status_history_fk
FOREIGN KEY (worker_id)
REFERENCES public.bike_shop_staff (worker_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order ADD CONSTRAINT customer_work_order_fk
FOREIGN KEY (member_number)
REFERENCES public.customer (member_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order_unit ADD CONSTRAINT work_order_work_order_service_fk
FOREIGN KEY (work_order_number)
REFERENCES public.work_order (work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order_associated ADD CONSTRAINT work_order_work_order_combined_fk
FOREIGN KEY (work_order_number)
REFERENCES public.work_order (work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.work_order_associated ADD CONSTRAINT work_order_work_order_associated_fk
FOREIGN KEY (work_order_associated_number)
REFERENCES public.work_order (work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comment ADD CONSTRAINT work_order_comment_fk
FOREIGN KEY (work_order_number)
REFERENCES public.work_order (work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.status_history ADD CONSTRAINT work_order_status_history_fk
FOREIGN KEY (work_order_number)
REFERENCES public.work_order (work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.status_history ADD CONSTRAINT comment_status_history_fk
FOREIGN KEY (comment_id)
REFERENCES public.comment (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.part_order_status_history ADD CONSTRAINT work_order_unit_part_order_status_history_fk
FOREIGN KEY (id_work_order_unit, sku_number, work_order_number)
REFERENCES public.work_order_unit (id_work_order_unit, sku_number, work_order_number)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
