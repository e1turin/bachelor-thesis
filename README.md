# Бакалаврский диплом

<!--toc:start-->
- [Бакалаврский диплом](#бакалаврский-диплом)
  - [Ссылки](#ссылки)
    - [Controls.kt:](#controlskt)
    - [CIRCT](#circt)
      - [Arcilator](#arcilator)
    - [CHISEL](#chisel)
    - [Kotlin/Native](#kotlinnative)
    - [Прочее](#прочее)
    - [Название инструмента](#название-инструмента)
    - [Размышления](#размышления)
  - [Задание...](#задание)
    - [1. Основные вопросы, подлежащие разработке](#1-основные-вопросы-подлежащие-разработке)
      - [1.1. техническое задание:](#11-техническое-задание)
      - [1.2. исходные данные к работе:](#12-исходные-данные-к-работе)
      - [1.3. содержание работы:](#13-содержание-работы)
      - [1.4. цель:](#14-цель)
      - [1.5. задачи работы:](#15-задачи-работы)
      - [1.6. перечень подлежащих разработке вопросов:](#16-перечень-подлежащих-разработке-вопросов)
      - [1.7. рекомендуемые материалы и пособия для выполнения работы и т.д.:](#17-рекомендуемые-материалы-и-пособия-для-выполнения-работы-и-тд)
    - [2. Форма представления материалов ВКР](#2-форма-представления-материалов-вкр)
    - [3. Дата выдачи задания](#3-дата-выдачи-задания)
    - [4. Срок представления готовой ВКР](#4-срок-представления-готовой-вкр)
    - [5. Дополнительно](#5-дополнительно)
  - [Защита](#защита)
    - [Предзащита](#предзащита)
    - [Возможные вопросы](#возможные-вопросы)
<!--toc:end-->

<!-- тема: «Реализация модуль моделирования аппаратуры для SCADA-системы Controls.kt» -->
тема: «Реализация модуля моделирования аппаратуры для SCADA-систем»

## Ссылки

### Controls.kt: 

Центр научного программирования МФТИ 
- https://sciprog.center/projects/controls
  - docs: [device spec](https://git.sciprog.center/kscience/controls-kt/src/branch/master/docs/Device%20and%20DeviceSpec.md)
    - "Troisk nu-mass" experiment: https://www.inr.ru/~numass/
- https://git.sciprog.center/kscience/dataforge-core
- из telegram [@SciProgCentre](https://t.me/SciProgCentre):
  - про создание внутреннего формата представления ~VCD: https://t.me/SciProgCentre/24449
  - про задачу моделирования аппаартуры: https://t.me/SciProgCentre/26576
  - про Chisel: https://t.me/SciProgCentre/26604
- доклад про Controls-kt на JPoint. Тезис про моделирование приборов в системе:
  - https://youtu.be/KWt6wIgVyWQ?t=1504
- пока ничего на [youtrack issues](https://sciprog.center/youtrack/issues?q=%23Controls-kt)

#### Альтернативы

В лаборатории ВИТШ ИТМО используют:
- Modelsim
- продукты компаний: Xilinx, Intel, Amd, Gowin, Lattice
- Matlab Simulink

Сравнение: [COMPARISON_TABLE.md](./COMPARISON_TABLE.md)

AnyLogic

LabView

MathWorks: Mathlab & Simulink
- https://www.mathworks.com/company.html
- Mathlab
  - MATLAB for FPGA, ASIC, and SoC Development: https://www.mathworks.com/solutions/fpga-asic-soc-development.html
    - MATLAB for FPGA Prototyping: https://www.mathworks.com/solutions/fpga-asic-soc-development/prototyping.html
    - MATLAB for FPGA, ASIC, and SoC Production Design and Verification: https://www.mathworks.com/solutions/fpga-asic-soc-development/production-design-verification.html
    - Getting Started Using MATLAB and Simulink for FPGA, ASIC, and SoC Development: https://www.mathworks.com/solutions/fpga-asic-soc-development/resources.html
- Simulink

Amesim

ЦИТМ Экспонента
- Engee: https://start.engee.com/
  - хвалебные оды на хабре: https://habr.com/ru/companies/etmc_exponenta/articles/854554/

### CIRCT

CIRCT — Circuit IR Compilers and Tools

- https://circt.llvm.org/
  - Description: https://circt.llvm.org/docs/Charter/
- https://github.com/llvm/circt
  - Releases firtool: https://github.com/llvm/circt/releases — collection of llvm, mlir, circt tools
  - x86_64 only. So, on MacOS use: `arch -x86_64 <cmd>` if needed. And so MacOS x86_64 JDK (https://jdk.java.net/archive/).
- https://godbolt.org/noscript/circt
- Using CIRCT for FPGA Physical Design: https://capra.cs.cornell.edu/latte22/paper/10.pdf

Основан на MLIR и предлагает свои диалекты для описания различной логики аппаратуты: https://circt.llvm.org/docs/Dialects/
- hw: https://circt.llvm.org/docs/Dialects/HW/
  - Dialect Rationale: https://circt.llvm.org/docs/Dialects/HW/RationaleHW/
  - low documentation, so should see sources: https://github.com/llvm/circt/blob/main/lib/Dialect/HW/HWTypes.cpp
- arc: https://circt.llvm.org/docs/Dialects/Arc/
  - arc.sim — используется при симулировании работы прямо в MLIR (`@entry` для запуска в arcilator [¶](#arc-sim))
- sv: https://circt.llvm.org/docs/Dialects/SV/
  - Dialect Rationale: https://circt.llvm.org/docs/Dialects/SV/RationaleSV/
- ...


#### Arcilator

Arcilator — симулятор моделей на диалектах CIRCT (MLIR) (компилятор в llvm и/или исполнение этого кода) 

video [2023 LLVM Dev Mtg - Arcilator: Fast and cycle-accurate hardware simulation in CIRCT](https://youtu.be/iwJBlRUz6Vw)
- [slides](https://llvm.org/devmtg/2023-10/slides/techtalks/Erhart-Arcilator-FastAndCycleAccurateHardwareSimulationInCIRCT.pdf)

video [2024 EuroLLVM - Arcilator for ages five and up: flexible self-contained hardware simulation made..](https://youtu.be/lE7ynoMstQA) <a name="arc-sim"></a>
- [slides](https://llvm.org/devmtg/2024-04/slides/QuickTalks/Degioanni-Arcilator.pdf)
  - диалект немного устарел и теперь другой — в проекте ИПКН [¶](#ipkn-arc-sim)

slides: [Circuit IR for Compilers and Tools, Creating hardware for ML](https://hc34.hotchips.org/assets/program/tutorials/MLIR/HC2022.SiFive-MSFT.LenharthDemme.v1.pdf)

issues
- [[Arc] Introduce a Python simulation script generator for arcilator #7942](https://github.com/llvm/circt/issues/7942)

Тесты
- https://github.com/circt/arc-tests — тесты для различных проектов, например,
  rocket rv-chip исполняющий код из elf-файла
  - https://github.com/circt/arc-tests/blob/main/rocket/rocket-model-arc.cpp
    - uses https://github.com/llvm/circt/blob/main/tools/arcilator/arcilator-header-cpp.py
    - and https://github.com/llvm/circt/blob/main/tools/arcilator/arcilator-runtime.h

State file (`--state-file`) contains observable model states—attributes of object such as registers, wires, memory, etc in program: 
- JSON format: https://github.com/llvm/circt/blob/d675c243c04339563517de1717dacbe3aa8309d5/lib/Dialect/Arc/ModelInfo.cpp#L130C3-L171C6
  - uses values, setted here: https://github.com/llvm/circt/blob/d675c243c04339563517de1717dacbe3aa8309d5/lib/Dialect/Arc/ModelInfo.cpp#L67C5-L100C6
    - uses such data struct: https://github.com/llvm/circt/blob/d675c243c04339563517de1717dacbe3aa8309d5/include/circt/Dialect/Arc/ModelInfo.h#L25C1-L40C38
    - and Ops generated with TableGen: https://github.com/llvm/circt/blob/main/include/circt/Dialect/Arc/ArcOps.td
    - and StateType from another generated header: https://github.com/llvm/circt/blob/main/include/circt/Dialect/Arc/ArcTypes.td
- in object file, function always names in `<module name>_eval` format:
  - https://github.com/llvm/circt/blob/d675c243c04339563517de1717dacbe3aa8309d5/lib/Conversion/ArcToLLVM/LowerArcToLLVM.cpp#L53C1-L55C2
  - C++ Header generator relies on it: https://github.com/llvm/circt/blob/d675c243c04339563517de1717dacbe3aa8309d5/tools/arcilator/arcilator-header-cpp.py#L12C1-L16C41
- `initialFnSym` and `finalFnSym` defined with tablegen:
  - https://github.com/llvm/circt/blob/2afb3cd0644297a6f7b7c185130bc4fcc0d3cd91/include/circt/Dialect/Arc/ArcOps.td#L483C1-L495C2

ИПКН DevTools проект <a name="ipkn-arc-sim"></a>
- https://github.com/YAGRIT/risc-v/blob/dev/testbenches/regfile.mlir

ИСП РАН
- фаззинг OSS: https://gitlab.ispras.ru/mvg/mvg-oss/circt

### CHISEL

CHISEL —

Зависимость на 
- Firtool для генерации Verilog
- Verilator для симуляции Verilog

- https://www.chisel-lang.org/docs
- https://www.imm.dtu.dk/~masca/chisel-book.pdf
- Обзор Chisel для генерации сложных цифровых схем и сравнение с System Verilog:
  - https://youtu.be/d_vlVsoJ8vI

FIRRTL — Промежуточное представление для Chisel, теперь диалект CIRCT
- https://github.com/chipsalliance/firrtl
  - https://github.com/chipsalliance/firrtl-spec/blob/main/spec.md
- https://circt.llvm.org/docs/Dialects/FIRRTL/

### Kotlin/Native

Достаточно статически слинковаться с библиотекой. Нужно иметь C-header библиотеки и конфигурировать Konan `.def` файл. 

### Kotlin/JVM

#### Project Panama FFM API

Project Panama — https://openjdk.org/projects/panama/
- FFM API — Foreign Function & Memory API
  - Oracle Documentation of FFM API: https://docs.oracle.com/en/java/javase/21/core/foreign-function-and-memory-api.html
  - Настя Лисицкая — FFM API — ничего общего с радио — https://youtu.be/HiF7EjAtdZM
  - Linker API: https://github.com/openjdk/panama-foreign/blob/foreign-memaccess%2Babi/doc/panama_ffi.md
    - > Performance-wise, the reader might ask how efficient calling a foreign
      > function using a native method handle is; the answer is very. The JVM comes
      > with some special support for native method handles, so that, if a give
      > method handle is invoked many times (e.g, inside a hot loop), the JIT
      > compiler might decide to generate a snippet of assembly code required to
      > call the native function, and execute that directly. In most cases, invoking
      > native function this way is as efficient as doing so through JNI.
    - openjdk sources: 
      - impls https://github.com/openjdk/jdk/tree/master/src/java.base/share/classes/jdk/internal/foreign
      - ifaces https://github.com/openjdk/jdk/tree/master/src/java.base/share/classes/java/lang/foreign
        - uses `java.lang.invoke` API (отлично описывается в докладе https://youtu.be/DgshYDTpS9I)
- jextract — generate Java classes from C headers
  - samples: https://github.com/openjdk/jextract/tree/master/samples
- Native Memory Processor — pet project. Gen wrappers from annotations.
  - https://github.com/DigitalSmile/native-memory-processor

В свой черед, можно генерировать код во время компиляции с помощью плагина используещего Kotlin Poet.

- Kotlin Poet
  - generate Kotlin classes on compile time
    - kobweb (from Reddit descussion: https://www.reddit.com/r/Kotlin/comments/rgf136/dynamically_generated_class_during_compile_time/)
      - https://github.com/varabyte/kobweb/blob/8bf70e4f098dd56a143bdd7d745c95f6e91030c8/gradle-plugins/application/src/main/kotlin/com/varabyte/kobweb/gradle/application/templates/MainTemplate.kt#L11
      - https://github.com/varabyte/kobweb/blob/ee05c8eee7f53d3494fb02d8709c4fe914525272/gradle-plugins/application/src/main/kotlin/com/varabyte/kobweb/gradle/application/tasks/KobwebGenerateSiteTask.kt#L55

#### JNI

JNI - Java Native Interface
- Требуются обертки на C/C++ - нужны разработчики на этих языках,
- технология старая, начиная с ранних версий Java,
- и не поддается JIT оптимизации в отличии от того, как это делает FFM API.

Different samples of native interop
- https://github.com/whyoleg/kotlin-interop-playground/tree/main/c-interop
- https://github.com/whyoleg/ffi-kotlin

Knee -- seamlessly interop
- https://opensource.deepmedia.io/knee
- Только андроид?

### Прочее

ПИШ ИТМО: https://pish.itmo.ru/

ВИТШ ИТМО: https://itmo.ru/ru/viewfaculty/115/

Сообщество FPGA Systems: https://t.me/fpgasystems

Venus rv32i — Kotlin RISC-V emulator:
- https://github.com/kvakil/venus
БЭВМ на Java
- https://github.com/tune-it/bcomp

MiL/SiL/PiL/HiL
- https://youtu.be/EZthOn4_0rw
- https://www.mathworks.com/matlabcentral/answers/440277-what-are-mil-sil-pil-and-hil-and-how-do-they-integrate-with-the-model-based-design-approach#answer_356873

Model-Driven Engineering 
- Курс Архитектуры компьютера: https://csa.edu.swampbuds.me/06-hw-sw-program-moc.md#/10
- en: https://en.wikipedia.org/wiki/Model-driven_engineering
- ru: https://ru.wikipedia.org/wiki/Разработка,_управляемая_моделями

Quokka:
- https://www.youtube.com/live/_MrGRMY-6jE
- https://github.com/EvgenyMuryshkin/qusoc

Verik:
- https://dspace.mit.edu/handle/1721.1/145151
    - https://dspace.mit.edu/bitstream/handle/1721.1/145151/Wang-frwang-meng-eecs-2022-thesis.pdf
    - https://github.com/frwang96/verik
        - https://codetabs.com/count-loc/count-loc-online.html

FPGA Twitch 03 - Введение в высокоуровневый синтез - High Level Synthesis (часть 1 из 2):
- https://youtu.be/a2SQQNgB4iQ

SystemC - Инструмент системного моделирования
- Методичка МИРЭA "SystemC Моделирование электронных систем": http://www.toe-mirea.ru/download/file47.pdf

ИРИС – инструментарий разработки интегральных схем в среде С++:
- https://engineer.yadro.com/wp-content/uploads/2024/06/gasanov-slides.pdf

cocotb - testbench environment in Python
- https://www.cocotb.org/
- over GPI C++ lib: https://docs.cocotb.org/en/development/library_reference_c.html
  - GPI - general purpose interface поддерживает
    - VPI - verilog procedura interface
    - VHPI - VHDL procedural iface
    - FLI - foreign language iface

UVM - Universal Verification Methodology
- методология тестирования RTL дизайнов: https://en.wikipedia.org/wiki/Universal_Verification_Methodology
- развитие OVM (Open Verification Methodology)

### Название инструмента

- Kotlin
- IR
- *iL = * in the Loop
- HardWare
- CIRCT = Circuit IR Compilers & Tools
- Controls.kt ~ ctl, ctrl
- OOC = out-of-controls
- Arcilator = arc
- model

Варианты:

- > cirkt -- lib
- > Circulator-kt -- wrapper
- > circulator -- имеет отсылку на CIRCT, circuits, *lator-инструменты и это реальное название элемента "циркулятор", который повышает мощность, работа в цикле.
- > Controlator -- Controls-kt adapter
- > Coock -- circuit out of controls-kt
- > cookt -- https://en.wiktionary.org/wiki/cookt
- > catch -- circuits at controls hardware
- > hatch -- hardware at contrlos
- > mocha -- models of controls hardware (мокко -- кофе)
- > cirkus --
- > cikl, cycle
- > cyclatron -- scientific experiments, 'caiklatron', -tor ~ -tron, cycles,

Остановился на названии "Circulator.kt" для библиотеки на Kotlin - https://github.com/e1turin/circulator-kt.


### Размышления

Хочется иметь возможность симулировать систему прямо в Kotlin, вместе с
остальной системой, но главная задача это сделать **транслятор в промежуточное**
**представление**. Отсяда вопрос: на каком уровне должно быть это
*представление?  Ведь у нас может быть _"низкоуровневое"_ типа CIRCT или
какое-то повыше в виде схемы данных в Kotlin через композицию Data-классов, к
примеру.

При условии того, что компилятор свой разрабатывать выглядит очень 
расточительным, можно ограничиться функциональным DSL, который в результате
запуска будет давать IR или напрямую симулировать аппаратуру, т.к. обычно это
какой-то Top-модуль, в который интегрируются все другие функциональные
компоненты. Что-то вроде Gradle получится. Остается еще учесть специфику
Controls.kt и его архитектурные подходы через делегирование пропертей и, видимо,
непрерывное время нетипичное для моделей аппаратуры.

Наверное было бы хорошо иметь возможность переключать режимы работы модуля:
трансляция в IR и симуляция поведения.

Еще как альтернативный вариант это всегда получать промежуточное предтавление
и потом через сторонник инструменты взаимодействовать с ними, условно,
скомпилировать в CIRCT и запустить модель через arcilator, к которому 
подключается модель из Kotlin через Native. 
- Либо пойти дальше и написать модуль выполняющий симуляцию по данному IR, что
  пока выглядит нецелесообразно из-за сложности такого предприятия и непригодности
  JVM для таких симуляций; по сути придется сделать декомпилятор из IR в Kotlin
  (?).

Решается проблема:
- нет задержки от актуальной версии модели до симуляции (актуальная передаточная
  функция) -- всeгда самая свежая модель для тестрования.
- И не важно, что RTL-модель не такая производительная как модель прибора, время
  разработки дороже железа гоняющего тесты.
- Модель дает возможность проверить работу системы с точностью до тактов, что
  может быть критично в некоторых случаях. Позволяет проводить нагрузочное
  тестирование алгоритма, т.е. проверять, что он укладывается во временные рамки.
- Проект решает проблему не разработчика устройств на ПЛИС, а интегратора этих
  устройств в SCADA-систему: не нужно садить отдельного человека писать модели
  устройств, а можно автоматически получать их из уже готового описания.

Можно модели разворачивать на сервере и обращаться к ним как к источнику истины
при тестировании.

Можно использовать аппаратную модель для получения "передаточной функции", типа
замокать черный ящик.

В качестве реального примера можно взять энкодер, например энкодер для
промышленных двигателей на 65к отсчетов, сделать для него простой генератор
входных данных.

Моделирование происходит в режиме "cycle-accurate", что переводится как
"тактовое моделирование" или "моделированию с тактовой точностью". 
В [статье]( https://habr.com/ru/articles/884396/ ) это называется просто
"цифровое моделирование при помощи Verilog".


Мне нравится 3 вариант цели, где мы все таки останавливаемся на E2E тестировании
с учетом цифровых схем. Можно задаться вопросом, а так ли оно нужно. И для
иллюстрации стоит привести какой-то пример системы, где ошибка проявляется из-за
сложного взаимодействия двух приборов. 
- Например, можно вспомнить о недокументированных возможностях в bluetooth
  чипах, которые реагировали на сообщения, содержащие не явные команды. Так вот,
  положим, что у нас есть в системе такое устройство, которое неожиданно флипает
  бит на последовательность сообщений `0b11111111` (которое не должно появляться
  в эфире), а другое устройство в режиме ожидания как раз производит именно
  такой сигнал.
    - такое поведение может быть даже специфицированно, но для устройств по отдельности.
- Еще пример, мы можем тестировать устройство, которое предполагает защиту от помех. А помехи 
  могут происходить только от определенного устройства в определенном его
  состоянии. И вот мы проверим их интеграцию.
  - кроме того можно использовать доступное нам Property-based тестирование и
  доступ к внутренним состяниям.
- Другой пример. Скажем, что устройства специфицированы на определенные
  физические протоколы, и так получается, что в определенной ситуации одно
  устройство может выдавать такой физический сигнал, который приведет к
  перегоранию другого устройства, условно серия `1`.
   


#### Возможные проблемы

- Асинхронная сущность Controls-kt в синхронных моделях аппаратуры.
  - => Синхронизация на входе в приборы.
  - => Сосредоточиться на логическом дискретном моделировании, а асинхронное уже зависит от используемой аппаратуры.
- Потеря точности моделирования, если не моделируется переферия прибора (например, выходной ethernet).
  - => Стыковать модели на логических выходах, без сложной периферии.
- Слишком большие вычислительные мощности нужны для моделирования целой SCADA-системы.
  - => Использовать оптимизатор MLIR & LLVM, выбросить не нужные объекты из наблюдения.
  - => Запускать модель на сервере, к которому обращаться за уточнением данных.



## Задание...

### 1. Основные вопросы, подлежащие разработке

Информация для заполнения блока задания: 

> Техзадание -- что. Цель -- зачем. Задачи -- как.

#### 1.1. техническое задание: 

<!-- Реализовать программный модуль реализующий поддержку моделирования аппаратуры на уровне цифровых схем для фреймворка Controls.kt. -->

Вариант 1 - более абстрактный:

Реализовать программный модуль на языке программирования Kotlin для фреймворка
"Controls.kt", предоставляющий поддержку моделирования аппаратуры на уровне
цифровых схем для виртуальных устройствах за счет автоматического построения
исполняемых моделей на основе языка описания аппаратуры.

Вариант 2 - более конкретный:

hidden
<!-- Реализовать программный модуль на языке программирования Kotlin для платформы JVM, который предоставляет программный интерфейс для использования функций модели устройства, предоставленными в виде бинарного исполняемого файла, программный модуль, создающий программный интерфейс модели конкретного прибора автоматическим образом с учетом заданной конфигурации, а так же предложить подход для получения указанного исполняемого модуля из реализации модели на языке описания аппаратуры. -->

Вариант 2.5:

hidden
<!-- Разработать и реализовать программный модуль на языке программирования Kotlin для платформы JVM, который предоставляет программный интерфейс для использования функций динамически загружаемой библиотеки, реализующих логику протекания цифровых сигналов моделируемого устройства; разработать и реализовать программный модуль, создающий описанный программный интерфейс модели конкретного устройства автоматическим образом с учетом заданной конфигурации; а так же предложить способ получения указанной библиотеки из реализации устройства на языке описания аппаратуры. -->

<!-- - Такой вариант на мой взгляд лишает работу "исследовательскости", всё таки этот
  путь я уже прошел и теперь только знаю, что нужно сделать, а тз (цель)
  изначально было очень абстрактно. -->

<!-- - Зачем эта поддержка??
  - если ясно зачем, то в тз не нужно автоматическое писать, поддержки ведь и так не было? 
    - или тз это то задание, к которому в итоге пришли, а не то какая идея была изначально? Может тогда стоит упомянуть сепарированность модуля моделирования?  -->

- Судя по чужим вкр тз не включается в диплом. и наверное можно его по цели написать.

#### 1.2. исходные данные к работе:

1. Документация и исходные коды проекта Controls.kt и проектов использующих его.
2. Документация проекта Gradle.
3. Документация проектa Chisel.
<!-- 3. Документация проектов Chisel и Verilator. -->
<!-- 3. Документация и исходные коды проекта LLVM CIRCT и связанных с ним репозиториев. -->

- это похоже никуда не включается, можно не заморачиваться.

#### 1.3. содержание работы:

старое 1:

> Выпускная квалификационная работа предполагает реализацию программного модуля
> предоставляющего возможности по моделированию аппаратуры на уровне цифровых схем
> для фреймворка для создания и моделирования SCADA-систем Controls.kt.

старое 2:

Выпускная квалификационная работа предполагает реализацию программного модуля
на языке программирования Kotlin, предоставляющего возможность автоматического
построения моделей цифровой аппаратуры для фреймворка "Controls.kt" из
имеющихся моделей на языке описания аппаратуры.

новое:

Выпускная квалификационная работа предполагает разработку программного решения
на языке программирования Kotlin, предоставляющего возможность использования
виртуальных устройств из фреймворка Controls.kt, в режиме моделирования работы
цифровых схем и анализ разработанного решения.

- норм что еще анализ целесообразности?
- содержание работы вообще куда-то включается, над ним нужно заморачиваться? -
  похоже, что нет. Будет еще характеристика работы (похожее), но дальше.

- опять же, что цель: реализация поддержки или автоматизация?

#### 1.4. цель: 

Т.к. тема у меня технически сложная и предметная область не популярная, поэтому
в цели нужно ёмко изложить свою задумку, чтобы у комиссии не возникало вопросов.

старое 1: <!-- CHECKME: -->

> Предоставление возможности моделирования и тестирования системы на уровне
> цифровых схем.
- Это "реализация поддержки", но зачем эта поддержка?

старое 2: <!-- CHECKME: -->

> Автоматизация процесса построения моделей аппаратуры в фреймворке Controls.kt.

Автоматизация процесса построения моделей аппаратуры в фреймворке Controls.kt для моделей приборов на языке описания аппаратуры.

- Автоматизация ради чего? Зачем много часов автоматизировать то, что делается считанные секунды.

новое:

Вариант 1:

Снижение затрат на производство систем типа SCADA за счет их сквозного тестирования с
применением виртуальных устройств поддерживающих моделирование на уровне цифровых схем.

- Закрученная формулировка
- в целом, сквозное тестирование говорит о повышении качества реализации, но может
  быть дорого, что странно при цели снизить затраты, но применяя нашу технику

Вариант 2:

Снижение затрат на сквозное тестирование SCADA систем, реализованных с
использованием фреймворка "Controls-kt", за счет применения виртуальных
устройств поддерживающих моделирование на уровне цифровых схем.

- А снижаем ли мы так затраты именно на тестирование? похоже, что так же не нужно
  иметь отдельного человека актуализирующего модели, но снижаем ли мы так
  затраты на тестирование. А если не снижаем, то и на производство не снижается наверное.
  - А снижение затрат относится только к Controls-kt с их асинхронной моделью
    взаимодействия или нет? 

Вариант 3:

Повышение качества систем на базе фреймворка "Controls.kt" за счет их сквозного тестирования c применением моделей цифровых схем в виртуальных устройствах.

- Эта формулировка отражает первоначальную цель. 
  Наверное, повышение качества системы за счет возможности более полного
  сквозного моделирования должно быть очевидно.

- Оценка затрат: выбрасываем промежуточные модели, сразу тестируем на актуальных
  HDL моделях - меньше время и нет дополнительного человека, поддерживающего
  модели.  генерации моделей мы добиваемся преимущества.
- целесообразность: вы наверное хотите, что система отопления в вашем доме
  работала без сбоев, которые возникли бы из-за того, что какой-то датчик оказался несовместим с датчиком в противоположной части дома.

#### 1.5. задачи работы:

<!-- - Изучение и анализ архитектуры фреймворка Controls.kt. -->
<!-- - Aнализ требований к разрабатываемому модулю. -->
- Исследование имеющихся решений для моделирования аппаратуры.
- Разработка программного модуля на языке программирования Kotlin для работы с моделями аппаратуры.
<!-- - Разработка программного модуля обеспечивающего взаимодействие системы Controls-kt с разработанным модулем. -->
<!-- - Тестирование разработанного модуля и демонстрация его работы в окружении системы Controls-kt. -->
- Демонстрация применения моделей аппаратуры в системе на базе Controls-kt.
- Анализ полученных результатов.
<!-- - Документирование разработанных компонентов. -->
<!-- - Презентация полученных результатов. -->


- похоже что эти задачи не так важны. Они скорее в общем про "работу", т.е. ее смысл до написания ВКР.

#### 1.6. перечень подлежащих разработке вопросов:

Skip.

<!-- Del. - Архитектура SCADA-системы Controls-kt и API для моделирования приборов.
- Существующие системы моделирования аппаратуры.
- Языки описания аппаратуры (Chisel, Verilog/SystemVerilog).
- Проект CIRCT: процесс получения исполняемых моделей, API получаемых моделей. -->
<!-- Del. - Проект Verilator: API для взаимодействия с исполняемыми моделями. -->
<!-- Del. - Проект SystemC: API для взаимодействия с исполняемыми моделями. -->
<!-- - API JVM для взаимодействия с нативным кодом.
- Средства для генерации кода на языке Kotlin.
- ... -->

- А это точно "Вопросы"?? -- видимо да
- A это точно пойдет в ВКР, или над этим можно не париться?
  - судя по всему не обязательно. как будто бы оно относится к процессу подготовки к выполнению ВКР.

#### 1.7. рекомендуемые материалы и пособия для выполнения работы и т.д.:

1. Документация и исходный код проекта Controls-kt - <!-- ссылка --> (дата обращения ...)
2. Документация к проекту Chisel.
3. Описание и документация FFM API в Java из проекта Panama - https://openjdk.org/projects/panama/ (дата обращения ...)
<!-- 4. Документация проекта LLVM CIRCT - ссылка (дата ...) -->
5. 

- это точно идет в диплом, но надо ли тут мне много писать?

### 2. Форма представления материалов ВКР

старое: 

Отчет. Пояснительная записка с описанием исследвания и выполненного задания. Программный код разработанных модулей. Презентация с основными выводами и результатами.

новое:

Форма представления основных результатов ВКР: пояснительная записка и презентация.
Форма представления приложений: программный код.

### 3. Дата выдачи задания

14 октября 2024 год.

14.10.2024

### 4. Срок представления готовой ВКР

> Рекомендации: Срок сдачи готовой работы не позднее даты начала ГИА (по графику
> учебного процесса).  Срок загрузки итоговой версии ВКР для проверки в системе
> «Антиплагиат» - не позднее чем за 10 дней до даты защиты ВКР 
> (см.[Положении о ВКР)](https://student.itmo.ru/ru/gia_docs/)

25 мая 2025 год.

25.05.2025

## Защита

### Предзащита

[google presentation](https://docs.google.com/presentation/d/1oYHiMF2HuB65wSx1xpEgHd4VrCoTfuKjCs94U5cVWxw/edit?usp=sharing) (comments)

Тема ВКР: Реализация модуля моделирования аппаратуры для SCADA-систем

Контекст:

Controls.kt — фреймворк для создания легковесных SCADA-систем на языке
программирования Kotlin, основан на DataForge-control.

Инструмент развивается Центром научного программирования МФТИ.

- ["Declarative analysis in "Troitsk nu-mass" experiment"](https://iopscience.iop.org/article/10.1088/1742-6596/1525/1/012024)
- ["A Novel Solution for Controlling Hardware Components of Accelerators and Beamlines"](https://www.preprints.org/manuscript/202108.0336/v1)
- ["Controls-kt, a Next Generation Control System"](https://www.researchgate.net/publication/373369314_Controls-kt_a_Next_Generation_Control_System)

Актуальность темы:

- Активно развивающийся фреймворк
  Фокус фреймворка сместился в сторону встраивания аналитики и моделирования с
  целью тестирования подобно подходам MiL/SiL/PiL/HiL.
<!-- - из telegram [@SciProgCentre](https://t.me/SciProgCentre): -->
<!--   - про создание внутреннего формата представления ~VCD: https://t.me/SciProgCentre/24449 -->
<!--   - про задачу моделирования аппаартуры: https://t.me/SciProgCentre/26576 -->
<!--   - про изменение направленности фреймворка: https://t.me/SciProgCentre/26599 -->
<!-- - MiL/SiL/PiL/HiL -->
<!--   - [1](https://www.mathworks.com/matlabcentral/answers/440277-what-are-mil-sil-pil-and-hil-and-how-do-they-integrate-with-the-model-based-design-approach#answer_356873)] -->
<!--   - [2](https://youtu.be/EZthOn4_0rw)] -->
- Современные технологии
  Фреймворк облегчает процесс создания SCADA-систем.
  - Современные инструменты расширяют сферу применимости технологий.
  - Единый язык для описания всех компонентов системы. 
- Circuit IR Compilers and Tools
  - Инфраструктура для создания промежуточного представления цифровых схем на
    базе MLIR (проект LLVM). → Симуляция работы и синтез специализированных
    приборов.

- Controls.kt (former DataForge-control):

> Если интересен пример - сейчас я работаю над моделью анализатора крови
> [URIT-5360/5380/5381 5-Part-Diff Auto Hematology Analyzer]. Это достаточно
> сложное устройство из многих составных частей, со своими особенностями.

Цель и задачи ВКР:

Цель:

> Предоставление возможности моделирования и тестирования системы на уровне
> цифровых схем.

Задачи:

1. Изучение и анализ архитектуры фреймворка Controls.kt.
2. Исследование имеющихся решений для моделирования аппаратуры.
3. Проектирование архитектуры программного модуля.
4. Разработка программного модуля.
5. Тестирование разработанного модуля и проверка совместимости с системой Controls.kt.
6. Документирование разработанных компонентов.

План работы:

1. Анализ существующих решений для моделирования аппаратуры.
2. изучение архитектуры фреймворка.
3. Анализ требований к программному модулю.
4. Проектирование
  1. Разработка архитектуры программного модуля.
  2. Определение интерфейсов взаимодействия с Controls.kt.
  3. Документирование архитектурных решений.
5. Разработка программного модуля.
6. Тестирование этого модуля.
  1. Разработка функциональных тестов.
  2. Интеграционное тестирование с Controls.kt
  3. Анализ и устранение выявленных дефектов.
7. Документирование разработанных компонентов.
<!-- XXX: Нужно? -->
<!-- 8. Оформление пояснительной записки ВКР -->
<!-- 9. Подготовка презентации и демонстрации материала. -->
<!-- 10. Защита ВКР. -->


<!-- Итого:                                               -->
<!-- - убрать упоминание Фреймворка из темы               -->
<!-- - изменить задачу с анализом архитектуры Фреймворка  -->
<!-- - цель работы не отвечает на вопрос Зачем? По SMART. -->
<!--   Если указывать повышение качества тестирования, то -->
<!--   нужно вводить метрику                              -->

### Возможные вопросы

1. А какие еще есть технологии для разработки SCADA-систем? Зачем Controls.kt?
2. Моделирование тут это симуляция или эмуляция?
3. А снижение затрат относится только к Controls-kt с их асинхронной моделью
   взаимодействия или нет? 

