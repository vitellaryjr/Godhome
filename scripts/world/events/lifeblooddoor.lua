local Door, super = Class(Event)

function Door:init(data)
    super:init(self, data)
    if not Game:getFlag("lifeblood_door_open") then
        self.sprite = Sprite("tilesets/doors/lifeblood_door", data.width/2, data.height)
        self.sprite:setOrigin(0.5, 1)
        self.sprite:setScale(2)
        self:addChild(self.sprite)

        self.solid = true
    end

    local coordinates = {
        {12, 49},
        {12, 40},
        {13, 31},
        {14, 22},
        {16, 14},
        {20,  6},
        {28,  2},
        {36,  0, true},
        {47,  2},
        {55,  6},
        {60, 13},
        {60, 20, true},
        {63, 29},
        {64, 35},
        {64, 41},
        {63, 47, true},
    }
    self.gems = {}
    local count = Mod:getBindingCount()
    for i,p in ipairs(coordinates) do
        local x, y = p[1]*2, p[2]*2
        local path = "tilesets/doors/lifeblood"
        if p[3] then
            path = path.."_biggem"
        else
            path = path.."_gem"
        end
        if i <= count then
            path = path.."_on"
        else
            path = path.."_off"
        end
        local sprite = Sprite(path, x, y)
        sprite:setScale(2)
        self:addChild(sprite)
        table.insert(self.gems, sprite)
    end
end

function Door:disappear()
    local mask = ColorMaskFX({0.2,0.6,1}, 0)
    self.sprite:addFX(mask)
    Game.world.timer:tween(2, mask, {amount = 1}, "linear", function()
        self.sprite:remove()
        self.solid = false
    end)
    return 2 -- lazy way to make a cutscene wait while the door disappears
end

return Door