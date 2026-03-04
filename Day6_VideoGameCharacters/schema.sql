-- Day 5 - Video Game Characters Database (SQLite)

DROP TABLE IF EXISTS character_items;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS games;

CREATE TABLE games (
  game_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  release_year INTEGER CHECK (release_year >= 1970),
  genre TEXT NOT NULL
);

CREATE TABLE classes (
  class_id INTEGER PRIMARY KEY,
  class_name TEXT NOT NULL UNIQUE
);

CREATE TABLE characters (
  character_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  game_id INTEGER NOT NULL,
  class_id INTEGER NOT NULL,
  level INTEGER NOT NULL DEFAULT 1 CHECK (level >= 1),
  hp INTEGER NOT NULL CHECK (hp >= 0),
  mp INTEGER NOT NULL CHECK (mp >= 0),
  is_playable INTEGER NOT NULL DEFAULT 1 CHECK (is_playable IN (0, 1)),
  FOREIGN KEY (game_id) REFERENCES games(game_id),
  FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE TABLE items (
  item_id INTEGER PRIMARY KEY,
  item_name TEXT NOT NULL UNIQUE,
  item_type TEXT NOT NULL CHECK (item_type IN ('weapon','armor','potion','key_item')),
  power INTEGER NOT NULL DEFAULT 0 CHECK (power >= 0)
);

-- Many-to-many: a character can have many items, an item can belong to many characters
CREATE TABLE character_items (
  character_id INTEGER NOT NULL,
  item_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  PRIMARY KEY (character_id, item_id),
  FOREIGN KEY (character_id) REFERENCES characters(character_id),
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);
