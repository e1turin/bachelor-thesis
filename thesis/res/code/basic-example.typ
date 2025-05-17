```kotlin
fun CounterChiselModel.tick() {
    clock = 1
    eval()
    clock = 0
    eval()
}

fun CounterChiselModel.init() {
    reset = 1
    for (i in 1..7) tick()
    reset = 0
}

fun main() {
    Arena.ofConfined().use { arena ->
        val counter = CounterChiselModel.instance(arena, "counterchisel")

        counter.init()

        for (i in 1..10) { 
            counter.tick()
        }

        val result = counter.count.toInt()

        assert(result == 10)
    }
}
```
