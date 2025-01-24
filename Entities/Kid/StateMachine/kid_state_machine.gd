extends Node

enum KidStateEnum {
    STAND,
    WALK,
    ITEM,
    GO_TO_ITEM,
    GO_TO_SCENERY
}

var states = {
    KidStateEnum.STAND: KidStandState.new(),
    KidStateEnum.WALK: KidWalkState.new(),
    KidStateEnum.ITEM: KidItemState.new(),
    KidStateEnum.GO_TO_ITEM: KidGoToItemState.new(),
    KidStateEnum.GO_TO_SCENERY: KidGoToSceneryState.new(),
}

func get_current(player: Kid) -> Object:
   return states[player.current_enum] if player.current_enum != null else null

func change_state(player: Kid, state: KidStateEnum, delta = null):
   if delta != null:
       change_state(player, state)
       get_current(player)._process(player, delta)
       return
       
   player.current_enum = state
   get_current(player).enter(player)
