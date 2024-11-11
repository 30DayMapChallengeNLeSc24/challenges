-- toevoegen van hoogte kolom in de hoofdgroepen tegels:
alter table a_nrc.mapch_raster_tile1 add h1 int, add h2 int, add h3 int;
update a_nrc.mapch_raster_tile1 set h1 = 10, h2 = 40, h3 = 80;
alter table a_nrc.mapch_raster_tile2 add h1 int, add h2 int, add h3 int;
update a_nrc.mapch_raster_tile2 set h1 = 10, h2 = 40, h3 = 80;
alter table a_nrc.mapch_raster_tile3 add h1 int, add h2 int, add h3 int;
update a_nrc.mapch_raster_tile3 set h1 = 10, h2 = 40, h3 = 80;
alter table a_nrc.mapch_raster_tile4 add h1 int, add h2 int, add h3 int;
update a_nrc.mapch_raster_tile4 set h1 = 10, h2 = 40, h3 = 80;

-- join van losse tegel per categorie aan de CGLC-grid dataset, de kolom .hoogte in de losse tegels wordt 
-- gekoppeld aan de kolom row_index van het grid (die is hier 1, dus een kolom met 1 toevoegen aan deze set is voldoende)
drop table if exists a_nrc.mapch_raster_tile_join;
create table a_nrc.mapch_raster_tile_join as
select b.h1, b.h2, b.h3, a.hoogte, st_translate(b.geom,(st_xmin(a.geom)-st_xmin(c.geom)),
	(st_ymin(c.geom)-st_ymin(a.geom))) from 
 a_nrc.mapch_raster a --hier de cglc-raster 
 join
 a_nrc.mapch_raster_tile1 b -- hier de eerste variant patroontegel
 on a.hoogte = b.row_index*10 or a.hoogte = b.row_index*50 -- join patroon tegel 1 met cglc categorie 10 en 50 (voorbeeld), 
 --als patroontegel meerdere hoogtes kan krijgen
cross join
(select st_extent(geom) as geom from  a_nrc.mapch_raster) c -- extent van CGLC-grid om patroon tegels juist te positioneren
union
select b.h1, b.h2, b.h3,a.hoogte, st_translate(b.geom,(st_xmin(a.geom)-st_xmin(c.geom)),
	(st_ymin(c.geom)-st_ymin(a.geom))) from 
 a_nrc.mapch_raster a
 join
 a_nrc.mapch_raster_tile2 b -- hier de tweede variant patroontegel
 on a.hoogte = b.row_index*20
cross join
(select st_extent(geom) as geom from  a_nrc.mapch_raster) c
union
select b.h1, b.h2, b.h3,a.hoogte, st_translate(b.geom,(st_xmin(a.geom)-st_xmin(c.geom)),
	(st_ymin(c.geom)-st_ymin(a.geom))) from 
 a_nrc.mapch_raster a
 join
 a_nrc.mapch_raster_tile3 b
 on a.hoogte = b.row_index*30
cross join
(select st_extent(geom) as geom from  a_nrc.mapch_raster) c
union
select b.h1, b.h2, b.h3,a.hoogte, st_translate(b.geom,(st_xmin(a.geom)-st_xmin(c.geom)),
	(st_ymin(c.geom)-st_ymin(a.geom))) from 
 a_nrc.mapch_raster a
 join
 a_nrc.mapch_raster_tile4 b
 on a.hoogte = b.row_index*40
cross join
(select st_extent(geom) as geom from  a_nrc.mapch_raster) c