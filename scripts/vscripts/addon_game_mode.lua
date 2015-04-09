-- Generated from template
require('timers')
require('physics')
require('FlashUtil')
require('buildinghelper')
require('abilities')
require('playerstats')
require('util')
require('minihelper')
require('minigame')

PrecacheResource("particle_folder", "particles/buildinghelper", context)
hulage=0
if painparty == nil then
	painparty = class({})
end

yx={}
function PrecacheEveryThingFromKV( context )
	local kv_files = {"scripts/npc/npc_units_custom.txt","scripts/npc/npc_abilities_custom.txt","scripts/npc/npc_heroes_custom.txt","scripts/npc/npc_abilities_override.txt","npc_items_custom.txt"}
	for _, kv in pairs(kv_files) do
		local kvs = LoadKeyValues(kv)
		if kvs then
			print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
			PrecacheEverythingFromTable( context, kvs)
		end
	end
end
function PrecacheEverythingFromTable( context, kvtable)
	for key, value in pairs(kvtable) do
		if type(value) == "table" then
			PrecacheEverythingFromTable( context, value )
		else
			if string.find(value, "vpcf") then
				PrecacheResource( "particle",  value, context)
				print("PRECACHE PARTICLE RESOURCE", value)
			end
			if string.find(value, "vmdl") then 	
				PrecacheResource( "model",  value, context)
				print("PRECACHE MODEL RESOURCE", value)
			end
			if string.find(value, "vsndevts") then
				PrecacheResource( "soundfile",  value, context)
				print("PRECACHE SOUND RESOURCE", value)
			end
		end
	end

   
end
function Precache( context )
    print("BEGIN TO PRECACHE RESOURCE")
	local time = GameRules:GetGameTime()
	PrecacheEveryThingFromKV( context )
	PrecacheResource("particle_folder", "particles/buildinghelper", context)
	PrecacheUnitByNameSync("npc_dota_hero_tinker", context)
	time = time - GameRules:GetGameTime()
	print("DONE PRECACHEING IN:"..tostring(time).."Seconds")
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = painparty()
	GameRules.AddonTemplate:InitGameMode()
end

function painparty:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )

	BuildingHelper:Init()
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(painparty, "OnNPCSpawned"), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(painparty, 'OnEntityKilled'), self)
    ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(painparty, 'OnAbilityUsed'), self)
end

-- Evaluate the state of the game
function painparty:OnThink()
      if hulage==0 then
        playerstats:init()
        hulage=1
      end
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function painparty:OnNPCSpawned( keys )

   local unit =  EntIndexToHScript(keys.entindex)
   if unit:IsHero() then                      --如果是英雄
   	  print("...is hero...")
      unit:SetAbilityPoints(0)                --取消技能点
      local j=0
      
      for j = 0,15,1 do
        local temp1=unit:GetAbilityByIndex(j) --获取技能实体
        if temp1 then
          temp1:SetLevel(1)                     --设置技能等级
        end
      end
      

      unit:AddNewModifier(unit, nil, "modifier_invulnerable", nil)  --农民无敌

      local temp=unit:GetPlayerOwnerID()
      
      print("hero number",temp)
      yx[temp]=unit;
     --local pid=unit:GetPlayerID()             --获取玩家id
     
     --PlayerS[pid][18]:SetOwner(unit)          --设置人口拥有者
    end

end

function painparty:OnEntityKilled( keys )
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    local temp=killedUnit:GetContext("name")
    if temp then
        local num=tonumber(temp)
        gameinit(num)
    end 	
end

function painparty:OnAbilityUsed(keys)
	--print('[SAMPLERTS] AbilityUsed')
	--PrintTable(keys)

	local player = EntIndexToHScript(keys.PlayerID)
	local abilityname = keys.abilityname

	-- Cancel the ghost if the player casts another active ability.
	-- Start of BH Snippet:
	if player.cursorStream ~= nil then
		if not (string.len(abilityname) > 14 and string.sub(abilityname,1,14) == "move_to_point_") then
			if not DontCancelBuildingGhostAbils[abilityname] then
				player:CancelGhost()
			else
				print(abilityname .. " did not cancel building ghost.")
			end
		end
	end
	-- End of BH Snippet
end