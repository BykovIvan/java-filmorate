CREATE TABLE IF NOT EXISTS mpa(
    id   INTEGER PRIMARY KEY,
    name varchar(20) NOT NULL,
    CONSTRAINT up_uniq_mame_mpa UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS genre(
    id   INTEGER PRIMARY KEY,
    name varchar(20) NOT NULL,
    CONSTRAINT up_uniq_mame_genre UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS users(
    id       INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email    varchar(40) NOT NULL,
    login    varchar(20) NOT NULL,
    name     varchar(20),
    birthday date
);

CREATE TABLE IF NOT EXISTS films(
    id           INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name         varchar(40) NOT NULL,
    release_data date,
    description  varchar(200),
    duration     INTEGER,
    rate         INTEGER,
    mpa          INTEGER REFERENCES mpa(id)
);

CREATE TABLE IF NOT EXISTS film_genre(
    film_id  INTEGER REFERENCES films(id),
    genre_id INTEGER REFERENCES genre(id),
    CONSTRAINT film_genre_PK PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE IF NOT EXISTS likes(
    film_id INTEGER REFERENCES films(id),
    user_id INTEGER REFERENCES users(id),
    CONSTRAINT likes_PK PRIMARY KEY (film_id, user_id)
);

CREATE TABLE IF NOT EXISTS friends(
    user_id   INTEGER REFERENCES users(id),
    friend_id INTEGER REFERENCES users(id),
    confirmed Boolean DEFAULT FALSE,
    CONSTRAINT friends_PK PRIMARY KEY (user_id, friend_id)
);