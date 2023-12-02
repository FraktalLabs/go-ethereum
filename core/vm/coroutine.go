package vm

type Coroutine struct {
  PC uint64
  Stack Stack
}

// TODO: Yield can store stack but spawn needs to deep copy stack
func NewCoroutine(pc uint64, stack Stack) Coroutine {
  newStack := deepCopyStack(&stack)
  return Coroutine{pc, *newStack}
}

type EVMCoroutine struct {
  Coroutine []*CallInfo
}

func NewLocalEvmCoroutine(pc uint64, callInfos []*CallInfo) EVMCoroutine {
  newCallInfos := make([]*CallInfo, len(callInfos))
  for id, callInfo := range callInfos {
    newPc := *callInfo.PC
    newStack := deepCopyStack(callInfo.Scope.Stack)
    newScopeContext := ScopeContext{callInfo.Scope.Memory, newStack, callInfo.Scope.Contract, callInfo.Scope.CoroutineQueue, callInfo.Scope.Channels}
    newCallInfos[id] = &CallInfo{callInfo.Caller, callInfo.Address, callInfo.Input, callInfo.CallType, callInfo.Snapshot, &newScopeContext, &newPc}
  }
  newCallInfos[len(newCallInfos)-1].PC = &pc

  return EVMCoroutine{newCallInfos}
}
