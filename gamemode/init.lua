AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerInitialSpawn( ply )
    ply:SetTeam( 1 ) --Add the player to Non-Combatants
end

function GM:PlayerLoadout( ply )
    
    if ply:Team() == 1 then
        ply:Give( "weapon_physcannon" )
    end
 
end