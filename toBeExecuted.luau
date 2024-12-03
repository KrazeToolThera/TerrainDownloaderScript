if not workspace:FindFirstChild('Terrain') then return end
local terrain=workspace.Terrain

local savedData = {}
local size = Vector3.new(10, 10, 10)

for x = -size.X, size.X do
    for y =-size.Y,size.Y do
        for z = -size.Z,size.Z do
            local voxelType,voxelFill,voxelOrientation=terrain:GetCell(x,y,z)
            if voxelType ~= Enum.CellMaterial.Empty then
                table.insert(savedData, x..'.'..y..'.'..z..'.'..string.split(tostring(voxelType),'.')[3]..'.'..string.split(tostring(voxelFill),'.')[3]..'.'..string.split(tostring(voxelOrientation),'.')[3])
            end
        end
    end
end

setclipboard(base64_encode(game:GetService("HttpService"):JSONEncode(savedData)))
