local HitDetection = {}

function HitDetection.newBlockcast(cframe: CFrame, size: Vector3, direction: Vector3, params: RaycastParams): Blockcast
    return {
        cframe = cframe,
        size = size,
        direction = direction,
        params = params
    }
end

function HitDetection.newSpherecast(position: Vector3, radius: number, direction: Vector3, params: RaycastParams?): Spherecast
    return {
        position = position,
        radius = radius,
        direction = direction,
        params = params,
    }
end

function HitDetection.newPartsInBox(cframe: CFrame, size: Vector3, params: OverlapParams?): PartsInBox
    return { 
        cframe = cframe,
        size = size,
        params = params,
    }
end

function HitDetection.newPartsInPart(part: BasePart, params: HitboxParams?): PartsInPart
    return {
        part = part,
        params = params,
    }
end

function HitDetection.newPartsInRadius(position: Vector3, radius: number, params: HitboxParams?): PartsInRadius
    return {
        position = position,
        radius = radius,
        params = params
    }
end

--#region Types
export type Blockcast = {
    cframe: CFrame,
    size: Vector3,
    direction: Vector3,
    params: HitboxParams?,
}

export type Spherecast = {
    position: Vector3,
    radius: number,
    direction: Vector3,
    params: HitboxParams?,
}

export type PartsInBox = {
    cframe: CFrame,
    size: Vector3,
    params: HitboxParams?,
}

export type PartsInPart = {
    part: BasePart,
    params: HitboxParams?,
}

export type PartsInRadius = {
    position: Vector3,
    radius: number,
    params: HitboxParams?,
}

type HitboxParams = RaycastParams | OverlapParams

export type HitDetectionType = Blockcast | Spherecast | PartsInBox | PartsInPart | PartsInRadius
--#endregion

return HitDetection