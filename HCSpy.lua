local HCSpyPlayerListFontstring = {}

local list = {} -- list of people using HCSpy
local listmembers = 1
local versionTable = {}


SLASH_HCSPY1 = '/hcspy'
function SlashCmdList.HCSPY(msg, editbox) 
  if msg == "reset" then
    pPrint("HCSpy is now reset!")
    HCSpy_Reset()
  elseif msg == "list" then
    HCSpy_List()
  else
    HCSpy_ToggleUiWindow()
  end
end


function HCSpy_UpdateGui()
    for index, playerName in pairs(list) do
            -- create frame if nessesarry
        if HCSpyPlayerListFontstring[index] == nil then

          HCSpyPlayerListFontstring[index] = HCSpyUiWindow:CreateFontString(nil, nil, "HCSpyUiWindowListNameFontstring")
          HCSpyPlayerListFontstring[index]:SetText(playerName)
          HCSpyPlayerListFontstring[index]:SetPoint('TOPLEFT', "HCSpyUiWindow", 'TOPLEFT', 5, (6 - 10 * index))
          HCSpyUiWindow:SetHeight(8 + 10 * index)
          if versionTable[playerName] == "LCHC10" then
            HCSpyPlayerListFontstring[index]:SetTextColor(1, 0, 0, 1)
          else
            HCSpyPlayerListFontstring[index]:SetTextColor(1, 1, 1, 1)
          end

        else
          HCSpyPlayerListFontstring[index]:SetText(playerName)          
          if versionTable[playerName] == "LCHC10" then
            HCSpyPlayerListFontstring[index]:SetTextColor(1, 0, 0, 1)
          else
            HCSpyPlayerListFontstring[index]:SetTextColor(1, 1, 1, 1)
          end
        end
    end
end


function HCSpy_OnLoad()
  HCSpy:RegisterEvent('CHAT_MSG_ADDON')
  C_ChatInfo.RegisterAddonMessagePrefix("LCHC10")
  C_ChatInfo.RegisterAddonMessagePrefix("LHC40")
end

function HCSpy_OnEvent(self, event, ...)
  arg1, arg2, arg3, arg4, arg5 = ...
  arg4 = string.match(arg4, "[^-]+")
    if event == "CHAT_MSG_ADDON" then
      if arg1 =="RMH" then return end
      print(event, arg1, arg4, "(" .. arg2 .. ")")
      if arg1 == "LCHC10" then
        for i=1, listmembers do
          if list[i] == arg4 then return end
        end     
        list[listmembers] = arg4        
        versionTable[arg4] = "LCHC10"
        listmembers = listmembers + 1
        HCSpy_UpdateGui()

      elseif arg1 == "LHC40" then
        for i=1, listmembers do
          if list[i] == arg4 then return end
        end     
        list[listmembers] = arg4
        versionTable[arg4] = "LHC40"
        listmembers = listmembers + 1
        HCSpy_UpdateGui()
      end 
    end
end

function HCSpy_List()
	pPrint("People using HealComm:")	
	for i=1, listmembers - 1 do	
		pPrint(i..". "..list[i])		
  end	
end

function HCSpy_Reset()
  list = {}
  versionTable = {}
  listmembers = 1  
  for index = 1, #HCSpyPlayerListFontstring do
    HCSpyPlayerListFontstring[index]:SetText("")
  end
  pPrint("HCSpy list has been reset.")
end

function HCSpy_TestButton()
  HCSpy_UpdateGui()
  pPrint("HCSpy Test button")
end

function pPrint(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function HCSpy_ToggleUiWindow()
    if HCSpyUiWindow:IsVisible() then
        HCSpyUiWindow:Hide()
    else
        HCSpyUiWindow:Show()
        HCSpy_UpdateGui()
    end
end

function HCSpy_GetClassClolor(class)
    if class == "WARLOCK"  then
      return 0.58, 0.51, 0.79,1
    elseif class == "DRUID"  then
      return 1.00, 0.49, 0.04,1
    elseif class == "ROGUE"  then
      return 1.00, 0.96, 0.41,1
    elseif class == "HUNTER"  then
      return 0.67, 0.83, 0.45,1
    elseif class == "MAGE"  then
      return 0.41, 0.80, 0.94,1
    elseif class == "SHAMAN"  then
      return 0.00, 0.44, 0.87,1
    elseif class == "PRIEST"  then
      return 1.00, 1.00, 1.00,1
    elseif class == "PALADIN"  then
      return 0.96, 0.55, 0.73,1
    elseif class == "WARRIOR"  then
      return 0.78, 0.61, 0.43,1
    end
  end

-- local frameEvent = CreateFrame("Frame")
-- frameEvent:this:RegisterEvent("CHAT_MSG_CHANNEL")
-- frameEvent:this:RegisterEvent("CHAT_MSG_WHISPER")
-- frameEvent:this:RegisterEvent("CHAT_MSG_SAY")
-- frameEvent:this:RegisterEvent("CHAT_MSG_YELL")
-- frameEvent:SetScript("OnEvent", eventHandler)
