-- Récupérer les artists selon leur name
SELECT artists.name -- (ou name)
FROM artists

-- Compter le nombre de tracks qui font moins de deux minutes
SELECT COUNT(*)
FROM tracks
WHERE tracks.milliseconds < 120000

-- Récupérer les 10 premiers albums triés par ordre croissant
SELECT albums.title -- ou (title)
FROM albums
ORDER BY albums.title ASC
LIMIT 10


-- Deuxième partie du livecode --

-- Récupérer le nom des tracks et le titre de l'album associé dont les tracks contiennent
-- un mot clé

SELECT
  tracks.name,
  albums.title
FROM tracks
JOIN albums ON tracks.album_id = albums.id
WHERE UPPER(tracks.name) LIKE "%love%" -- UPPER permet de faire une recherche case insensitive

-- Trouver les 5 meilleurs artists (le nom) avec le plus de tracks dans le genre "Rock"
SELECT
    artists.name,
    COUNT(*) AS track_count
FROM artists
JOIN albums ON albums.artist_id = artists.id
JOIN tracks ON tracks.album_id = albums.id
JOIN genres ON tracks.genre_id = genres.id
WHERE genres.name = "Rock"
GROUP BY artists.name
ORDER BY track_count DESC
LIMIT 5
