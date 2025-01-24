extends Node

enum PlayerStateEnum {
    STAND,
    WALK,
}

var states = {
   PlayerStateEnum.STAND: KidStandState.new(),
   PlayerStateEnum.WALK: KidWalkState.new(),
}

func get_current(player: Kid) -> Object:
   return states[player.current_enum] if player.current_enum != null else null

func change_state(player: Kid, state: PlayerStateEnum, delta = null):
   if delta != null:
       change_state(player, state)
       get_current(player)._process(player, delta)
       return
       
   player.current_enum = state
   get_current(player).enter(player)
