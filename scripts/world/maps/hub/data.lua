return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 54,
  height = 20,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 13,
  nextobjectid = 55,
  properties = {
    ["music"] = "godhome",
    ["name"] = "Atrium"
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
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/bg_a.png",
      id = 3,
      name = "bg1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 0.2,
      parallaxy = 0.2,
      repeatx = true,
      repeaty = true,
      properties = {}
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/bg_b.png",
      id = 4,
      name = "bg2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 80,
      parallaxx = 0.4,
      parallaxy = 0.4,
      repeatx = true,
      repeaty = false,
      properties = {}
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/bg_c.png",
      id = 5,
      name = "bg3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 200,
      parallaxx = 0.6,
      parallaxy = 0.6,
      repeatx = true,
      repeaty = false,
      properties = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 54,
      height = 20,
      id = 8,
      name = "bgtiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 78, 78, 0, 0, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 78, 78, 0, 0, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 0, 0, 58, 59, 0, 0, 58, 59, 0, 0, 0, 0, 0, 0, 0, 0, 58, 59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 54,
      height = 20,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 3, 3, 4, 4, 3, 3, 3, 4, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 32, 32, 32, 18, 18, 18, 32, 17, 18, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 31, 17, 17, 17, 236, 32, 17, 17, 31, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 17, 32, 32, 32, 49, 51, 50, 50, 51, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 126, 140, 126, 112, 63, 65, 64, 64, 65, 61, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 3, 4, 100, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 103, 125, 125, 140, 126, 86, 73, 73, 73, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 17, 18, 31, 100, 74, 6, 7, 74, 73, 6, 7, 73, 74, 6, 7, 73, 103, 125, 126, 139, 139, 100, 73, 6, 7, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 17, 17, 32, 100, 73, 20, 21, 74, 73, 20, 21, 74, 73, 20, 21, 73, 103, 125, 125, 139, 125, 100, 73, 20, 21, 73, 103, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 18, 229, 18, 114, 74, 34, 35, 73, 73, 34, 35, 74, 73, 34, 35, 74, 117, 140, 140, 140, 125, 115, 73, 34, 35, 73, 116, 17, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 2, 4, 4, 4, 3, 3, 4, 4, 4, 3, 3, 3, 3, 3, 102, 32, 32, 32, 128, 99, 77, 78, 99, 85, 77, 78, 85, 127, 77, 78, 99, 131, 32, 228, 18, 32, 129, 113, 77, 78, 85, 130, 32, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 16, 18, 32, 17, 18, 31, 228, 18, 31, 32, 32, 31, 32, 17, 31, 17, 18, 18, 18, 235, 31, 17, 32, 32, 31, 32, 31, 31, 31, 31, 17, 31, 32, 17, 31, 230, 231, 17, 31, 31, 31, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 16, 18, 18, 17, 17, 18, 17, 17, 32, 31, 236, 31, 31, 32, 32, 17, 18, 18, 32, 17, 18, 17, 18, 32, 229, 31, 17, 32, 17, 18, 17, 32, 32, 32, 31, 237, 238, 17, 31, 31, 18, 31, 31, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 44, 46, 46, 45, 46, 46, 46, 45, 46, 45, 45, 46, 45, 46, 43, 45, 45, 45, 43, 45, 46, 46, 43, 46, 46, 45, 45, 43, 46, 46, 45, 52, 31, 32, 18, 31, 49, 51, 50, 51, 50, 50, 51, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        71, 58, 60, 60, 59, 60, 60, 60, 59, 60, 59, 59, 60, 59, 60, 57, 59, 59, 59, 57, 59, 60, 60, 57, 60, 60, 59, 59, 57, 60, 60, 59, 66, 70, 139, 126, 112, 63, 65, 64, 65, 64, 64, 65, 61, 76, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 86, 73, 73, 73, 73, 74, 73, 73, 73, 73, 73, 73, 74, 73, 74, 73, 73, 73, 74, 73, 73, 73, 74, 74, 73, 74, 73, 74, 73, 74, 74, 75, 84, 139, 125, 112, 72, 73, 73, 73, 73, 73, 73, 75, 76, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 100, 73, 73, 73, 73, 74, 74, 73, 73, 73, 73, 73, 73, 74, 73, 73, 73, 74, 74, 74, 74, 73, 73, 73, 74, 73, 73, 74, 74, 73, 74, 89, 140, 126, 125, 126, 86, 73, 73, 73, 73, 73, 73, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 100, 73, 74, 74, 74, 73, 73, 73, 74, 74, 74, 73, 73, 73, 73, 74, 74, 74, 74, 73, 74, 73, 73, 73, 73, 74, 74, 73, 74, 74, 73, 103, 125, 125, 140, 139, 100, 73, 73, 73, 73, 73, 73, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "collision",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
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
          x = 40,
          y = 440,
          width = 560,
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
          x = 560,
          y = 320,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 280,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 40,
          width = 40,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1800,
          y = 400,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 640,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1720,
          y = 360,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1720,
          y = 120,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1320,
          y = 80,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 40,
          width = 40,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 640,
          width = 1280,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 680,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 680,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 920,
          y = 440,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 440,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1240,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 280,
          width = 80,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1560,
          y = 280,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1640,
          y = 280,
          width = 80,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 11,
      name = "objects_warp",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 50,
          name = "dreamwarp",
          type = "",
          shape = "ellipse",
          x = 1360,
          y = 160,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "p5_unlocked",
            ["map"] = "peak",
            ["marker"] = "spawn"
          }
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
          x = 160,
          y = 560,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "fromhub2",
          type = "",
          shape = "point",
          x = 1400,
          y = 740,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "p1_exit",
          type = "",
          shape = "point",
          x = 880,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "p2_exit",
          type = "",
          shape = "point",
          x = 1040,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "p3_exit",
          type = "",
          shape = "point",
          x = 1200,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "p4_exit",
          type = "",
          shape = "point",
          x = 1600,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "save_spawn",
          type = "",
          shape = "point",
          x = 690,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "warp",
          type = "",
          shape = "point",
          x = 1520,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "warp_pos",
          type = "",
          shape = "point",
          x = 1400,
          y = 200,
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
      id = 7,
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
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 670,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "save_spawn"
          }
        },
        {
          id = 24,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1320,
          y = 800,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "hub2",
            ["marker"] = "fromhub"
          }
        },
        {
          id = 26,
          name = "panth_door",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["pantheon"] = 1
          }
        },
        {
          id = 27,
          name = "panth_door",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["pantheon"] = 2
          }
        },
        {
          id = 28,
          name = "panth_door",
          type = "",
          shape = "rectangle",
          x = 1160,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["pantheon"] = 3
          }
        },
        {
          id = 29,
          name = "panth_door",
          type = "",
          shape = "rectangle",
          x = 1560,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["pantheon"] = 4
          }
        },
        {
          id = 52,
          name = "gate",
          type = "",
          shape = "rectangle",
          x = 1500,
          y = 480,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!p4_unlocked",
            ["id"] = "p4"
          }
        },
        {
          id = 53,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 1440,
          y = 440,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["scene"] = "doorcheck.p4"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "objects_ps",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/tilesets/fg_a.png",
      id = 9,
      name = "fg1",
      visible = true,
      opacity = 1,
      offsetx = 502,
      offsety = -50,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    }
  }
}
