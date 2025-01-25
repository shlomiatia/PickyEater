extends Node

enum MomStateEnum {
    STAND,
    WALK,
    WASH,
    DUCK
}

var states = {
    MomStateEnum.STAND: MomStandState.new(),
    MomStateEnum.WALK: MomWalkState.new(),
    MomStateEnum.WASH: MomWashState.new(),
    MomStateEnum.DUCK: MomDuckState.new(),
}

func get_current(mom: Mom) -> Object:
   return states[mom.current_enum] if mom.current_enum != null else null

func change_state(mom: Mom, state: MomStateEnum, delta = null):
   if delta != null:
       change_state(mom, state)
       get_current(mom)._process(mom, delta)
       return
       
   mom.current_enum = state
   get_current(mom).enter(mom)
