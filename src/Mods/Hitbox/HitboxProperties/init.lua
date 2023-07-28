local HitDetection = require(script.HitDetection)
local Refresh = require(script.Refresh)

function HitboxProperties.create(detectionType: HitDetectionType, deactivateTimer: number?, maxHits: number?, refreshType: RefreshType?): HitboxProperties
    if deactivateTimer and deactivateTimer < 0 then deactivateTimer = nil end
    if maxHits and maxHits < 0 then maxHits = nil end

    return {
        detectionType = detectionType,
        deactivateTimer = deactivateTimer,
        maxHits = maxHits,
        refreshType = refreshType,

        active = false,
        checkingHits = false,
    }
end

--#region Types
export type Blockcast = HitDetection.Blockcast
export type Spherecast = HitDetection.Spherecast
export type PartsInBox = HitDetection.PartsInBox
export type PartsInPart = HitDetection.PartsInPart
export type PartsInRadius = HitDetection.PartsInRadius
export type HitDetectionType = HitDetection.HitDetectionType

export type Refresh = Refresh.RefreshType

export type RefreshType = {onFor: number, offFor: number, startsOn: "on" | "off"}

export type HitboxProperties = {
    detectionType: HitDetectionType,
    maxHits: number?,
    refreshType: RefreshType?,
    deactivateTimer: number?,

    active: boolean,
    checkingHits: boolean,
}

export type HitboxPropertiesStatic = typeof(HitboxProperties)
--#endregion

return HitboxProperties :: HitboxPropertiesStatic