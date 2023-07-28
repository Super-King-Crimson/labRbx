local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Packages, Mods = ReplicatedStorage.Packages, ReplicatedStorage.Mods

local HitboxProperties = require(script.HitboxProperties)
local HitDetection = require(script.HitboxProperties.HitDetection)
local Refresh = require(script.HitboxProperties.Refresh)

local SleitSignal = require(ReplicatedStorage.Packages.SleitSignal)

local taskWait, taskSpawn = task.wait, task.spawn

local Hitbox = {}
Hitbox.__index = Hitbox
local hitboxes = {}

local fnFromString = {
    Blockcast = function(hitbox: _Hitbox)
        workspace:Blockcast(hitbox._cframe, hitbox._size, hitbox._direction, hitbox._params)
    end,
    Spherecast = function(hitbox: _Hitbox)
        workspace:Spherecast(hitbox._position, hitbox._radius, hitbox._direction, hitbox._params)
    end,
    PartsInBox = function(hitbox: _Hitbox)
        workspace:GetPartBoundsInBox(hitbox._cframe, hitbox._size, hitbox._params)
    end,
    PartsInPart = function(hitbox: _Hitbox)
        workspace:GetPartsInPart(hitbox._partBoundTo, hitbox._params)
    end,
    PartsInRadius = function(hitbox: _Hitbox)
        workspace:GetPartBoundsInRadius(hitbox._position, hitbox._radius, hitbox._params)
    end
}

function Hitbox.new(): Hitbox
    local self = {} :: _Hitbox

    self._hitboxType = "Blockcast"

    self._size = nil
    self._cframe = nil
    self._position = nil
    self._direction = nil
    self._params = nil
    self._radius = nil

    self._active = false
    self._checkingHits = false

    self._timerInMs = nil
    self._timerTask = nil
        
    self._refreshOffDuration = nil
    self._refreshOnDuration = nil
    self._refreshTask = nil

    self._partBoundTo = nil

    self._caster = nil
    self._hits = {}

    self._onHit = SleitSignal.new()

    setmetatable(self, Hitbox)
    return self :: Hitbox
end

function Hitbox.from(properties: HitboxProperties): Hitbox

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

--#region Types
type _Hitbox = typeof(setmetatable({}, Hitbox)) & {
    _hitboxType: HitboxType,

    _size: Vector3?,
    _cframe: CFrame?,
    _position: Vector3?,
    _direction: Vector3?,
    _params: (RaycastParams | OverlapParams)?,
    _radius: number?,

    _active: boolean,
    _checkingHits: boolean,
    
    _groupMembers: {_Hitbox},
    
    _timerInMs: number?,
    _timerTask: thread?,
    
    _refreshOffDuration: number?,
    _refreshOnDuration: number?,
    _refreshTask: thread?,

    _partBoundTo: BasePart?,

    _caster: Humanoid?,
    _hits: {Humanoid},

    _onHit: SleitSignal.Signal,
} 

export type Hitbox = {
    activate: (Hitbox) -> (),

    decativate: (Hitbox) -> (),
}

--#endregion

return Hitbox