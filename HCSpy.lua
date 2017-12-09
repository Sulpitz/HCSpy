HCSpy = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")

-- /hcspy chat commands
local HCSpyOptions = { 
  type='group',
  args = {
    list = {
      type = 'execute',
      name = "list",
      desc = "list all the HealComm users",
      func = function ()
        HCSpy:List()
      end
    },
    reset = {
      type = "execute",
      name = "reset",
      desc = "Resets the list.",
      func = function ()
        HCSpy:Reset()
      end
    },
    qhv = {
      type = "execute",
      name = "qhv",
      desc = "QuickHealVersion",
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
    self:Print("Hello World!")
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
    self:Print(arg4.." is using HealComm or Luna unit Frames and is now entry "..listmembers - 1 .." in the list")
    self:Print("added for: "..arg1.." "..arg2.." "..arg3.." "..arg4)
    end
    
    --Versioncheck for QuickHeal
    if arg1 == "QuickHeal" and arg2 ~= "versioncheck" then
        DEFAULT_CHAT_FRAME:AddMessage("QH Version: "..arg2.." - "..arg4, 0.95, 0.29, 0.43)
    end
end


-- HealCommSpy functions
function HCSpy:Reset()
  list = {}
  listmembers = 1
  self:Print("List has been reset.")
end
		
	
function HCSpy:List()
	self:Print("People using HealComm:")
	
	for i=1, listmembers - 1 do
	
		self:Print(i..". "..list[i])
		
    end
	
end


--calls for versioncheck for the QuickHeal addon
function HCSpy:QuickHealVersion()
	self:Print("Checking Version of QuickHeal...")
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



