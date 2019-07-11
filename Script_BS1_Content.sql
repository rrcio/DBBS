INSERT INTO public.bike(
	id, brand, model, color, serial_number)
VALUES 
	('1', 'Cannondale', 'M700', 'Blue', 'N2G20'),
	('2', 'Intense', 'Primer', 'Orange', 'BSDE153910/VQBDEQ12401'),
	('3', 'Trek', 'Fuel 9', 'Lime', 'Scratched'),
	('4', 'MEC', 'Skyway', 'Black', 'IMM2469086234'),
	('5', 'MEC', 'Shadowlands', 'Lime/Green', 'IMM325098290');

INSERT INTO public.bike_shop_staff(
	worker_id, first_name, last_name, store_location)
VALUES 
	('13045', 'Roman', 'Sciorato', 'TOR03'),
	('15032', 'Jon', 'Malcovich', 'MTL06'),
	('16904', 'Jack', 'Daniels','NYK11');

INSERT INTO public.level_priority(
	id, priority, description)
VALUES
	('1', '0', 'Intense'),
	('2', '0', 'Warranty T/U'),
	('3', '0', 'Next hour'),
	('4', '0', 'Yesterday'),
	('5', '1', 'Today and Tomorrow'),
	('6', '2', 'D+2 and D+3'),
	('7', '3', 'D+4 and D+5');
	
INSERT INTO public.type_failure(
	id, location, type, risk)
VALUES
	('1', 'steering tube', 'rust', '1'),
	('2', 'left seat stay', 'crack', '3'),
	('3', 'right chain stay', 'dent', '2'),
	('0', 'No location', 'nothing', '0');
	
INSERT INTO public.status(
	id, wording)
VALUES
	('1', 'Open'), -- add WFP and WCB
	('2', 'Waiting for parts'),
	('3', 'Waiting for call back'),
	('4', 'In progress'),
	('5', 'Done'),
	('6', 'Picked Up');

INSERT INTO public.part_status(
	id, wording)
VALUES
	('1', 'In stock'),
	('2', 'Out of stock'),
	('3', 'Ordered'),
	('4', 'Arrived'),
	('5', 'Attached to the bike');
	
INSERT INTO public.customer(
	member_number, first_name, last_name, phone_number, email_address)
VALUES
	('52811023', 'Romain', 'Sciorato', '416 9908765', 'r@outlook.com'),
	('63690382', 'Master', 'Yoda', '905 5902586', 'master.yoda@jedi.com'),
	('64903934', 'Michael', 'Scott', '416 5269084', 'michael_scott@dundermifflinpapercompany.com'),
	('65968024', 'T', 'Challa', '514 8927352', 't.challa@wakanda.kingdom.wak');

INSERT INTO public.stock_database(
	sku_number, name, price, service_package, description, type, quantity_available)
VALUES
	('403655', 'Mec Tube 26 1.75-2.125 P', '5', False, 'Tube', 'Cycling', '130'),
	('403663', 'Mec Tube 26 1.75-2.125 S', '5', False, 'Tube', 'Cycling', '0'),
	('291754', 'Tire/Tube Install', '12', true, 'flat fix or tire change', 'Cycling', '0'),
	('291638', 'Brake adjust - Major', '23', true, 'Fixing brake, replace cable, housing and pads', 'Cycling', '0'),
	('291748', 'Wheel trust - Minor', '17', true, 'Make the true without replacing a spoke', 'Cycling', '0');

INSERT INTO public.work_order(
	work_order_number, member_number, bike_id, service_writer_id, store_location, date_in, date_end_estimate, keep_the_parts, ticket_note, price_estimate, current_status_id, failure, type_failure_id, failure_member_aknowledgement, level_priority_id)
VALUES 
	('200064', '52811023', '1', '13045', 'TOR03', '2019-04-22 10:00:00', '2019-04-24 12:00:00', true, 'bike came for a flat tire', '20', '6', true, '1', true, '6'),
	('200065', '52811023', '1', '13045', 'TOR03', '2019-04-24 12:01:00', '2019-04-24 12:21:00', true, 'bike came back for a new flat tire', '5', '4', true, '2', true, '6'),
	('200066', '63690382', '2', '15032', 'MTL06', '2019-04-25 11:15:53', '2019-04-25 17:00:00', false, 'bike came in with a front wheel untrue, bike is not under warranty because it is a crash but still Intense priority', '30', '5', false, '0', false, '1');

INSERT INTO public.comment(
	id, description, date_comments, worker_id, work_order_number)
VALUES
	('1', 'Bike is in for a flat tire', '2019-04-22 10:00:00', '13045', '200064'),
	('2', 'Start the job, assess the bike again to check everything is good with the order', '2019-04-22 10:05:00', '13045', '200064'),
	('3', 'Rust detected on the frame, member has been called to let him/her know about the situation', '2019-04-22 10:10:00', '13045', '200064'),
	('4', 'Member aknowledge the risk and ask the mechanic to go on with the job to do on his bike', '2019-04-23 10:00:00', '13045', '200064'),
	('5', 'Job done, bike is good to go but might need a deeper T/U soon', '2019-04-23 10:10:00', '13045', '200064'),
	('6', 'Member picked up the bike', '2019-04-23 17:00:00', '13045', '200064');

INSERT INTO public.work_order_unit(
	id_work_order_unit, sku_number, work_order_number, quantity, front, to_be_ordered, current_status_id)
VALUES
	('1', '403663', '200064', '1', False, True, '3'),
	('2', '291754', '200064', '1', false, false, '5');

INSERT INTO public.part_order_status_history(
	id_part_order_status_history, id_part_status, id_work_order_unit, sku_number, work_order_number, date)
VALUES
	('1', '2', '1', '403663', '200064', '2019/04/22 12:00:00'),
	('2', '3', '1', '403663', '200064', '2019/04/23 09:00:00');

INSERT INTO public.status_history(
	work_order_number, status_id, date, comment_id, worker_id)
VALUES
	('200064', '1', '2019-04-22 10:00:00', '1', '013045'),
	('200064', '4', '2019-04-22 10:05:00', '2', '013045'),
	('200064', '5', '2019-04-23 10:10:00', '4', '013045'),
	('200064', '6', '2019-04-23 17:00:00', '5', '013045');

INSERT INTO public.work_order_associated(
	work_order_number, work_order_associated_number)
VALUES (
	'200065', '200064');

