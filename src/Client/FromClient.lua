local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local SleitSignal = require(Packages.SleitSignal)

print("Hi I'm Client")

local signal = SleitSignal.new()

local conn = signal:Connect()

signal:Fire()