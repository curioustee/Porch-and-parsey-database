CREATE TABLE region (
id integer PRIMARY KEY, 
name bpchar
);

CREATE TABLE sales_reps ( 
id integer PRIMARY KEY, 
name bpchar, 
region_id integer,
FOREIGN KEY (region_id) REFERENCES region(id)
) ;

CREATE TABLE accounts (
id integer PRIMARY KEY, 
name bpchar UNIQUE NOT NULL, 
website bpchar NOT NULL, 
lat numeric (11,8), 
long numeric (11,8), 
primary_poc bpchar, 
sales_rep_id integer,
FOREIGN KEY (sales_rep_id) REFERENCES sales_reps (id)
);


CREATE TABLE orders (
id integer PRIMARY KEY,
account_id integer, 
occurred_at timestamp, 
standard_qty integer, 
gloss_aty integer, 
poster_qty integer,
total integer, 
standard_amt_usd numeric(10,2), 
gloss_amt_usd numeric (10,2), 
poster_amt_usd numeric (10,2), 
total_amt_usd numeric (10,2),
FOREIGN KEY (account_id) REFERENCES accounts (id)
);

CREATE TABLE web_events (
id integer PRIMARY KEY, 
account_id integer, 
occurred_at timestamp, 
channel bpchar NOT NULL,
FOREIGN KEY (account_id) REFERENCES accounts (id)
);


SELECT id, total_amt_usd, standard_qty, poster_qty, total, standard_amt_usd, gloss_amt_usd, poster_amt_usd
FROM orders
WHERE total_amt_usd > 0
ORDER BY total_amt_usd DESC
LIMIT 10


SELECT id, name
FROM accounts
WHERE name LIKE 'C%'
LIMIT 10

SELECT id, name
FROM accounts
WHERE name LIKE '%one%'
LIMIT 10


SELECT id, name
FROM accounts
WHERE name LIKE '%s'
LIMIT 5

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN('Walmart', 'Target', 'Nordstrom')


SELECT id, account_id, occurred_at, channel
FROM web_events
WHERE channel IN('organic', 'adwords')
LIMIT 10

SELECT * FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0
LIMIT 10

SELECT * FROM accounts
WHERE NOT (name LIKE 'C%' AND name LIKE '%s')
LIMIT 5


SELECT id, occurred_at, gloss_qty
FROM orders
WHERE gloss_qty > 24 AND gloss_qty < 29 
LIMIT 5

"It is observed that after using the between operator, the gloss_qty does not include the values of the endpoints (24,29)"

SELECT	id
FROM orders
WHERE (gloss_qty > 4000 OR poster_qty > 4000) 
LIMIT 10

SELECT * FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000)
LIMIT 10

SELECT * FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%'
LIMIT 10;

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;


SELECT id, account_id, (poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd)) * 100 AS poster_percentage
FROM orders
LIMIT 10;

SELECT * FROM orders
WHERE gloss_amt_usd >= 1000
ORDER BY gloss_amt_usd DESC
LIMIT 5


SELECT * FROM orders
WHERE total_amt_usd < 500
ORDER BY total_amt_usd DESC
LIMIT 10




























