```kotlin
interface ICounterDevice : Device {
    fun reset()
    fun click()
    val countValue: Int
}

class CounterDevice(context: Context, meta: Meta, arena: Arena) :
    DeviceBySpec<ICounterDevice>(Spec, context, meta), ICounterDevice {

    val model: CounterChiselModel = CounterChiselModel.instance(arena, "counterchisel")

    override fun click() {
        model.clock = 1
        model.eval()
        model.clock = 0
        model.eval()
    }

    override fun reset() {
        model.reset = 1
        model.click()
        model.reset = 0
    }

    override val countValue: Int get() = model.count.toInt()

    companion object Spec : DeviceSpec<ICounterDevice>(), FfmMetaFactory<CounterDevice> {
        val count by numberProperty { countValue }
        val reset by unitAction { reset() }
        val click by unitAction { click() }

        override fun factory(arena: Arena) = Factory { context, meta ->
            CounterDevice(context, meta, arena)
        }
    }
}

interface FfmMetaFactory<T> {
    fun factory(arena: Arena): Factory<T>
}

class CounterDeviceController(arena: Arena): ContextAware {
    override val context = Context(name = "Demo") {
        plugin(DeviceManager)
    }
    val deviceManager = context.request(DeviceManager)
    val counter by deviceManager.installing(CounterDevice.factory(arena))
}

fun main() {
    Arena.ofShared().use { arena ->
        val controller = CounterDeviceController(arena)

        application {
            ControlPanel(controller)
        }
    }
}

@Composable
fun ControlPanel(controller: CounterDeviceController) {
    val controller = remember { controller }

    Window(/* ... */) {
        controller.Panel()
    }
}

@Composable
fun Screen(output: Byte) {
    Text(output.toString())
}

@Composable
fun CounterDeviceController.Panel() {
    var count by remember { mutableStateOf(counter.countValue) }
    var auto by remember { mutableStateOf(false) }

    LaunchedEffect(auto) {
        while (auto) {
            counter.click()
            count = counter.countValue
            delay(1000)
        }
    }

    Column {
        Box { Screen(count.toByte()) }
        Row {
            Button(onClick = { auto = !auto }) {
                Text(if (auto) "1s" else "off")
            }
            Button(onClick = { 
              counter.click()
              count = counter.countValue
            }) {
              Text("click")
            }
            Button(onClick = {
              counter.reset()
              count = counter.countValue
            }) {
              Text("reset")
            }
        }
    }
}
```
