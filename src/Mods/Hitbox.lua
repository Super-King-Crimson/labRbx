local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Packages, Mods = ReplicatedStorage.Packages, ReplicatedStorage.Mods
local SleitSignal = require(ReplicatedStorage.Packages.SleitSignal)

local taskWait, taskSpawn = task.wait, task.spawn

local Hitbox = {}

function Hitbox.new(): table
    local self = {}
    self._size = Vector3.zero
    self._cframe = CFrame.identity
    self._active = false
    self._checkingHits = false

    self._timer = nil
    self._timerTask = nil
        
    self._refreshOffDuration = nil
    self._refreshOnDuration = nil
    self._refreshTask = nil

    self._relativeInstance = nil

    self._caster = nil
    self._hits = {}

    self._signal = SleitSignal.new()

    return setmetatable(self, Hitbox)
end

function Hitbox:activate()
    if self._active == true then return end

    self._active = true
    self._checkingHits = true
    self._hits = {}

    if self._timer then
        taskSpawn(function()
            taskWait(self._timer)
            self:deactivate()
        end)
    end
    
    if self._refreshInterval then
        taskSpawn(function()
            local tPrev = 0
            while true do
                taskWait(self._refreshOnDuration)
                self._checkingHits = false
                self._hits = {}
                taskWait(self._refreshOffDuration)
            end
        end)
    end
end

function Hitbox:deactivate()
    self._active = false
    self._checkingHits = false

    if self._refreshTask then
        task.cancel(self._refreshTask)
    end
    self._refreshTask = nil

    if self._timerTask and coroutine.status(self._timerTask) ~= "dead" then
        task.cancel(self._timerTask)
    end
    self._timerTask = nil

    
end

export type Hitbox = typeof(setmetatable({}, Hitbox))