
local L = AceLibrary("AceLocale-2.2"):new("HCSpy")
HCSpy = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")

L:RegisterTranslations("enUS", function() return {
     ["list"] = true,
     ["list all the HealComm users"] = true,
     ["reset"] = true,
     ["Resets the list."] = true,
     ["qhv"] = true,
     ["QuickHealVersion"] = true,
     ["Hello World!"] = true,
     [" is using HealComm or Luna unit Frames and is now entry "] = true,
     [" in the list"] = true,
     ["added for: "] = true,
     ["QH Version: "] = true,
     ["List has been reset."] = true,
     ["People using HealComm:"] = true,
     ["Checking Version of QuickHeal..."] = true,
} end)

	-- Russian localization
L:RegisterTranslations("ruRU", function() return {
     ["list"] = "Cписок",
     ["list all the HealComm users"] = "Cписок всех пользователей HealComm",
     ["reset"] = "Cброс",
     ["Resets the list."] = "Сбросить список.",
     ["qhv"] = "Версия QH",
     ["QuickHealVersion"] = "Версия QuickHeal",
     ["Hello World!"] = "Привет Мир!",
     [" is using HealComm or Luna unit Frames and is now entry "] = " использует HealComm или Luna unit Frames теперь записан ",
     [" in the list"] = " в список",
     ["added for: "] = "добавлен для: ",
     ["QH Version: "] = "Версия QH: ",
     ["List has been reset."] = "Список был сброшен.",
     ["People using HealComm:"] = "Люди использующие HealComm:",
     ["Checking Version of QuickHeal..."] = "Проверяю версию QuickHeal...",
} end)

-- /hcspy chat commands
local HCSpyOptions = { 
  type='group',
  args = {
    list = {
      type = 'execute',
      name = L["list"],
      desc = L["list all the HealComm users"],
      func = function ()
        HCSpy:List()
      end
    },
    reset = {
      type = "execute",
      name = L["reset"],
      desc = L["Resets the list."],
      func = function ()
        HCSpy:Reset()
      end
    },
    qhv = {
      type = "execute",
      name = L["qhv"],
      desc = L["QuickHealVersion"],
      func = function ()
        HCSpy:QuickHealVersion()
      end
    }
  }
}

--Register for ChatCommand Event
HCSpy:RegisterChatCommand({"/hcspy", "/HCSpy"}, HCSpyOptions)

function HCSpy:OnInitialize()
    -- Called when the addon is loaded
end
--
function HCSpy:OnEnable()
    self:Print(L["Hello World!"])
	self:RegisterEvent("CHAT_MSG_ADDON")
end

function HCSpy:OnDisable()
    -- Called when the addon is disabled
end

-- HCSpy variables
local list = {} -- list of people using HCSpy
local listmembers = 1



function HCSpy:CHAT_MSG_ADDON()
    --Add to HealComm users list
    if arg1 == "HealComm" and string.find(arg2, "Healdelay") == nil then --and arg4 ~= UnitName("player") then
        for i=1, listmembers do
            if list[i] == arg4 then
        return
        end
    end
    list[listmembers] = arg4
    listmembers = listmembers + 1
    self:Print(arg4..L[" is using HealComm or Luna unit Frames and is now entry "]..listmembers - 1 ..L[" in the list"])
    self:Print(L["added for: "]..arg1.." "..arg2.." "..arg3.." "..arg4)
    end
    
    --Versioncheck for QuickHeal
    if arg1 == "QuickHeal" and arg2 ~= "versioncheck" then
        DEFAULT_CHAT_FRAME:AddMessage(L["QH Version: "]..arg2.." - "..arg4, 0.95, 0.29, 0.43)
    end
end


-- HealCommSpy functions
function HCSpy:Reset()
  list = {}
  listmembers = 1
  self:Print(L["List has been reset."])
end
		
	
function HCSpy:List()
	self:Print(L["People using HealComm:"])
	
	for i=1, listmembers - 1 do
	
		self:Print(i..". "..list[i])
		
    end
	
end


--calls for versioncheck for the QuickHeal addon
function HCSpy:QuickHealVersion()
	self:Print(L["Checking Version of QuickHeal..."])
    SendAddonMessage("QuickHeal", "versioncheck", RAID)
end





-- Misc
local function strsplit(pString, pPattern)
	local Table = {}
	local fpat = "(.-)" .. pPattern
	local last_end = 1
	local s, e, cap = strfind(pString, fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(Table,cap)
		end
		last_end = e+1
		s, e, cap = strfind(pString, fpat, last_end)
	end
	if last_end <= strlen(pString) then
		cap = strfind(pString, last_end)
		table.insert(Table, cap)
	end
	return Table
end