_G.String=''

local HTTPSERVICE=game:GetService("HttpService")
local terrain = workspace.Terrain

local function from_base64(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

HTTPSERVICE.HttpEnabled=true
for _, tData in pairs(HTTPSERVICE:JSONDecode(from_base64(_G.String))) do
	local x, y, z, voxelType,voxelFill,voxelOrientation=unpack(string.split(tData,'.'))
	terrain:SetCell(x, y, z, Enum.CellMaterial[voxelType],Enum.CellBlock[voxelFill],Enum.CellOrientation[voxelOrientation])
end
HTTPSERVICE.HttpEnabled=false
