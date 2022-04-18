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
  nextlayerid = 6,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "godhome",
      firstgid = 1,
      filename = "../../../tilesets/godhome.tsx",
      exportfilename = "../../../tilesets/godhome.lua"
    },
    {
      name = "decoration",
      firstgid = 225,
      filename = "../../../tilesets/decoration.tsx",
      exportfilename = "../../../tilesets/decoration.lua"
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
        73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
        73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
        73, 55, 99, 127, 85, 127, 113, 85, 99, 85, 127, 113, 69, 73, 73, 73,
        73, 103, 17, 229, 17, 18, 31, 17, 31, 31, 228, 17, 114, 73, 73, 73,
        73, 103, 32, 31, 32, 18, 18, 229, 32, 17, 17, 17, 128, 85, 113, 85,
        73, 103, 17, 17, 18, 32, 17, 32, 32, 31, 17, 31, 17, 18, 31, 31,
        73, 103, 230, 231, 31, 31, 31, 32, 18, 32, 32, 18, 31, 31, 229, 18,
        73, 103, 237, 238, 31, 32, 31, 31, 18, 236, 18, 31, 49, 50, 50, 50,
        73, 103, 18, 32, 32, 236, 17, 32, 31, 18, 18, 62, 63, 64, 64, 64,
        73, 83, 51, 50, 50, 51, 50, 51, 50, 50, 51, 50, 41, 73, 73, 73,
        73, 110, 65, 64, 64, 65, 64, 65, 64, 64, 65, 64, 111, 73, 73, 73,
        73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 40,
          width = 200,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 40,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 40,
          width = 40,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 400,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 320,
          width = 200,
          height = 120,
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
          id = 1,
          name = "spawn",
          type = "",
          shape = "point",
          x = 120,
          y = 260,
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
      id = 3,
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
          id = 2,
          name = "pantheontransition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "pantheonsave",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../../../assets/sprites/tilesets/bench_leaves.png",
      id = 4,
      name = "leaves",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    }
  }
}
