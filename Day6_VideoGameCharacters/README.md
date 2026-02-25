# Day 6 – SQL Mini Project: Video Game Characters Database (SQLite)

## Overview
Built a small relational database to model video game characters, their games, classes, and inventory items.

## Tables
- **games**: list of games (title, release year, genre)
- **classes**: character class (Warrior, Mage, etc.)
- **characters**: each character belongs to one game and one class
- **items**: weapons/armor/potions/key items
- **character_items**: junction table for many-to-many relationship between characters and items

## Relationships
- characters.game_id → games.game_id (many characters per game)
- characters.class_id → classes.class_id (many characters per class)
- character_items creates many-to-many between characters and items

## How to Run (sqliteviz.com)
1. Run `schema.sql` to create tables
2. Run `seed.sql` to insert sample data
3. Run queries from `queries.sql`

## Skills Demonstrated
- Designing relational schema with PK/FK
- Many-to-many modeling using a junction table
- JOINs across multiple tables
- Filtering with WHERE
- Aggregations with GROUP BY, COUNT, AVG
- HAVING for group-level filtering
