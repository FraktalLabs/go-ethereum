package vm

//TODO: Use references where possible
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
  //TODO: Do I need to store / deep copy any call info?
  Coroutine []*CallInfo
}

func NewLocalEvmCoroutine(pc uint64, callInfos []*CallInfo) EVMCoroutine {
  // TODO !!
  // for _, callInfo := range callInfos {
  //   newStack := deepCopyStack(callInfo.Scope.Stack)
  //   // TODO: ?? newMemory := deepCopyMemory(callInfo.Scope.Memory)
  //   // Copy Coroutines, Channels, ...?
  //   callInfo.Scope.Stack = newStack
  // }
  //callInfos[len(callInfos)-1].PC = &pc

  newCallInfos := make([]*CallInfo, len(callInfos))
  //copy(newCallInfos, callInfos)
  for id, callInfo := range callInfos {
    newPc := *callInfo.PC
    newStack := deepCopyStack(callInfo.Scope.Stack)
    //newInput := make([]byte, len(callInfo.Input))
    //copy(newInput, callInfo.Input)
    newScopeContext := ScopeContext{callInfo.Scope.Memory, newStack, callInfo.Scope.Contract, callInfo.Scope.CoroutineQueue, callInfo.Scope.Channels}
    newCallInfos[id] = &CallInfo{callInfo.Caller, callInfo.Address, callInfo.Input, callInfo.CallType, callInfo.Snapshot, &newScopeContext, &newPc}
  }
  newCallInfos[len(newCallInfos)-1].PC = &pc

  return EVMCoroutine{newCallInfos}
}
