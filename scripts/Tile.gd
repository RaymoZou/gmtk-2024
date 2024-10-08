class_name Tile

# These are vectors that point to the coordinates of the tile in the tileset atlas
# update here if the location of the sprite on the spritesheet changes
const STONE_TILE = Vector2(8, 5)
const GRASS_TILE = Vector2(3, 3)
const WATER_TILE = Vector2(9, 7)
const DIRT_TILE = Vector2(7, 1)
const SNOW_TILE = Vector2(10, 7)

enum TILE_TYPE { STONE, GRASS, WATER, DIRT, SNOW }
