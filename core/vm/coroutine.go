package vm

//TODO: Use references where possible
type Coroutine struct {
  PC uint64
  Stack Stack
}

func NewCoroutine(pc uint64, stack Stack) Coroutine {
  newStack := deepCopyStack(&stack)
  return Coroutine{pc, *newStack}
}

type EVMCoroutine struct {
  //TODO: Do I need to store / deep copy any call info?
  Coroutine []*CallInfo
}
