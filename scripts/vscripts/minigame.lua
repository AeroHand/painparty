--n is a index int to locate the gamemode
abset={}
--游戏1 数学竞赛
abset[1]={}
--游戏2
abset[2]={}
gamemode={
	[1]=function ()
      --数学测验
      print("begin math test")


    end,
    [2]=function ()
    	
    end
}



function gameinit(n)
    --给玩家特定技能
    giveability(abset[n])
    --传送玩家到特定区域
    teleport(n)
    gamemode[n]()
end	

function gameend(n)
    --去除英雄技能
    killallability()  
    --传送回去
    teleback()
end