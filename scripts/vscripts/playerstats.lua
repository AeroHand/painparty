
yx={}

lwang={0,0,0}
dwang={0,0,0}



if playerstats == nil then
	playerstats = class({})
end
PlayerS = {} --store info for players

function playerstats:init()

 -- SendToConsole("dota_sf_hud_inventory 0")
 -- SendToConsole("dota_render_crop_height 0")
   print("start init ps")
   for i=0,9 do
     PlayerS[i]={}
     PlayerS[i][1]={} --储存玩家建造的兵
   end

   bazi={}
   for i=1,2 do
     --建立靶子
     local temp=Entities:FindByName(nil,"chose"..tostring(i))
     local yoyo=temp:GetAbsOrigin()               
     bazi[i]=CreateUnitByName("bazi", yoyo, false, nil, nil, DOTA_TEAM_NEUTRALS)
     bazi[i]:SetContext("name",tostring(i),0)
   end

end



function sendinfotoui() 
  local p={}
  local pp={}
  local i=0

  for i=0,8,1 do
    if not(i==4) then
      p[i]=tostring(PlayerS[i][1]).."       "..tostring(PlayerS[i][2]).."         "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."          "..tostring(PlayerS[i][9]).."           "..tostring(PlayerS[i][5]).."          "..tostring(PlayerS[i][12]).."           "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
      --pp[i]=tostring(PlayerS[i][1]).."           "..tostring(PlayerS[i][2]).."            "..tostring(PlayerS[i][7]).."/"..tostring(PlayerS[i][8]).."             "..tostring(PlayerS[i][3]).."/"..tostring(PlayerS[i][4])
    end
  end



  FireGameEvent('ui_update', {player1=p[0],player2=p[1],player3=p[2],player4=p[3],player5=p[5],player6=p[6],player7=p[7],player8=p[8]})
  FireGameEvent('p_update',{
    pp1g=tostring(PlayerS[0][1]),
    pp1e=tostring(PlayerS[0][2]),
    pp1r=tostring(PlayerS[0][3]).."/"..tostring(PlayerS[0][4]),
    pp1k=tostring(PlayerS[0][7]).."/"..tostring(PlayerS[0][8]),

    pp2g=tostring(PlayerS[1][1]),
    pp2e=tostring(PlayerS[1][2]),
    pp2r=tostring(PlayerS[1][3]).."/"..tostring(PlayerS[1][4]),
    pp2k=tostring(PlayerS[1][7]).."/"..tostring(PlayerS[1][8]),

    pp3g=tostring(PlayerS[2][1]),
    pp3e=tostring(PlayerS[2][2]),
    pp3r=tostring(PlayerS[2][3]).."/"..tostring(PlayerS[2][4]),
    pp3k=tostring(PlayerS[2][7]).."/"..tostring(PlayerS[2][8]),

    pp4g=tostring(PlayerS[3][1]),
    pp4e=tostring(PlayerS[3][2]),
    pp4r=tostring(PlayerS[3][3]).."/"..tostring(PlayerS[3][4]),
    pp4k=tostring(PlayerS[3][7]).."/"..tostring(PlayerS[3][8]),

    pp5g=tostring(PlayerS[5][1]),
    pp5e=tostring(PlayerS[5][2]),
    pp5r=tostring(PlayerS[5][3]).."/"..tostring(PlayerS[5][4]),
    pp5k=tostring(PlayerS[5][7]).."/"..tostring(PlayerS[5][8]),

    pp6g=tostring(PlayerS[6][1]),
    pp6e=tostring(PlayerS[6][2]),
    pp6r=tostring(PlayerS[6][3]).."/"..tostring(PlayerS[6][4]),
    pp6k=tostring(PlayerS[6][7]).."/"..tostring(PlayerS[6][8]),

    pp7g=tostring(PlayerS[7][1]),
    pp7e=tostring(PlayerS[7][2]),
    pp7r=tostring(PlayerS[7][3]).."/"..tostring(PlayerS[7][4]),
    pp7k=tostring(PlayerS[7][7]).."/"..tostring(PlayerS[7][8]),

    pp8g=tostring(PlayerS[8][1]),
    pp8e=tostring(PlayerS[8][2]),
    pp8r=tostring(PlayerS[8][3]).."/"..tostring(PlayerS[8][4]),
    pp8k=tostring(PlayerS[8][7]).."/"..tostring(PlayerS[8][8])
    })

end

