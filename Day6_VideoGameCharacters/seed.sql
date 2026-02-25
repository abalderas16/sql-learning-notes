DELETE FROM character_items;
DELETE FROM characters;
DELETE FROM items;
DELETE FROM classes;
DELETE FROM games;

INSERT INTO games (title, release_year, genre) VALUES
('Final Fantasy VII', 1997, 'RPG'),
('The Legend of Zelda: Ocarina of Time', 1998, 'Adventure'),
('Halo: Combat Evolved', 2001, 'Shooter');

INSERT INTO classes (class_name) VALUES
('Warrior'),
('Mage'),
('Ranger'),
('Soldier');

INSERT INTO characters (name, game_id, class_id, level, hp, mp, is_playable) VALUES
('Cloud Strife', 1, 1, 18, 540, 120, 1),
('Aerith Gainsborough', 1, 2, 16, 380, 260, 1),
('Link', 2, 3, 20, 600, 80, 1),
('Master Chief', 3, 4, 25, 900, 0, 1),
('Sephiroth', 1, 1, 50, 2000, 500, 0),
('Arley The Data Engineer', 3, 1, 100, 1500, 500, 1);

INSERT INTO items (item_name, item_type, power) VALUES
('Buster Sword', 'weapon', 55),
('Mythril Armor', 'armor', 25),
('Potion', 'potion', 50),
('Master Sword', 'weapon', 70),
('Energy Shield', 'armor', 40),
('Key of Ancients', 'key_item', 0);

INSERT INTO character_items (character_id, item_id, quantity) VALUES
(1, 1, 1),  -- Cloud -> Buster Sword
(1, 3, 5),  -- Cloud -> Potion
(2, 3, 8),  -- Aerith -> Potion
(3, 4, 1),  -- Link -> Master Sword
(4, 5, 1),  -- Master Chief -> Energy Shield
(5, 6, 1),  -- Sephiroth -> Key of Ancients
(6, 4, 1);  -- Arley -> Key of Ancients
