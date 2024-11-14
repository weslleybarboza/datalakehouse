SELECT DATE_ADD(DATE '2024-01-01', n) AS date_day
FROM (
    SELECT ROW_NUMBER() OVER() - 1 AS n
    FROM (VALUES(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS a(x),
         (VALUES(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS b(x),
         (VALUES(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS c(x)
) AS numbers
WHERE DATE_ADD(DATE '2024-01-01', n) <= DATE '2024-07-28'
ORDER BY date_day