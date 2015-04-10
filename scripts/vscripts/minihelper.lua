function killallability()
	for i=0,9 do
		if yx[i] then
		  for j=0,15 do
              local temp1=yx[i]:GetAbilityByIndex(j) --获取技能实体
        	  if temp1 then
        	      temp1:RemoveSelf()
              end
          end
        end
    end
end        

function giveability(miniabilitytable)
   if miniabilitytable then
	  for i=0,9 do
	    	for j=1,#miniabilitytable do
                yx[i]:AddAbility(miniabilitytable[j])
            end    
      end    
   end   
end

function teleport(n)
	print("game"..tostring(n))
	local tt=Entities:FindByName(nil, "game"..tostring(n))
	local ttt=tt:GetAbsOrigin()
    for i=0,9 do
    	if yx[i] then
           print("start teleport hero",i)
    	   yx[i]:SetAbsOrigin(ttt+RandomVector(150))
        end
    end 	 
end	

function teleback()
	local ttt=(Entities:FindByName(nil, "origin")):GetAbsOrigin()
    for i=0,9 do
    	if yx[i] then
    	  yx[i]:SetAbsOrigin(ttt+RandomVector(150))
        end
    end 	 
end	

