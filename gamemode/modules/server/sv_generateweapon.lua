local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:TransmitWeapon( weapon )

  net.Start("ddd_sendnewweapon")
    net.WriteString( weapon )
  net.Send( self )

end

function DDD_GenerateWeapon( ply )

  local weapRarity = DDD_DetermineRarity()
  local generatedWeapon = DDD_DetermineWeapon(weapRarity)
  
  ply:TransmitWeapon( weapRarity .. generatedWeapon )

end
concommand.Add("ddd_generateweapon", DDD_GenerateWeapon) --Make Console Command admin-only later.

function DDD_DetermineRarity()

  local rarity = math.random(1, 100)
  local perfectCount = 1

  if rarity <= 80 then
    rarity = ""
  elseif rarity <= 90 then
    rarity = "Rare "
  elseif rarity <= 95 then
    rarity = "Mystic "
  elseif rarity <= 98 then
    rarity = "Ultimate "
  elseif rarity == 99 then
    rarity = "Perfect "
  else
    rarity = "Perfect "
    while math.random(1, 100) == 100 do
      perfectCount = perfectCount + 1
      rarity = perfectCount .. "x Perfect " 
    end
  end

  return rarity

end


function DDD_DetermineWeapon(rarity)

  local baseWeaponTypes = {"Pistol ", "SMG ", "Rifle ", "Sniper ", "Grenade ", "Crowbar "}

  local superMods = DDD_DetermineSuperMods(rarity)
  local subMods = DDD_DetermineSubMods(rarity)

  return superMods .. baseWeaponTypes[math.random(#baseWeaponTypes)] .. subMods

end


function DDD_DetermineSuperMods(rarity)

  local superWeaponModifiers = {"Incendiary ", "Acidic ", "Venomous ", "Forceful ", "Blinding ", "Slowing "}
  local superMods = ""

  if rarity == "" then
    -- One roll for a Super
    if math.random(1, 3) == 3 then
      superMods = superMods .. superWeaponModifiers[math.random(#superWeaponModifiers)]
    end

  elseif rarity == "Rare " then
    -- Two rolls for Supers
    if math.random(1, 3) == 3 then
      superMods = superMods .. superWeaponModifiers[math.random(#superWeaponModifiers)]
    end

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == superMods do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      superMods = superMods .. currentMod
    end

  elseif rarity == "Mystic " then
    -- One guaranteed Super, one roll
    superMods = superMods .. superWeaponModifiers[math.random(#superWeaponModifiers)]

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == superMods do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      superMods = superMods .. currentMod
    end

  elseif rarity == "Ultimate " then
    -- One guaranteed Super, two rolls

    local firstMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
    local secondMod = ""

    superMods = firstMod

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == superMods do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      secondMod = currentMod
      superMods = superMods .. currentMod     
    end

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == firstMod or currentMod == secondMod  do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      superMods = superMods .. currentMod
    end

  else
    -- For all Perfects, two guaranteed supers and two rolls
    local firstMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
    local secondMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
    local thirdMod = ""

    while secondMod == firstMod do
      secondMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
    end

    superMods = superMods .. firstMod .. secondMod

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == firstMod or currentMod == secondMod do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      thirdMod = currentMod
      superMods = superMods .. currentMod
    end

    if math.random(1, 3) == 3 then
      local currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      -- Avoid getting duplicate mods (Incendiary Incendiary SMG)
      while currentMod == firstMod or currentMod == secondMod or currentMod == thirdMod do
        currentMod = superWeaponModifiers[math.random(#superWeaponModifiers)]
      end

      superMods = superMods .. currentMod
    end

  end

  return superMods

end  


function DDD_DetermineSubMods(rarity)

  local subWeaponModifiers = {"Damage", "Firing Speed", "Ammo Capacity", "Recoil Reduction", "Armor"}
  local subMods = ""

  if rarity == "" then
    -- One roll for a sub
    if math.random(1, 3) == 3 then
      subMods = "of " .. subWeaponModifiers[math.random(#subWeaponModifiers)]
    end

  elseif rarity == "Rare " then
    -- One sub
    subMods = "of " .. subWeaponModifiers[math.random(#subWeaponModifiers)]

  elseif rarity == "Mystic " then
    -- One guaranteed sub, one roll
    subMods = "of " .. subWeaponModifiers[math.random(#subWeaponModifiers)]

    if math.random(1, 3) == 3 then
      local currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      -- Avoid getting duplicate mods
      while "of " .. currentMod == subMods do
        currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      end

      if subMods == "" then
        subMods = "of " .. currentMod
      else
        subMods = subMods .. " and " .. currentMod
      end

    end

  else
    -- For Ultimate and Perfects, one guaranteed sub and two rolls

    local firstMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
    local secondMod = ""

    subMods = "of " .. firstMod

    if math.random(1, 3) == 3 then
      local currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      -- Avoid getting duplicate mods
      while "of " .. currentMod == subMods do
        currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      end

      secondMod = currentMod
      subMods = subMods .. " and " .. currentMod

    end

    if math.random(1, 3) == 3 then
      local currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      -- Avoid getting duplicate mods
      while currentMod == firstMod or currentMod == secondMod do
        currentMod = subWeaponModifiers[math.random(#subWeaponModifiers)]
      end

      subMods = subMods .. " and " .. currentMod

    end

  end

  return subMods

end  
