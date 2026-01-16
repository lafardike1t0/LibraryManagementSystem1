-- SQL command to add cover_image column to books table
-- Run this in your SQLite database before using the cover image feature

ALTER TABLE books ADD COLUMN cover_image TEXT;

-- Optional: Update existing books with default placeholder image
-- UPDATE books SET cover_image = 'https://via.placeholder.com/300x400?text=No+Cover' WHERE cover_image IS NULL;
