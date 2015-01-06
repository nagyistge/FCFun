CREATE TABLE Person (
    id           INTEGER PRIMARY KEY,
    name         TEXT NOT NULL DEFAULT '',
    createdAt  REAL NOT NULL
);

CREATE INDEX IF NOT EXISTS name ON Person (name);