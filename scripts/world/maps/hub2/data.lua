return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 23,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 18,
  properties = {
    ["music"] = "godhome"
  },
  tilesets = {
    {
      name = "godhome",
      firstgid = 1,
      filename = "../../tilesets/godhome.tsx"
    },
    {
      name = "decoration",
      firstgid = 225,
      filename = "../../tilesets/decoration.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
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
        73, 103, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 18, 18, 17, 32, 100, 73, 73,
        73, 103, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 32, 31, 18, 31, 100, 73, 73,
        73, 103, 73, 73, 8, 9, 10, 11, 73, 73, 73, 6, 7, 73, 73, 103, 31, 17, 32, 31, 100, 73, 73,
        73, 103, 73, 73, 22, 23, 24, 25, 73, 73, 73, 20, 21, 73, 73, 103, 31, 32, 17, 17, 100, 73, 73,
        73, 103, 73, 73, 36, 37, 38, 39, 73, 73, 73, 34, 35, 73, 73, 117, 18, 18, 31, 18, 100, 73, 73,
        73, 103, 99, 85, 99, 79, 80, 127, 99, 85, 127, 77, 78, 99, 99, 131, 18, 230, 231, 18, 100, 73, 73,
        73, 103, 230, 231, 31, 32, 32, 18, 31, 236, 17, 18, 31, 17, 18, 18, 17, 237, 238, 31, 100, 73, 73,
        73, 103, 237, 238, 18, 31, 32, 235, 18, 18, 18, 18, 17, 17, 229, 31, 32, 32, 18, 18, 100, 73, 73,
        73, 83, 50, 51, 51, 50, 51, 50, 51, 50, 50, 51, 51, 50, 51, 51, 50, 51, 50, 50, 97, 73, 73,
        73, 110, 64, 65, 65, 64, 65, 64, 65, 64, 64, 65, 65, 64, 65, 65, 64, 65, 64, 64, 111, 73, 73,
        73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
        73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          x = 600,
          y = 0,
          width = 40,
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
          x = 520,
          y = 120,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 120,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 120,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 200,
          width = 40,
          height = 160,
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
          y = 360,
          width = 720,
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
          x = 800,
          y = 0,
          width = 40,
          height = 360,
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
          id = 9,
          name = "fromhub",
          type = "",
          shape = "point",
          x = 720,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "fromhall",
          type = "",
          shape = "point",
          x = 480,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "fromlifeblood",
          type = "",
          shape = "point",
          x = 240,
          y = 240,
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
          id = 10,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = -40,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "hub",
            ["marker"] = "fromhub2"
          }
        },
        {
          id = 11,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 140,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "right",
            ["map"] = "hallofgods",
            ["marker"] = "entrance"
          }
        },
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 140,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "right",
            ["map"] = "lifeblood"
          }
        },
        {
          id = 16,
          name = "lifeblooddoor",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 80,
          width = 160,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!lifeblood_door_open"
          }
        },
        {
          id = 17,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 200,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "doorcheck.lifeblood"
          }
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
      height = 12,
      id = 5,
      name = "tilesfg",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
