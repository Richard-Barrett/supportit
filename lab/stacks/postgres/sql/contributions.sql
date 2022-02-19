CREATE TABLE IF NOT EXISTS contributions (
    username    VARCHAR(80),
    week_begins DATE,
    count       INT,
    PRIMARY KEY (username, week_begins)
);
