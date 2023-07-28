local Refresh = {}

function Refresh.new(onDuration: number, offDuration: number, startsOn: boolean?): RefreshType
    if startsOn == nil then startsOn = true end

    return {
        onDuration = onDuration,
        offDuration = offDuration,
        startsOn = if startsOn ~= nil then startsOn else false,
    }
end

export type RefreshType = {
    startsOn: boolean,
    onDuration: number,
    offDuration: number,
}

export type RefreshStatic = typeof(Refresh)

return Refresh :: RefreshStatic