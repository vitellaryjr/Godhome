local ShadeLord, super = Class(Object)

function ShadeLord:init()
    super:init(self, 0,0)
    self.layer = BATTLE_LAYERS["battlers"] - 5
    self:setScale(2)

    self.s1 = Sprite("enemies/p5/shadelord/idle", 0,0)
    self.s1:play(0.18, true)
    self.s1.alpha = 0.6
    self:addChild(self.s1)
    self.s2 = Sprite("enemies/p5/shadelord/idle", 0,0)
    self.s2:play(0.2, true)
    self.s2.alpha = 0.6
    self:addChild(self.s2)

    -- tendrils
    self.t1 = Sprite("enemies/p5/shadelord/tendril", 125,143)
    self.t1.layer = -1
    self.t1:play(0.08, true)
    self:addChild(self.t1)
    self.t2 = Sprite("enemies/p5/shadelord/tendril", 110,105)
    self.t2.layer = -1
    self.t2:play(0.1, true)
    self.t2.rotation = math.rad(30)
    self:addChild(self.t2)
    self.t3 = Sprite("enemies/p5/shadelord/tendril", 30,90)
    self.t3.layer = -1
    self.t3:play(0.12, true)
    self.t3.scale_x = -1
    self.t3.rotation = math.rad(-30)
    self:addChild(self.t3)
    self.t4 = Sprite("enemies/p5/shadelord/tendril", 50,50)
    self.t4.layer = -1
    self.t4:play(0.1, true)
    self.t4.rotation = math.rad(-45)
    self:addChild(self.t4)
    self.t5 = Sprite("enemies/p5/shadelord/tendril", 70,10)
    self.t5.layer = -1
    self.t5:play(0.08, true)
    self.t5.rotation = math.rad(0)
    self.t5:setScale(2)
    self:addChild(self.t5)
    self.t6 = Sprite("enemies/p5/shadelord/tendril", 60,-30)
    self.t6.layer = -1
    self.t6:play(0.1, true)
    self.t6.rotation = math.rad(-20)
    self.t6:setScale(-2,2)
    self:addChild(self.t6)
    self.t7 = Sprite("enemies/p5/shadelord/tendril", 40,50)
    self.t7.layer = -1
    self.t7:play(0.12, true)
    self.t7.alpha = 0.6
    self.t7.rotation = math.rad(-35)
    self.t7:setScale(3)
    self:addChild(self.t7)

    -- arms
    self.a1 = Sprite("enemies/p5/shadelord/arm_a", 110,120)
    self.a1.layer = -1
    self:addChild(self.a1)
    self.a2 = Sprite("enemies/p5/shadelord/arm_a", 90,120)
    self.a2.layer = -1
    self.a2.scale_x = -1
    self:addChild(self.a2)
    self.a3 = Sprite("enemies/p5/shadelord/arm_a", 94,100)
    self.a3.layer = -1
    self.a3.rotation = math.pi
    self:addChild(self.a3)

    self.sine = 0
end

function ShadeLord:update(dt)
    super:update(self, dt)
    self.sine = self.sine + dt
    self.s1.x = math.sin(self.sine*5)*1
    self.s2.x = math.sin(self.sine*4)*-1
    self.s1.y = math.sin(self.sine*3)*2
    self.s2.y = math.sin(self.sine*3)*2

    self.a1.rotation = math.sin(self.sine*20)*math.rad(0.5)
    self.a1.y = 120 + math.sin(self.sine*7)*1
    self.a2.rotation = math.rad(10) + math.sin(self.sine*10)*math.rad(0.5)
    self.a2.y = 120 + math.sin(self.sine*5)*1
    self.a3.rotation = math.rad(170) + math.sin(self.sine*15)*math.rad(0.5)
    self.a3.y = 100 + math.sin(self.sine*10)*1
end

return ShadeLord