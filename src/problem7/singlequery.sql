/* DDL and Preset Data for Testing */
CREATE TABLE Balances (
  id INT PRIMARY KEY,
  address bytea,
  denom VARCHAR(10),
  amount bigint,
  block_height int
);

CREATE TABLE Trades (
  id int PRIMARY KEY,
  address bytea,
  denom VARCHAR(10),
  amount bigint,
  block_height int
);

INSERT INTO Balances VALUES (1,decode('abab', 'hex'),'usdc', 50000000000000, 733755);
INSERT INTO Balances VALUES (2,decode('99cc', 'hex'), 'swth', -20000000, 733757);
INSERT INTO Balances VALUES (3,decode('abab', 'hex'), 'usdc', -50000000000, 733855);

INSERT INTO Trades VALUES (1,decode('abab', 'hex'),'swth', 400000000000, 733756);
INSERT INTO Trades VALUES (2,decode('99cc', 'hex'), 'usdc', 3500000000000, 733757);
INSERT INTO Trades VALUES (3,decode('67f3', 'hex'), 'swth', 72000000000000, 733758);
INSERT INTO Trades VALUES (4,decode('67f5', 'hex'), 'swth', 72000000000000, 738);

/* Actual answer (Single query) */

/* Assuming that a maximum of 2 CTEs are allowed for a single query */
WITH SBalances(id, address, amount, block_height) AS (
  SELECT B.id, B.address,
  CASE
  	WHEN B.denom = 'usdc' THEN B.amount * 0.000001
    WHEN B.denom = 'swth' THEN B.amount * 0.00000005
    WHEN B.denom = 'tmz' THEN B.amount * 0.003
  END AS amount, block_height
  FROM Balances B
)
SELECT encode(s.address::bytea, 'hex')
	FROM SBalances S JOIN Trades T ON (T.address = S.address AND T.block_height > 730000)
    GROUP BY encode(S.address::bytea, 'hex')
    HAVING SUM(S.amount) >= 500;