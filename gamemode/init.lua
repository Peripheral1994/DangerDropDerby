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

function DDD_GenerateWeapon()

  local baseWeaponTypes = {"Pistol ", "SMG ", "Rifle ", "Sniper ", "Grenade "}
  local superWeaponModifiers = {"Incendiary ", "Acidic ", "Venomous ", "Forceful "}
  local subWeaponModifiers = {"of Firepower", "of Firing Speed", "of Ammo Capacity"}

  --Determining Rarity of Weapon
  local weaponRarity = math.random(1, 100)
  local perfectCount = 1
  if weaponRarity <= 80 then
    weaponRarity = ""
  elseif weaponRarity <= 90 then
    weaponRarity = "Rare "
  elseif weaponRarity <= 95 then
    weaponRarity = "Mystic "
  elseif weaponRarity <= 98 then
    weaponRarity = "Ultimate "
  elseif weaponRarity == 99 then
    weaponRarity = "Perfect "
  else
    weaponRarity = "Perfect "
    while math.random(1, 100) == 100 do
      perfectCount = perfectCount + 1
      weaponRarity = perfectCount .. "x Perfect " 
    end
  end

  Entity( 1 ):PrintMessage( HUD_PRINTTALK,
    weaponRarity .. 
    superWeaponModifiers[math.random(#superWeaponModifiers)] .. 
    baseWeaponTypes[math.random(#baseWeaponTypes)] .. 
    subWeaponModifiers[math.random(#subWeaponModifiers)] ) --Temporary Printing for Showing Generated Weapons

end
concommand.Add("ddd_generateweapon", DDD_GenerateWeapon)