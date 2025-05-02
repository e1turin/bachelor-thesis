#import "prelude.typ": *

#show: GOST_7_32__2017.with(
  title: "Реализация модуля моделирования аппаратуры для SCADA-систем",
  author: "Тюрин Иван Николаевич"
)


#struct([СОДЕРЖАНИЕ], outlined: false)

#outline(title: none)

#struct([СПИСОК СОКРАЩЕНИЙ И УСЛОВНЫХ ОБОЗНАЧЕНИЙ])

#definition([Портлет (от англ. portlet)], [модуль на портальной странице, предоставляющий отдельный функционал (например, форму или таблицу).])
#definition([Сервлет (от англ. servlet)],[Java-компонент для обработки HTTP-запросов на сервере и генерации ответов.])
#definition([No-code],[разработка приложений без программирования с помощью визуальных инструментов.])
#definition([CSS],[язык стилей для оформления веб-страниц (цвета, шрифты, расположение элементов).])
#definition([СУБД],[программа для хранения, управления и обработки данных в базе данных.])


#struct([ВВЕДЕНИЕ])

Тема практики: Обновление версии платформы Liferay для размещения лендинговой страницы компании до версии 7.4.3. 
Цель практики: Модернизация устаревших компонентов системы.

Основые этапы производственной практики представленны в таблице #ref(<stages>, supplement: none).

// | № этапа | Название этапа | Задание|
// | 1 | Инструктаж обучающегося | Инструктаж обучающегося по ознакомлению с требованиями охраны труда, техники безопасности, пожарной безопасности, а также правилами внутреннего трудового распорядка.|
// | 2 | Изучение архитектуры системы | Ознакомиться с технологиями используемыми в системе, в частности платформой Liferay, контейнером приложений Wildfly, СУБД PostgreSQL. Ознакомиться с архитектурой сервисов включенных в систему, жизненным циклом сущностей, процессами их взаимодействия с платформой, специализированными решениями принятыми при разработке системы.|
// | 3 | Составленеи плана работ и распределение обязанностей | Необходимо определить шаги для выполнения обновления системы, предусмотреть нюансы используемой системы и учесть риски. В команде нужно зафиксировать свою область ответственности в проекте.|
// | 4 | Исследование новой версии платформы | Требуется ознакомиться с системными требованиями версии 7.4.3 платформы Liferay, изучить документацию о миграции со старых версий этой платформы, ознакомиться с новыми функциональными возможностями и определить шаги для выполнения обновления системы. Ознакомиться с новыми доступными способами развертывания платформы и оценить целесообразность их использования при обновлении системы.|
// | 5 | Подготовка рабочего окружения и экспериментальный запуск платформы | Требуется сконфигурировать требуемые зависимости проекта, установить их и на тестовой системе без реальных сервисов проверить работоспособность требуемых функций платформы. По проделанной работе составить документацию.|
// | 6 | Адаптация сервисов к новой версии платформы | Необходимо адаптировать сервисы к новой версии платформы, что включает в себя: изменение зависимостей системы их обновление, исправление устаревших частей программного кода, отвечающего за работу сервисов и их развертывание на платформе.|
// | 7 | Миграция базы данных | Необходимо обновить данные в СУБД, применив подготовленную миграцию из предыдущей её версии.|
// | 8 | Интеграция системы с новым пользовательским интерфейсом | Требуется изменить в системе пользовательский интерфейс на новый, специально разработанный по макету дизайна.|
// | 9 | Тестрование и верификация обновленной системы | Должно быть произведено тестирование подсистем новой версии системы, проверено выполнение поставленных требований.|
// | 10 | Оформление отчётных документов в соответствии с требованиями | 1. Должно быть подробное описание выполнения задач по этапам. Результаты задания необходимо разместить в приложения. 2. Оформление отчёта должно быть выполнено в соответствии с методическим пособием (https://books.ifmo.ru/file/pdf/2622.pdf) 3. Структура документа: титульный лист, введение, основная часть, заключение, приложения. 4. В основной части подробно описывается выполнение задач всех этапов, исключая этапы 1, 10 и 11.|
// | 11 | Получить отзыв руководителя практики | Получить отзыв с оценкой у руководителя практики в модуле Практики |

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*№ этапа*], [*Название этапа*], [*Задание*],
  ),

  [1], [Инструктаж обучающегося], [
    Инструктаж обучающегося по ознакомлению с требованиями охраны труда, \
    техники безопасности, пожарной безопасности, а также правилами \
    внутреннего трудового распорядка.
  ],

  [2], [Изучение архитектуры системы], [
    Ознакомиться с технологиями используемыми в системе, в частности \
    платформой Liferay, контейнером приложений Wildfly, СУБД PostgreSQL. \
    Ознакомиться с архитектурой сервисов включенных в систему, жизненным \
    циклом сущностей, процессами их взаимодействия с платформой, \
    специализированными решениями принятыми при разработке системы.
  ],

  [3], [Составление плана работ и распределение обязанностей], [
    Необходимо определить шаги для выполнения обновления системы, \
    предусмотреть нюансы используемой системы и учесть риски. В команде \
    нужно зафиксировать свою область ответственности в проекте.
  ],

  [4], [Исследование новой версии платформы], [
    Требуется ознакомиться с системными требованиями версии 7.4.3 платформы \
    Liferay, изучить документацию о миграции со старых версий этой платформы, \
    ознакомиться с новыми функциональными возможностями и определить шаги для \
    выполнения обновления системы. Ознакомиться с новыми доступными способами \
    развертывания платформы и оценить целесообразность их использования при \
    обновлении системы.
  ],

  [5], [Подготовка рабочего окружения и экспериментальный запуск платформы], [
    Требуется сконфигурировать требуемые зависимости проекта, установить их \
    и на тестовой системе без реальных сервисов проверить работоспособность \
    требуемых функций платформы. По проделанной работе составить документацию.
  ],

  [6], [Адаптация сервисов к новой версии платформы], [
    Необходимо адаптировать сервисы к новой версии платформы, что включает \
    в себя: изменение зависимостей системы, их обновление, исправление \
    устаревших частей программного кода, отвечающего за работу сервисов \
    и их развертывание на платформе.
  ],

  [7], [Миграция базы данных], [
    Необходимо обновить данные в СУБД, применив подготовленную миграцию \
    из предыдущей её версии.
  ],

  [8], [Интеграция системы с новым пользовательским интерфейсом], [
    Требуется изменить в системе пользовательский интерфейс на новый, \
    специально разработанный по макету дизайна.
  ],

  [9], [Тестирование и верификация обновленной системы], [
    Должно быть произведено тестирование подсистем новой версии системы, \
    проверено выполнение поставленных требований.
  ],

  [10], [Оформление отчётных документов в соответствии с требованиями], [
    1. Должно быть подробное описание выполнения задач по этапам. \
    Результаты задания необходимо разместить в приложения. \
    2. Оформление отчёта должно быть выполнено в соответствии с \
    методическим пособием (https://books.ifmo.ru/file/pdf/2622.pdf) \
    3. Структура документа: титульный лист, введение, основная часть, \
    заключение, приложения. \
    4. В основной части подробно описывается выполнение задач всех этапов, \
    исключая этапы 1, 10 и 11.
  ],

  [11], [Получить отзыв руководителя практики], [
    Получить отзыв с оценкой у руководителя практики в модуле Практики
  ],
)
#figure(table(), caption: [Этапы производственной практики]) <stages>

В ходе выполнения практики были пройдены все этапы работы и выполнены все поставленные задачи.

// = Инструктаж обучающегося 
// //  Инструктаж обучающегося по ознакомлению с требованиями охраны труда, техники безопасности, пожарной безопасности, а также правилами внутреннего трудового распорядка. 

#heading("Изучение архитектуры системы")

На данном этапе работы была изучена архитекрута системы, над которой
производились манипуляции. Ключевой используемой технологией для работы сайта
является платформа Liferay, которая отвечает за конфигурирование порталов на
сайте компании. Кроме того платформа используется не в стандартной конфигурации
представленной в официальной документации. Общую архитектуру системы можно
видеть на изображении #ref(<tune-it-arch>), где красным выделены нестандартные
для платформы архитектурные решения: сервер приложений [3] и СУБД. Система представляет собой запущенное c
помощью серверов приложений WildFly приложение платформы Liferay для "no-code"
создания и управления веб-сайтами по средством запуска "портлетов" для отдельных
разделов сайта, т.н. "порталов". Каждый портал представляет собой отдельное
приложение, выполняющее определенную функцию за счет запуска отдельных
компонентов -- "сервлетов". Данные сохраняются в базу данных PostgreSQL, которая
отличается от стандартной базы данных использумой в платформе Liferay, MySQL [4].
Все порталы веб-сайта для следования единообразию корпоративного дизайна
используют общую тему веб-страниц Liferay, она действует как отдельный компонент
системы, оборачивающий другие компоненты и предоставляющий необходимые CSS-стили
для разделов сайта.

#figure(
  image("resources/images/tune-it-arch.png", width: 65%),
  caption: [Архитектура системы хостинга веб-сайта компании],
) <tune-it-arch>

Нестандартные компоненты системы накладывают сложности при использовании
официальной инструкции [1] по обновлении версии платформы. В этом и состояла
ключевая сложность выполнения работы.

На этапе определения актуального состояния системы возникли сложности, т.к. система
контроля версий содержала сложную и не очевидную историю изменений, из-за чего
ошибочно сначала рассматривалась слишком устаревшая версия системы, которая уже была
мигрирована на новую, 7.3 версию платформы.

// ссылки на страницы с liferay (wildfly, postgresql, migration, version update)

#heading("Составленеи плана работ и распределение обязанностей")

Над задачей работала команда из нескольких людей, руководитель команды
распределил подзадачи между участниками таким образом, чтобы как можно больше
подзадач исполнялось одновременно разными членами команды, тем не менее
некоторые задачи требовали совместной работы. Например, перед тем как выполнить
запуск портлетов на новой версии платформы, необходимо обновить версии
зависимостей портлетов и исправить проблемы совместемости. На меня были
возложенны следующие подзадачи представленные в таблице.

// // оформить в виде таблицы с колонками номер, название, описание.
// + Выполнить сборку портлетов с актуальной версией платформы в системе.
// + Определить характериситики системы требуемые для новой версии платформы.
// + Обновить список версий зависимостей для портлетов в соответствии с новыми характеристиками системы.
// + Выполнить сборку портлетов с новыми версиями зависимостей в системе.
// + Проверить работоспособность подготовленного операционного окружения для размещения приложения платформы.
// + Выполнить запуск системы в подготовленном операционном окружении.
// + Проверить работоспособность сисистемы с новой конфигурацией.

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*№*], [*Название*], [*Описание*],
  ),

  [1], [Сборка портлетов], [
    Выполнить сборку портлетов с актуальной версией платформы в системе.
  ],

  [2], [Определение характеристик], [
    Определить характеристики системы, требуемые для новой версии платформы.
  ],

  [3], [Обновление зависимостей], [
    Обновить список версий зависимостей для портлетов в соответствии с \
    новыми характеристиками системы.
  ],

  [4], [Сборка с новыми зависимостями], [
    Выполнить сборку портлетов с новыми версиями зависимостей в системе.
  ],

  [5], [Проверка окружения], [
    Проверить работоспособность подготовленного операционного окружения \
    для размещения приложения платформы.
  ],

  [6], [Запуск системы], [
    Выполнить запуск системы в подготовленном операционном окружении.
  ],

  [7], [Проверка системы], [
    Проверить работоспособность системы с новой конфигурацией.
  ],
)


#heading("Исследование новой версии платформы")

На момент выполнения задания практики актуальной версией платформы в проекте
является версия 7.3, которую требовалось обновить до версии 7.4.3. Для
обновления системы требуется соблюсти требования к характериситикам системы,
таким, как версия JDK, совместимые версии СУБД и сервера приложений [2], из которых
вытекают требования к версиям зависимостей портлетов. Кроме того компания
выдвигает свои требования к системе.

Новые требования к характеристиками системы представлены в таблицe:
// // оформить в виде таблицы с колонками номер-название-описание-версия
// - Oracle JDK 17
// - PostgreSQL 16.8
// - WildFly 26.1.3.Final
// - Elastic Search и плагины для него -- 7.17.24 

#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*№*], [*Название*], [*Описание*], [*Версия*],
  ),

  [1], [Oracle JDK], [
    Среда выполнения и компиляции Java-приложений.
  ], [17],

  [2], [PostgreSQL], [
    Объектно-реляционная система управления базами данных.
  ], [16.8],

  [3], [WildFly], [
    Контейнер Java EE-приложений, используемый для развертывания портлетов.
  ], [26.1.3.Final],

  [4], [Elasticsearch и плагины], [
    Поисковый движок для полнотекстового поиска и аналитики. \
    Используется вместе с набором плагинов для расширенной функциональности.
  ], [7.17.24],
)

В результате анализа требующихся изменений был построен план обновления
конфигураций: в первую очередь следует обновить версию JDK, т.к. уже это
изменение определяет на остальные компоненты; далее следует обновить версию 
сервера приложений WildFly, т.к. он использует JDK для своей работы; после 
этого следует обновить версию Elastic Search и его плагинов, потому что они 
так же используют JDK и работают в контейнере приложений; в последнюю очередь
конфигурируется версия СУБД PostgreSQL [5], потому что этот компонент используется
через стабильный API, и изменения между версиями не являются столь значительными.

#heading("Подготовка рабочего окружения и экспериментальный запуск платформы")

Развертыванием рабочего окружения системы занимался отдельный член команды, моей
задачей была проверка автоматического развертывания этого окружения. Как оказалось, 
при разработке окружения были допущены ошибки, которые заключались в неверных ссылках
на ресурсы используемые для запуска приложения платформы и инициализации СУБД. 
Об этом было сообщено разработчику конфигурации окружения и предложены исправления,
 которые можно видеть на листинге
//  #ref(<bundle-fix>, supplement: none)
 в приложения 1. о внесенных изменениях.


После внесенных исправлений операционное окружение стало 
возможно развертывать с использованием одной команды к приложению Docker,
 представленной на листинге #ref(<compose-up>, supplement: none). Автоматизированное окружение демонструет
пользовательский интерфейс платформы, позволяющий создавать пользователей
и страницы и разделы сайта в режиме no-code. На данном этапе не выполняется
запуск портлетов сайта компании.

#figure(
```console
$ docker compose up -d
[+] Running 2/2
 ✔ Container wildfly-bundle-postgres-1  Healthy                                           1.7s 
 ✔ Container wildfly-bundle-bundle-1    Started                                           1.8s
```, caption: [Вывод в консоль при успешном запуске окружения системы]) <compose-up>

#heading("Адаптация сервисов к новой версии платформы")
//  Необходимо адаптировать сервисы к новой версии платформы, что включает в
//  себя: изменение зависимостей системы их обновление, исправление устаревших
//  частей программного кода, отвечающего за работу сервисов и их развертывание
//  на платформе. 

Основная часть моей работы состояла в сборке системы с обновленными 
версиями зависимостей. Для этого было выполнено итеративное обновление
версий зависимостей и сборка проекта после каждого внесенного 
изменения, начиная с обновления версии JDK и плагина Liferay для 
сборочной системы Maven.

Ключевые изменения в конфигурации сборки портлетов можно видеть на листинге в приложении 2. Для
внесенных изменений имеются соответствующие комментарии в этом листинге. 
// #ref(<maven-update>, supplement: none)
В основном 
изменения связаны с переходом на новую версию платформы JDK 17, где появились 
ужесточенные политики работы с модулями [6] и некоторые компоненты библиотек для 
этой версии стали выделены в отдельные пакеты в сравнении с библиотеками для
прежней версии JDK [7]. Так же важное изменение заключалось в том, чтобы убрать из
сборочного процесса сборку CSS-стилей c помощью `liferey.css.builder`, т.к. теперь
они должны браться из отдельного компонентa -- темы сайта (которая разрабатывалась
другим членом команды). 

#heading("Миграция базы данных")

За реализацию скриптов для миграции базы данных отвечал другой член команды,
в моих обязанностях была проверка работоспособности этих скриптов в
разработанном окружении, вывод в консоль при выполнении скрипта миграции
можно видеть на листинге #ref(<migration>, supplement: none). И соотвенно все данные успешно перенесены в новую СУБД
и стали доступны в системе.

#figure(
```console
$ ./run_postgres_migration
...
MIGRATION SUCCEED
```, caption: [Вывод в консоль при успешном применении миграций СУБД])<migration>

#heading("Интеграция системы с новым пользовательским интерфейсом")

За реализацию темы пользовательского интерфейса отвечал другой
член команды, с моей сторы был выполнен ряд действий для проверки
интеграции компонента темы в новую систему.

Тема была добавлена с список модулей проекта в системе сборки и 
проверена совместимость с зависимостями уже доступными в системе, что можно видеть на листинге #ref(<add-module>, supplement: none).

#figure(
```diff
diff --git a/site/pom.xml b/site/pom.xml
index d7d99c7..2557d243 1230644
--- a/site/pom.xml
+++ b/site/pom.xml
@@ -24,7 +24,8 @@
+       <module>site-theme</module>
    </modules>
```, caption: [Изменения в конфигурации сборки добавляющий модуль темы]) <add-module>

И сборка модуля выполняется с помощью команды приведенной на листинге #ref(<build-theme>, supplement: none). Стоит отметить, 
что система сборки не была настроена на автоматическое разрешение зависимостей между 
модулями, и так как это не входило в задание практики, сборочный процесс не был
автоматизирован. 

#figure(
```shell
mvn clean install -f site/site-theme/pom.xml
```, caption: [Команда для сборки и публикации в локальный репозиторий компонента темы]) <build-theme>

#heading("Тестрование и верификация обновленной системы")

В рамках этого этапа выполнения задания было выполнено тестирование развертывания
платформы в тестовом окружении. Требуемые модули для работы сайта были собраны и
опубликован в локальном Maven-репозитории. Был выполнен процесс развертывания портлетов
на платформе путем загрузки артефактов в контейнер. Результат этого можно видеть
на листинге #ref(<deploy>), где суффикс `.deployed` у файлов символизирует успешную загрузку
приложения сервером приложений.

#figure(
```shell
root@25b8a58670c4:/opt/wildfly-26.1.3.Final# ls -l standalone/deployments/
total 20
-rw-r--r-- 1 root root 8888 Jan 17  2023 README.txt
drwxr-xr-x 6 root root 4096 Apr 14 15:03 ROOT.war
-rw-r--r-- 1 root root    8 Apr 14 15:03 ROOT.war.deployed
drwxr-xr-x 6 root root 4096 Apr 14 15:06 catalogue-portlet.war
-rw-r--r-- 1 root root    8 Apr 14 15:06 catalogue-portlet.war.deployed
drwxr-xr-x 6 root root 4096 Apr 14 15:06 projects-portlet.war
-rw-r--r-- 1 root root    8 Apr 14 15:06 projects-portlet.war.deployed
...
```, caption: [Список сервисов и файлы с отметкой об успешной загрузке этих сервисов]) <deploy>

Так же в виде ручного тестирования пользовательского интерфейса сайта было установлено, что
все требуемые приложения работают корректно. Изменение исходных кодом портлетов не потребовалось.

#struct("ЗАКЛЮЧЕНИЕ")

В ходе выполнения поставленных задач была проведена комплексная работа по
обновлению информационной системы, основанной на платформе Liferay. На начальном
этапе была изучена архитектура системы, её основные технологии (Liferay,
Wildfly, PostgreSQL), а также жизненный цикл и взаимодействие сервисов.

Был составлен план обновления, учтены риски и распределены обязанности между
участниками проекта. Проведён анализ новой версии платформы, изучена
документация по миграции, оценены новые функциональные возможности и
способы развертывания.

На тестовой среде была развернута экспериментальная версия системы с новой
платформой, настроены зависимости и зафиксирована документация по окружению. В
дальнейшем произведена адаптация сервисов к новой платформе, в том числе
обновление зависимостей, устранение устаревших решений и обеспечение
совместимости.  Миграция данных в СУБД тестовой системы была выполнена успешно с
учётом подготовленных изменений.

Можно отметить удобство в отсутствии проблем с переносом системы на новую версию
платформы связанные с платформой JDK: за счет стабильного API не потребовались
специальные изменения программного кода. Кроме поставленных целей так же
способствует удобству их изменения в будущем, и конфигурации автоматизированного
развертывания окружения. 

Таким образом, цели практики были достигнуты в полном объёме, и система успешно
адаптирована к актуальной версии платформы с сохранением её функциональности и
улучшением пользовательского взаимодействия. По результатам работы был написан отчет в должной форме [8]. Далее остается получить отзыв руководителя практики.

#struct("СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ")

#set enum(numbering: "[1]")

+ Liferay.Learn - Upgrading Liferay : сайт. – URL: https://learn.liferay.com/w/dxp/installation-and-upgrades/upgrading-liferay (дата обращения: 20.04.2025)
+ Liferay.Help - Liferay DXP Quarterly Releases Compatibility Matrix : сайт. – URL: https://help.liferay.com/hc/en-us/articles/4411310034829-Liferay-DXP-Quarterly-Releases-Compatibility-Matrix (дата обращения: 20.04.2025)
+ Liferay.Learn - Installing on WildFly : сайт. – URL: https://learn.liferay.com/w/dxp/installation-and-upgrades/installing-liferay/installing-liferay-on-an-application-server/installing-on-wildfly (дата обращения: 20.04.2025)
+ Liferay.Help - PostgreSQL Client : сайт. – URL: https://learn.liferay.com/w/liferay-cloud/platform-services/database-service/using-the-database-client (дата обращения: 20.04.2025)
+ How to Setup Liferay Docker to Connect with PostgreSQL \/\/ Surekha Technologies : сайт. – URL: https://www.surekhatech.com/blog/how-to-setup-liferay-docker-to-connect-with-postgresql (дата обращения: 20.04.2025)
+ Oracle.com - JDK 17 Release Notes : сайт. – URL: https://www.oracle.com/java/technologies/javase/17-relnote-issues.html (дата обращения: 20.04.2025)
+ Maven Repository: javax.annotation » javax.annotation-api : сайт. – URL: https://mvnrepository.com/artifact/javax.annotation/javax.annotation-api (дата обращения: 20.04.2025)
+ ПРОИЗВОДСТВЕННАЯ ПРАКТИКА МАГИСТРАНТОВ: ОРГАНИЗАЦИЯ И ПРОВЕДЕНИЕ : учебно-методическое пособие / Т.А. Маркина, А.В. Пенской, Д.Г. Штенников [и др.]. – Санкт-Петербург : Университет ИТМО, 2020. – 50 с.


// #bibliography(
//   "dev-report-bibl.yml",
//   title: none,
//   full: true,
// )

#pagebreak()

#align(right)[#heading([ПРИЛОЖЕНИЕ 1], numbering: none)]

#align(center)[#heading("Листинг изменений конфигурации сборки", outlined: false, numbering: none)]

#v(1em)

```diff
diff --git a/site/blogs-hook/pom.xml b/site/blogs-hook/pom.xml
index eafea96..5d961b9 100644
--- a/site/blogs-hook/pom.xml
+++ b/site/blogs-hook/pom.xml
@@ -15,7 +15,8 @@
     </properties>
     <build>
         <plugins>
-            <plugin>
+            <!-- desable css builder plugin as css styles are taken from theme -->
+            <!-- <plugin>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.css.builder</artifactId>
                 <executions>
@@ -29,7 +30,7 @@
                 <configuration>
                     <docrootDirName>src/main/resources</docrootDirName>
                 </configuration>
-            </plugin>
+            </plugin> -->
             <plugin>
                 <groupId>org.apache.maven.plugins</groupId>
                 <artifactId>maven-compiler-plugin</artifactId>
diff --git a/site/calderys-form/pom.xml b/site/calderys-form/pom.xml
index 59d549a..0b95af3 100644
--- a/site/calderys-form/pom.xml
+++ b/site/calderys-form/pom.xml
@@ -81,6 +81,10 @@
             <groupId>javax.mail</groupId>
             <artifactId>mail</artifactId>
         </dependency>
+        <dependency>
+            <groupId>javax.annotation</groupId>
+            <artifactId>javax.annotation-api</artifactId>
+        </dependency>
     </dependencies>
     <repositories>
         <repository>
diff --git a/site/catalogue-portlet/pom.xml b/site/catalogue-portlet/pom.xml
index beb3237..b10953e 100644
--- a/site/catalogue-portlet/pom.xml
+++ b/site/catalogue-portlet/pom.xml
@@ -17,8 +17,8 @@
     <properties>
-        <scss.path>${project.basedir}/src/main/webapp/resources/css/</scss.path>
-        <scss.out>${project.basedir}/target/build-css/</scss.out>
     </properties>
 
     <build>
@@ -53,6 +53,8 @@
                     </execution>
                 </executions>
             </plugin>
+            <!-- remove as not needed: css brings from liferay theme -->
+            <!--
             <plugin>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.css.builder</artifactId>
@@ -62,16 +64,19 @@
                     <portalCommonPath>target/deps/com.liferay.frontend.css.common.jar</portalCommonPath>
                 </configuration>
             </plugin>
+            -->
             <plugin>
                 <artifactId>maven-war-plugin</artifactId>
                 <configuration>
-                    <packagingExcludes>**/*.scss</packagingExcludes>
                     <webResources>
                         <resource>
                             <directory>${scss.out}</directory>
                         </resource>
-                    </webResources>
+                    </webResources> -->
                 </configuration>
+                <version>3.4.0</version> <!-- latest version on mvnrepository.com -->
             </plugin>
         </plugins>
     </build>
diff --git a/site/ckeditor-plugins-hook/pom.xml b/site/ckeditor-plugins-hook/pom.xml
index d7ddc77..2557d8c 100644
--- a/site/ckeor-plugins-hook/pom.xml
+++ b/site/cketor-plugins-hook/pom.xml
@@ -14,7 +14,8 @@
 	</properties>
 	<build>
 		<plugins>
-			<plugin>
+            <!-- desable css builder plugin as css styles are taken from theme -->
+			<!-- <plugin>
 				<groupId>com.liferay</groupId>
 				<artifactId>com.liferay.css.builder</artifactId>
 				<executions>
@@ -28,7 +29,7 @@
 				<configuration>
 					<docrootDirName>src/main/resources</docrootDirName>
 				</configuration>
-			</plugin>
+			</plugin> -->
 			<plugin>
 				<groupId>org.apache.maven.plugins</groupId>
 				<artifactId>maven-compiler-plugin</artifactId>
diff --git a/site/pom.xml b/site/pom.xml
index 2007c71..501acc6 100644
--- a/site/pom.xml
+++ b/site/pom.xml
@@ -16,7 +16,7 @@
         <liferay.faces.bridge.version>4.0.0</liferay.faces.bridge.version>
         <faces.api.version>2.2</faces.api.version>
         <mojarra.version>2.2.18</mojarra.version>
-        <java.version>1.8</java.version>
+        <java.version>17</java.version>
         <source.encoding>UTF-8</source.encoding>
         <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
     </properties>
@@ -42,11 +42,10 @@
                 <!-- Most common plugins: compiler, resources, ... -->
                 <plugin>
                     <artifactId>maven-compiler-plugin</artifactId>
-                    <version>3.3</version>
+                    <version>3.11.0</version> <!-- use latest version due to stricter encapsulation in new version of jdk -->
                     <configuration>
                         <encoding>${source.encoding}</encoding>
-                        <source>${java.version}</source>
-                        <target>${java.version}</target>
+                        <release>${java.version}</release> <!-- use release as modern (java 9+) more safe approach -->
                     </configuration>
                 </plugin>
                 <plugin>
@@ -70,7 +69,7 @@
                 <!-- Java EE Plugins -->
                 <plugin>
                     <artifactId>maven-war-plugin</artifactId>
-                    <version>2.3</version>
+                    <version>3.4.0</version> <!-- update to latest version on mvnrepository -->
                     <configuration>
                         <filteringDeploymentDescriptors>true</filteringDeploymentDescriptors>
                     </configuration>
@@ -114,7 +113,7 @@
                 <plugin>
                     <groupId>com.liferay</groupId>
                     <artifactId>com.liferay.css.builder</artifactId>
-                    <version>2.0.1</version>
+                    <version>3.1.6</version>
                     <executions>
                         <execution>
                             <id>default-build</id>
@@ -172,6 +171,12 @@
                 <artifactId>hibernate-validator</artifactId>
                 <version>5.4.1.Final</version>
             </dependency>
+            <dependency>
+                <groupId>javax.annotation</groupId>
+                <artifactId>javax.annotation-api</artifactId>
+                <version>1.3.2</version>
+            </dependency>
+
 
             <!-- Liferay -->
             <dependency>
@@ -206,7 +211,7 @@
             <dependency>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.frontend.css.common</artifactId>
-                <version>2.0.4</version>
+                <version>6.0.18</version>
             </dependency>
 
 
@@ -224,7 +229,7 @@
             <dependency>
                 <groupId>org.projectlombok</groupId>
                 <artifactId>lombok</artifactId>
-                <version>1.18.2</version>
+                <version>1.18.30</version>
             </dependency>
             <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
             <dependency>
diff --git a/site/recent-bloggers-hook/pom.xml b/site/recent-bloggers-hook/pom.xml
index 94941ae..c4f3196 100644
--- a/site/recent-bloggers-hook/pom.xml
+++ b/site/recent-bloggers-hook/pom.xml
@@ -15,7 +15,8 @@
     </properties>
     <build>
         <plugins>
-            <plugin>
+            <!-- desable css builder plugin as css styles are taken from theme -->
+            <!-- <plugin>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.css.builder</artifactId>
                 <executions>
@@ -29,7 +30,7 @@
                 <configuration>
                     <docrootDirName>src/main/resources</docrootDirName>
                 </configuration>
-            </plugin>
+            </plugin> -->
             <plugin>
                 <groupId>org.apache.maven.plugins</groupId>
                 <artifactId>maven-compiler-plugin</artifactId>
diff --git a/site/tit-singlepage-theme/pom.xml b/site/tit-singlepage-theme/pom.xml
index c86fac7..1f58537 100644
--- a/site/tit-singlepage-theme/pom.xml
+++ b/site/tit-singlepage-theme/pom.xml
@@ -36,7 +36,8 @@
                 <configuration>
                     <packagingExcludes>**/*.scss</packagingExcludes>
                     <webResources>
-                        <resource>
+                        <!-- desable css builder plugin as css styles are taken from theme -->
+                        <!-- <resource>
                             <directory>${com.liferay.portal.tools.theme.builder.outputDir}</directory>
                             <excludes>
                                 <exclude>**/*.scss</exclude>
@@ -45,11 +46,11 @@
                         </resource>
                         <resource>
                             <directory>${com.liferay.css.builder.outputDir}</directory>
-                        </resource>
+                        </resource> -->
                     </webResources>
                 </configuration>
             </plugin>
-            <plugin>
+            <!-- <plugin>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.css.builder</artifactId>
                 <version>3.0.2</version>
@@ -66,7 +67,7 @@
                     <outputDirName>${com.liferay.css.builder.outputDir}</outputDirName>
                     <precision>9</precision>
                 </configuration>
-            </plugin>
+            </plugin> -->
             <plugin>
                 <groupId>com.liferay</groupId>
                 <artifactId>com.liferay.portal.tools.theme.builder</artifactId>

```
// #figure(
// ```
// ```, caption: [Изменения в конфигурации сборки модулей системы, требуемые для обновления платформы]) <maven-update>

#pagebreak()

#align(right)[#heading([ПРИЛОЖЕНИЕ 2], numbering: none)]

#align(center)[#heading([Листинг с изменениями конфигурации окружения],numbering: none, outlined: false)]
#v(1em)

// #figure(
```diff
diff --git a/wildfly-bundle/docker-compose.yml b/wildfly-bundle/docker-compose.yml
index b67a550..476b49a 100644
--- a/wildfly-bundle/docker-compose.yml
+++ b/wildfly-bundle/docker-compose.yml
@@ -14,7 +14,7 @@ services:
       - "5432:5432"
     restart: unless-stopped
     healthcheck:
-      test: [ "CMD-SHELL", "pg_isready" ]
+      test: [ "CMD-SHELL", "pg_isready -U postgres" ]
       interval: 1s
       timeout: 5s
       retries: 10
diff --git a/wildfly-bundle/download-packages.sh b/wildfly-bundle/download-packages.sh
index c226cff..17ea472 100644
--- a/wildfly-bundle/download-packages.sh
+++ b/wildfly-bundle/download-packages.sh
@@ -3,6 +3,6 @@ wget https://github.com/liferay/liferay-portal/releases/download/7.4.3.129-ga129
 wget https://github.com/liferay/liferay-portal/releases/download/7.4.3.129-ga129/liferay-portal-osgi-7.4.3.129-ga129-1733783976.zip
 wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.24-no-jdk-linux-x86_64.tar.gz
 wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-icu-7.17.24.zip
-wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-kuromoji-7.17.24.zip
-wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-smartcn-7.17.24.zip
-wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-icu/analysis-stempel-7.17.24.zip
\ No newline at end of file
+wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-7.17.24.zip
+wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-7.17.24.zip
+wget https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-stempel/analysis-stempel-7.17.24.zip
\ No newline at end of file
```
// , caption: [Изменения предложенные для исправления ошибок при запуске окружения]) <bundle-fix>