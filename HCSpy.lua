HCSpy = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")


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
    }
  }
}

 

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

list = {} -- list of people using HCSpy
listmembers = 1



function HCSpy:CHAT_MSG_ADDON()
  if arg1 == "HealComm" and string.find(arg2, "Healdelay") == nil then --and arg4 ~= UnitName("player") then
    --self:Print("HealComm: "..arg1.." "..arg2.." "..arg3.." "..arg4)
 
    --self:Print("HealComm user: "..arg4)
    for i=1, listmembers do
      if list[i] == arg4 then
        --self:Print(arg4.." is already in the list")
        return
      end
    end
    list[listmembers] = arg4
    listmembers = listmembers + 1
    self:Print(arg4.." is using HealComm or Luna unit Frames and is now entry "..listmembers - 1 .." in the list")
    self:Print("added for: "..arg1.." "..arg2.." "..arg3.." "..arg4)
    end
end



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








