/**
 * Test the SQLite database and its contents.
 * Author Andrew Jarombek
 * Date: 4/2/2020
 */

SELECT * FROM runs;
SELECT * FROM core;

-- Alternative way to list the tables (SQLite specific)
-- SELECT name FROM sqlite_master WHERE type='table';