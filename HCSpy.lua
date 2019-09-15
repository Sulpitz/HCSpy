local guildRoster = {}
local GuildRosterFontStringButton = {}
local GuildRosterFontStringPlayername = {}
local GuildRosterFontStringPlayerlevel = {}
local GuildRosterFontStringPlayerrank = {}
local GuildRosterFontStringPlayerzone = {}
local GuildRosterFontStringPlayernote = {}
local GuildRosterFontStringPlayerofficernote = {}
local GuildRosterFontStringPlayeronline = {}
local GuildRosterFontStringPlayerstatus = {}
local GuildRosterFontStringPlayerclassFileName = {}
local MaxFrames = 0



local list = {} -- list of people using HCSpy
local listmembers = 1






SLASH_HCSPY1 = '/hcspy'
function SlashCmdList.HCSPY(msg, editbox) 
  if msg == "reset" then
    pPrint("HCSpy is now reset!")
    HCSpy_Reset()
  elseif msg == "list" then
    HCSpy_List()
  else
    pPrint("Unknown HCSpy Command")
  end
end



function GuildInspector_BuildGuildRoster()
    guildRoster = {}
    numGuildMembers = GetNumGuildMembers()
    index = 1
    for i = 1, numGuildMembers do
        name, rank, _, level, _, zone, note, officernote, online, status, classFileName = GetGuildRosterInfo(i)
        if online or showOffline  then
            guildRoster[index] = {}
            guildRoster[index]["name"] = string.match(name, "[^-]+") --%w+
            guildRoster[index]["rank"] = rank
            guildRoster[index]["level"] = level
            guildRoster[index]["zone"] = zone
            guildRoster[index]["note"] = note
            guildRoster[index]["officernote"] = officernote
            guildRoster[index]["online"] = online
            guildRoster[index]["status"] = status
            guildRoster[index]["classFileName"] = classFileName
            index = index + 1
        end
    end
end

function GuildInspector_UpdateGuildRoster()
    GuildInspector_BuildGuildRoster()
    for index, v in pairs(guildRoster) do
            -- create frame if nessesarry
        if GuildRosterFontStringButton[index] == nil then
            GuildRosterFontStringButton[index] = CreateFrame('Button', nil, GuildInspectorUiWindow)
            GuildRosterFontStringButton[index]:SetPoint('TOPLEFT', GuildInspectorUiWindow, 'TOPLEFT', 3, (12 - 15 * index)            )
            GuildRosterFontStringButton[index]:SetWidth(GuildInspectorUiWindow:GetWidth()- 20)
            GuildRosterFontStringButton[index]:SetHeight(15)
            --GuildRosterFontStringButton[index]:SetBackdrop({bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background'})
            GuildRosterFontStringButton[index]:SetScript('OnClick', GuildInspector_OnClickGuildMemdber)
            --GuildRosterFontStringButton[index]:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE, MONOCHROME")
            GuildRosterFontStringButton[index]:SetText("myestttext")
            GuildRosterFontStringButton[index]:SetID(index)

            --Level
            GuildRosterFontStringPlayerlevel[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayerlevel[index]:SetText(v.level)
            GuildRosterFontStringPlayerlevel[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 5, -2)
            --name
            GuildRosterFontStringPlayername[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayername[index]:SetText(v.name)
            GuildRosterFontStringPlayername[index]:SetTextColor(GuildInspector_GetClassClolor(v.classFileName))
            GuildRosterFontStringPlayername[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 30, -2)
            --zone
            GuildRosterFontStringPlayerzone[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayerzone[index]:SetText(v.zone)
            GuildRosterFontStringPlayerzone[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 120, -2)
            --note
            GuildRosterFontStringPlayernote[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayernote[index]:SetText(v.note)
            GuildRosterFontStringPlayernote[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 250, -2)
            --officernote
            GuildRosterFontStringPlayerofficernote[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayerofficernote[index]:SetText(v.officernote)
            GuildRosterFontStringPlayerofficernote[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 460, -2) --längemax 220 
            --rank
            GuildRosterFontStringPlayerrank[index] = GuildInspectorUiWindow:CreateFontString(nil, nil, "GuildInspectorUiWindowListNameFontstring")
            GuildRosterFontStringPlayerrank[index]:SetText(v.rank)
            GuildRosterFontStringPlayerrank[index]:SetPoint('TOPLEFT', GuildRosterFontStringButton[index], 'TOPLEFT', 680, -2)
        else
            GuildRosterFontStringPlayerlevel[index]:SetText(v.level)
            GuildRosterFontStringPlayername[index]:SetText(v.name)
            GuildRosterFontStringPlayername[index]:SetTextColor(GuildInspector_GetClassClolor(v.classFileName))
            GuildRosterFontStringPlayerzone[index]:SetText(v.zone)
            GuildRosterFontStringPlayernote[index]:SetText(v.note)
            GuildRosterFontStringPlayerofficernote[index]:SetText(v.officernote)
            GuildRosterFontStringPlayerrank[index]:SetText(v.rank)      
        end
    end
end

function GuildInspector_OnClickGuildMemdber()
    pPrint("clicked on Guild memeber")
end

function HCSpy_OnLoad()
  HCSpy:RegisterEvent('CHAT_MSG_ADDON')
end

function HCSpy_OnEvent(self, event, ...)
  arg1, arg2, arg3, arg4, arg5 = ...
  arg4 = string.match(arg4, "[^-]+")
  pPrint("arg1: " .. arg1 .. " | arg4 " .. arg4)
    if event == "CHAT_MSG_ADDON" then
      if arg1 == "LCHC10" then
        pPrint("heal vrom " .. arg4)
        for i=1, listmembers do
          if list[i] == arg4 then return end
        end     
        list[listmembers] = arg4
        listmembers = listmembers + 1
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
  listmembers = 1
  pPrint("HCSpy list has been reset.")
end

function HCSpy_TestButton()
    pPrint("HCSpy Test button")
end

function pPrint(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function GuildInspector_ToggleUiWindow()
    if GuildInspectorUiWindow:IsVisible() then
        GuildInspectorUiWindow:Hide()
    else
        GuildInspectorUiWindow:Show()
        GuildInspector_UpdateGuildRoster()
    end
end

function GuildInspector_GetClassClolor(class)
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
