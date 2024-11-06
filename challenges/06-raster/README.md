# Raster data: rendering 2d raster map in 3d

Weather models cannot 'see' the city as we do. The grid cells are too coarse to
represent individual buildings explicitly. Instead, they see the city at block
level.

Local climate zones are archetypes of city blocks. They are used to describe the
important characteristic of a city succinctly. LCZs can be displayed on 2d maps;
however, that doesn't really appeal to ones imagination.

I figured, why not render these nice prototype tiles in 3d? To this end, I tried
to work with a file format that was new to me, called CityJSON. This is how far
I got in limited time. There is still lots of room for improvements, but I think
the concept is already clear and quite nice.

![Image for mapchallenge](LCZ_CityJSON.png)
