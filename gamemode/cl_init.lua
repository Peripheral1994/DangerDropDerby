include( "shared.lua" )

net.Receive( "ddd_sendnewweapon", function( length )
  LocalPlayer():PrintMessage( HUD_PRINTTALK, net.ReadString() )
end)