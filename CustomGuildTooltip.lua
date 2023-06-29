local CGTWelcome = CreateFrame("Frame")
CGTWelcome:RegisterEvent("ADDON_LOADED")

local function GTEventHandler(self, event, arg1)

	if event == "ADDON_LOADED" and arg1 == "CustomGuildTooltip" then
		DEFAULT_CHAT_FRAME:AddMessage("Loaded CustomGuildTooltip")
	end

end

CGTWelcome:SetScript("OnEvent", GTEventHandler)

if guildMap == nil then guildMap = {} end


-- Now you can add colors in-game!
SLASH_GCOLOR1 = "/gcolor"
SLASH_GCOLOR2 = "/gcolors"
local isMyColorFrame = false
local function colorDecToHex(r, g, b)
	local symbolList = "0123456789ABCDEF"
	r = r*255
	g = g*255
	b = b*255
	local red1 = symbolList:sub(floor(r/16)+1,floor(r/16)+1)
	local red2 = symbolList:sub(mod(r,16)+1,mod(r,16)+1)
	local green1 = symbolList:sub(floor(g/16)+1,floor(g/16)+1)
	local green2 = symbolList:sub(mod(g,16)+1,mod(g,16)+1)
	local blue1 = symbolList:sub(floor(b/16)+1,floor(b/16)+1)
	local blue2 = symbolList:sub(mod(b,16)+1,mod(b,16)+1)
	
	local hexString = red1 .. red2 .. green1 .. green2 .. blue1 .. blue2
	return hexString
end
local GuildNameSlash = ""
SlashCmdList["GCOLOR"] = function(gname)
	GuildNameSlash = gname
	if gname == "" then
		-- print everything stored
		local colnum = 3
		local col = 0
		local printstring = ""
		for n, c in pairs(guildMap) do
			if col == 0 then printstring = "" end
			if c ~= nil then
				printstring = printstring .. c .. n .. "|r    "
				if col+1 == colnum then
					print(printstring)
				end
				col = (col+1) %colnum
			end
		end
		if col ~= 0 then print(printstring) end
	else
		if ColorPickerFrame:IsShown() then
			isMyColorFrame = false
		else
			isMyColorFrame = true
			ColorPickerFrame:SetColorRGB(1,1,1);
			ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = false, 1;
			ColorPickerFrame:Show()
		end
	end
end
-- make changes on color picker okay button
local oldColorPickerButton = ColorPickerOkayButton:GetScript("OnClick")
local function ColorPickerEnter(...) 
	if isMyColorFrame then
		local r, g, b = ColorPickerFrame:GetColorRGB()
		local hexString = colorDecToHex(r, g, b)
		
		if hexString == "FFFFFF" then
			guildMap[string.upper(GuildNameSlash)] = nil
			print("|cFF" .. hexString .. string.upper(GuildNameSlash)	.. "|r")
		else 
			guildMap[string.upper(GuildNameSlash)] = "|cFF" .. hexString
			print("|cFF" .. hexString .. string.upper(GuildNameSlash)	.. "|r")
		end
		
		ColorPickerFrame:Hide()
		isMyColorFrame = false
	else
		oldColorPickerButton(...)
	end
end
ColorPickerOkayButton:SetScript("OnClick", ColorPickerEnter)

local playerRealm = GetRealmName()
local IndexGroupTBCPrepatchGUID = {
	tonumber("01CEF798",16),
	tonumber("02F50194",16),
	tonumber("00A383F7",16)
}
local IndexGroupWOTLKPrepatchGUID = {
	tonumber("031CFC4B",16),
	tonumber("044C878C",16),
	tonumber("00CCF9A5",16)
}
local Server2IndexGroup = {
	["4647"] = IndexGroupTBCPrepatchGUID[1],
	["4395"] = IndexGroupTBCPrepatchGUID[1],
	["4372"] = IndexGroupTBCPrepatchGUID[1],
	["4373"] = IndexGroupTBCPrepatchGUID[1],
	["4374"] = IndexGroupTBCPrepatchGUID[1],
	["4376"] = IndexGroupTBCPrepatchGUID[1],
	["4725"] = IndexGroupTBCPrepatchGUID[1],
	["4795"] = IndexGroupTBCPrepatchGUID[1],
	
	["4728"] = IndexGroupTBCPrepatchGUID[2],
	["4731"] = IndexGroupTBCPrepatchGUID[2],
	["4648"] = IndexGroupTBCPrepatchGUID[2],
	["4387"] = IndexGroupTBCPrepatchGUID[2],
	["4726"] = IndexGroupTBCPrepatchGUID[2],
	["4388"] = IndexGroupTBCPrepatchGUID[2],
	["4727"] = IndexGroupTBCPrepatchGUID[2],
	["4408"] = IndexGroupTBCPrepatchGUID[2],
	["4384"] = IndexGroupTBCPrepatchGUID[2],
	["4385"] = IndexGroupTBCPrepatchGUID[2],
	["4738"] = IndexGroupTBCPrepatchGUID[2],
	["4800"] = IndexGroupTBCPrepatchGUID[2],
	
	["4667"] = IndexGroupTBCPrepatchGUID[3],
	["4670"] = IndexGroupTBCPrepatchGUID[3],
	["4669"] = IndexGroupTBCPrepatchGUID[3],
}
local Server2IndexGroup2 = {
	["4647"] = IndexGroupWOTLKPrepatchGUID[1],
	["4395"] = IndexGroupWOTLKPrepatchGUID[1],
	["4372"] = IndexGroupWOTLKPrepatchGUID[1],
	["4373"] = IndexGroupWOTLKPrepatchGUID[1],
	["4374"] = IndexGroupWOTLKPrepatchGUID[1],
	["4376"] = IndexGroupWOTLKPrepatchGUID[1],
	["4725"] = IndexGroupWOTLKPrepatchGUID[1],
	["4795"] = IndexGroupWOTLKPrepatchGUID[1],
	
	["4728"] = IndexGroupWOTLKPrepatchGUID[2],
	["4731"] = IndexGroupWOTLKPrepatchGUID[2],
	["4648"] = IndexGroupWOTLKPrepatchGUID[2],
	["4387"] = IndexGroupWOTLKPrepatchGUID[2],
	["4726"] = IndexGroupWOTLKPrepatchGUID[2],
	["4388"] = IndexGroupWOTLKPrepatchGUID[2],
	["4727"] = IndexGroupWOTLKPrepatchGUID[2],
	["4408"] = IndexGroupWOTLKPrepatchGUID[2],
	["4384"] = IndexGroupWOTLKPrepatchGUID[2],
	["4385"] = IndexGroupWOTLKPrepatchGUID[2],
	["4738"] = IndexGroupWOTLKPrepatchGUID[2],
	["4800"] = IndexGroupWOTLKPrepatchGUID[2],
	
	["4667"] = IndexGroupWOTLKPrepatchGUID[3],
	["4670"] = IndexGroupWOTLKPrepatchGUID[3],
	["4669"] = IndexGroupWOTLKPrepatchGUID[3],
}

local legendaryTitles = {', Champion of the Naaru', 'Field Marshal', 'Grand Marshal', 'High Warlord', 'Warlord',
						 'Scarab Lord', 'Merciless Gladiator', 'Vengeful Gladiator', 'Brutal Gladiator', 'Gladiator', ", Hand of A'dal",
						"Obsidian Slayer", " the Magic Seeker", ", Conqueror of Naxxramas", ", Death's Demise", " the Celestial Defender", "Grand Crusader", -- WOTLK realm firsts
						" the Astral Walker", ", Herald of the Titans",
						" the Insane", " the Immortal", " the Undying", "Bloodsail Admiral"} 


GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    --local name, unit = self:GetUnit()
	if not IsControlKeyDown() then
    if UnitIsPlayer("mouseover") and not UnitIsUnit("mouseover", "player") then
		
        GameTooltip:ClearLines()
        local guildName = GetGuildInfo("mouseover")
        local localizedClass, englishClass, classIndex = UnitClass("mouseover")
        local race = UnitRace("mouseover")
        local level = UnitLevel("mouseover")
		local guildC
		if guildName ~= nil then
			guildC = guildMap[string.upper(guildName)]
		else
			guildC = nil
		end
		local name = ""
		local hostility = ""
		
		-- change name/title colors
		if UnitIsPVP("mouseover") == false then
			hostility = '|cFFFFFFFF'
		elseif UnitIsFriend("player", "mouseover") then
			hostility = '|cFF00CC00'
		elseif UnitIsEnemy("player", "mouseover") then
			hostility = '|cFFCC0000'
		end
		name = hostility .. UnitPVPName("mouseover") .. '|r'
		local found = false
		local i = 1
		while i <= table.getn(legendaryTitles)  and found == false do
			if string.find(name, legendaryTitles[i]) then
				if legendaryTitles[i] == ", Champion of the Naaru" then
					name = hostility .. (select(1,UnitName("mouseover")))  .. "|r |T135909:16|t"
				elseif legendaryTitles[i] == ", Hand of A'dal" then
					name = hostility .. (select(1,UnitName("mouseover")))  .. "|r |T135928:16|t"
				elseif legendaryTitles[i] == "High Warlord" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. "H. Warlord" .. '|r' .. hostility)
					name = name .. " |T132485:16|t"
				elseif legendaryTitles[i] == "Grand Marshal" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. legendaryTitles[i] .. '|r' .. hostility)
					name = name .. " |T132486:16|t"
				elseif legendaryTitles[i] == "Scarab Lord" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. legendaryTitles[i] .. '|r' .. hostility)
					name = name .. " |T134399:16|t"
				elseif legendaryTitles[i] == "Deadly Gladiator" or
						legendaryTitles[i] == "Furious Gladiator" or
						legendaryTitles[i] == "Relentless Gladiator" or
						legendaryTitles[i] == "Wrathful Gladiator" or
						legendaryTitles[i] == "Merciless Gladiator" or
						legendaryTitles[i] == "Vengeful Gladiator" or
						legendaryTitles[i] == "Brutal Gladiator" or
						legendaryTitles[i] == "Gladiator" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. legendaryTitles[i] .. '|r' .. hostility)
					name = name .. " |T132487:16|t"
				elseif legendaryTitles[i] == " the Insane" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. legendaryTitles[i] .. '|r' .. hostility)
					name = name .. " |T236206:16|t"
				elseif legendaryTitles[i] == "Bloodsail Admiral" then
					name = hostility .. (select(1,UnitName("mouseover")))  .. "|r |T133168:16|t"
				elseif legendaryTitles[i] == ", Herald of the Titans" then
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. ", HotT" .. '|r' .. hostility)
					name = name .. " |T254087:16|t"
				else
					name = string.gsub(name, legendaryTitles[i], '|r|cFFE6CC80' .. legendaryTitles[i] .. '|r' .. hostility)
				end
				found = true
			end
			i = i+1
		end
		if not found then
			name = hostility .. (select(1,UnitName("mouseover")))  .. '|r'
		end
		self:AddLine(name, 1, 1, 1, true)
		
		
		if level == -1 then level = "??" end
		
		local guid = UnitGUID("mouseover")
		local mouseRealmName = (select(7,GetPlayerInfoByGUID(guid))) -- empty string "" if on same realm
		if mouseRealmName ~= "" and mouseRealmName ~= nil then
			self:AddLine('|cFFC2C2C2' .. mouseRealmName .. '|r', 1, 1, 1, true)
		end
		
		if guildName ~= nil then									-- has a guild
			if mouseRealmName == "" and guildC ~= nil then 		-- is same realm and special color
				self:AddLine(guildC .. "<" .. guildName .. ">" .. '|r', 1, 1, 1, true)
			else -- generic color
				self:AddLine("<" .. guildName .. ">" .. '|r', 1, 1, 1, true)
			end
		end
		
		self:AddLine("Level " .. level .. " " .. race .. " |c" .. RAID_CLASS_COLORS[englishClass].colorStr .. localizedClass .. '|r' .. " (Player)", 1, 1, 1, false)
		GameTooltipStatusBar:Show()
		if UnitIsPVP("mouseover") and UnitIsFriend("player", "mouseover") then
			self:AddLine('|cFF00CC00' .. "PvP" .. '|r', 1, 1, 1, true)
		end
		if UnitIsPVP("mouseover") and UnitIsEnemy("player", "mouseover") then
			self:AddLine('|cFFCC0000' .. "PvP" .. '|r', 1, 1, 1, true)
		end
		
		-- native detector
		-- if player's GUID is less than oldest BE/Drae then the player is considered a "native" to the server
		-- This means the character was likely created before TBCC prepatch
		local realmID = string.sub(guid, 8, #guid)
		realmID = string.sub(realmID, 1, string.find(realmID,'-')-1)
		guid = tonumber(string.sub(UnitGUID("mouseover"), #guid-7, #guid),16)
		if guid < Server2IndexGroup[realmID] then -- classic native character
			GameTooltip:SetBackdropBorderColor(1, 0.8, 0.4, 1)
			if mouseRealmName == "" then
				self:AddLine('|cFFFFCC66Native|r', 1, 1, 1, true)
			else
				self:AddLine('|cFFFFCC66' .. mouseRealmName .. ' Native|r', 1, 1, 1, true)
			end
		elseif guid < Server2IndexGroup2[realmID] then -- tbc character
			--self:AddLine('|cFF97EE72TBC|r', 1, 1, 1, true)
			GameTooltip:SetBackdropBorderColor(0.592, 0.933, 0.447, 1)
		else	-- wotlk character
			--self:AddLine('|cFF8CCFCFWotLK|r', 1, 1, 1, true)
			GameTooltip:SetBackdropBorderColor(0, 0.749, 1, 1)
		end
		
		
		-- show GUID if alt is pressed
		if IsAltKeyDown() then
			self:AddLine(UnitGUID('mouseover'), 1, 1, 1, true)
		end
	end
	end
end)

GameTooltip:HookScript("OnTooltipCleared", function(self)
	GameTooltip:SetBackdropBorderColor(1, 1, 1, 1)
	GameTooltipStatusBar:Hide()
end)