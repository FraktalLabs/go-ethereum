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
