AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

if !file.Exists( "DangerDropDerby", "DATA" ) then
  file.CreateDir( "DangerDropDerby" )
end

if !file.Exists( "DangerDropDerby/Saves", "DATA" ) then
  file.CreateDir( "DangerDropDerby/Saves" )
end

local PlayerMeta = FindMetaTable("Player")

local files, dirs = file.Find("DangerDropDerby/gamemode/modules/server/*.lua", "LUA")
for k, v in pairs( files ) do
  include( "DangerDropDerby/gamemode/modules/server/" .. v )
end

function PlayerMeta:SavePlayer()

  local playerTable = {}

  tbl.date = os.date("%A %m/%d/%y")

  file.Write( "DangerDropDerby/Saves" ..self:SteamID64().. ".txt", util.TableToJSON( playerTable, true ) )

end

function Initialize_DDD()

  -- Setup all needed network strings.
  util.AddNetworkString("ddd_sendnewweapon")

end
hook.Add("Initialize", "initializing", Initialize_DDD)

function GM:PlayerInitialSpawn( ply )
  ply:SetTeam( 1 ) --Add the player to Non-Combatants
end

function GM:PlayerLoadout( ply )
    
  if ply:Team() == 1 then
    ply:Give( "weapon_physcannon" ) -- Temporary measure to show that proper team is joined.
  end
 
end


