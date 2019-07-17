SELECT * FROM work_order
WHERE
	member_number IN(
		SELECT customer.member_number FROM customer
		WHERE customer.last_name = 'Yoda'
		)
;
SELECT * FROM work_order
WHERE
	member_number IN(
		SELECT customer.member_number FROM customer
		WHERE customer.last_name = 'Sciorato'
		)
;

