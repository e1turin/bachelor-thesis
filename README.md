# Бакалаврский диплом

тема: «Реализация модуль моделирования аппаратуры для SCADA-системы Controls.kt»

Controls.kt: 
- https://sciprog.center/projects/controls
- https://t.me/SciProgCentre/26604

Обзор Chisel для генерации сложных цифровых схем и сравнение с System Verilog:
- https://youtu.be/d_vlVsoJ8vI

ИРИС – инструментарий разработки интегральных схем в среде С++:
- https://engineer.yadro.com/wp-content/uploads/2024/06/gasanov-slides.pdf

CHISEL:
- https://www.imm.dtu.dk/~masca/chisel-book.pdf

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

- FIRRTL (dead):
    - https://github.com/chipsalliance/firrtl

- CIRCT — Circuit IR Compilers and Tools
    - https://circt.llvm.org/
	- https://github.com/llvm/circt
	- Arcilator — 
        - https://youtu.be/iwJBlRUz6Vw
        - https://llvm.org/devmtg/2023-10/slides/techtalks/Erhart-Arcilator-FastAndCycleAccurateHardwareSimulationInCIRCT.pdf
	- ИСП РАН: https://gitlab.ispras.ru/mvg/mvg-oss/circt

- Venus rv32i — Kotlin RISC-V emulator:
    - https://github.com/kvakil/venus
- БЭВМ на Java
    - https://github.com/tune-it/bcomp

- HIL 
    - https://www.google.com/search?q=hardware+in+the+loop
- PIL 
    - https://www.google.com/search?q=processor+in+the+loop

## Задание...

1. **Основные вопросы, подлежащие разработке**

Информация для заполнения блока задания: 
	1. **техническое задание**: 
		> Реализовать программный модуль для моделирования аппаратуры совместимый с фреймворком Controls.kt.
	2. **исходные данные к работе**:
		1. Репозиторий исходных кодов проекта Controls.kt.
		2. Документация к проекту Controls.kt. (она есть?)
		3. Документация к проекту Chisel. (?)
		4. Документация к проекту CIRCT. (?)
		5. Документация к проекту Verik. (?)
		6. ...
	3. **содержание работы**:
		> Выпускная квалификационная работа предполагает реализацию программного модуля предоставляющего возможности по моделированию аппаратуры совместимого с фреймворком для создания и моделирования SCADA-систем Controls.kt.
	4. **цель**:
		> Расширение возможностей по моделированию и тестированию SCADA-систем.
	5. **задачи работы**:
		1. Изучение и анализ архитектуры фреймворка Controls.kt.
		2. Исследование имеющихся решений для моделирования аппаратуры.
		3. Проектирование архитектуры программного модуля.
		4. Разработка программного модуля.
		5. Проектирование и разработка тестового покрытия модуля.
		6. Тестирование готового решения и интеграция в систему Controls.kt.
		7. Документирование разработанных программных компонентов.
	6. **перечень подлежащих разработке вопросов**:
		1. Архитектур SCADA-систем и систем моделирования.
		2. Языки описания аппаратуры.
		3. Проект CIRCT.
		4. ...
	7. **рекомендуемые материалы и пособия для выполнения работы и т.д.**:
		1.  ???

2. **Форма представления материалов ВКР**

Информация для заполнения блока задания: 
	1. форма представления основных или дополнительных результаты ВКР:	
	2. форма представления Приложений (например: программный код, чертежи, презентация, и пр.):
		
> Отчет. Пояснительная записка, программный код, презентация.

2. **Дата выдачи задания** / Assignment issued on

(???)

3. **Срок представления готовой ВКР** / Deadline for final edition of the thesis  

Рекомендации: Срок сдачи готовой работы не позднее даты начала ГИА (по графику
учебного процесса).  Срок загрузки итоговой версии ВКР для проверки в системе
«Антиплагиат» - не позднее чем за 10 дней до даты защиты ВКР 
(см.[Положении о ВКР)](https://student.itmo.ru/ru/gia_docs/)

(???)

4. **Дополнительно** / Additional information  

Можете конкретизировать график представления материалов ВКР или указать любую другую информацию по этапам работы на ВКР.

(???)

## Возможные вопросы

5. А какие еще есть технологии для разработки SCADA-систем? зачем Controls.kt?


