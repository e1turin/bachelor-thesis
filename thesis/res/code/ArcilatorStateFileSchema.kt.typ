```kotlin
public typealias StateFile = List<ModelInfo>

/**
 * from C++:
 *   struct ModelInfo {
 *      std::string name;
 *      size_t numStateBytes;
 *      llvm::SmallVector<StateInfo> states;
 *      // ...
 *    };
 */
public data class ModelInfo(
    val name: String,
    val numStateBytes: ULong,
    val initialFnSym: String,
    val finalFnSym: String,
    val states: List<StateInfo>
)

/**
 * from C++ :
 *   struct StateInfo {
 *     enum Type { Input, Output, Register, Memory, Wire } type;
 *     std::string name;
 *     unsigned offset;
 *     unsigned numBits;
 *     unsigned memoryStride = 0;
 *     unsigned memoryDepth = 0;
 *   };
 */
public data class StateInfo(
    val type: StateProjectionType,
    val name: String,
    val offset: UInt,
    val numBits: UInt,
    val memoryStrides: UInt = 0u,
    val memoryDepth: UInt = 0u,
)
```