return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "godhome",
      firstgid = 1,
      filename = "../../tilesets/godhome.tsx",
      exportfilename = "../../tilesets/godhome.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 73, 73, 73,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 73, 73,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 73, 73,
        74, 74, 55, 177, 174, 176, 174, 175, 176, 176, 174, 175, 175, 69, 73, 73,
        74, 74, 103, 172, 172, 158, 158, 172, 158, 173, 172, 158, 173, 100, 73, 73,
        74, 74, 103, 173, 159, 159, 172, 159, 158, 173, 159, 173, 172, 100, 73, 73,
        74, 74, 117, 159, 173, 158, 158, 173, 159, 158, 172, 172, 159, 100, 73, 73,
        174, 176, 163, 158, 173, 158, 173, 159, 158, 173, 173, 158, 159, 100, 73, 73,
        165, 164, 165, 165, 165, 164, 165, 165, 165, 164, 164, 164, 164, 97, 73, 73,
        179, 178, 179, 179, 179, 178, 179, 179, 179, 178, 178, 178, 178, 111, 73, 73,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 73, 73, 73,
        74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 73, 73, 73
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 120,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 80,
          width = 440,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 120,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 560,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "markers",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 5,
          name = "spawn",
          type = "",
          shape = "point",
          x = 40,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 6,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 280,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "hub2",
            ["marker"] = "fromlifeblood"
          }
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/lifeblood_room.png",
      id = 6,
      name = "vines",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_orb",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 10,
          name = "lifebloodorb",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 240,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!lifeblood_active"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects_ps",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
