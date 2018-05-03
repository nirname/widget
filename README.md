# Widget API

Приложение для выдачи пользователям сообщений по разным критериям.

## Запуск

Скопируйте `env.yml.example`

    cp config/env.yml.example config/env.yml

Или пропишите в `config/env.yml` собственный адрес сервиса:

    development: &default
      WIDGET_API_URL: "http://localhost:4000"

    test: *default
    production: *default

Запустите локально:

    rails s -p 4000

или через Docker:

    make

Приложение будет доступно по адресу `http://localhost:4000`

## Подключение

Вставьте к себе страницу сразу перед закрывающимся тегом `</head>` тег `<script type="text/javascript">` со следующим содержимым:

```
(function() {
  if ("undefined" === typeof widget_api) {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.async = true;
    script.src = "http://localhost:4000/api.js";
    var target = document.getElementsByTagName("head")[0];
    target.appendChild(script);
    widget_api = {};
    widget_api.queue = [];
    methods = ['showWidget', 'closeWidget', 'submitWidget', 'addCallback', 'removeCallback'];
    function enqueue_method(name, args) {
      return function() {
        window.widget_api.queue.push(name, arguments);
      }
    }
    for (var i = 0; i < methods.length; i++) {
      widget_api[methods[i]] = enqueue_method(methods[i]);
    }
  }
})();
```

Замените `http://locahost:4000` на актуальный адрес сервиса.

## Документация

После загрузки на странице будет доступен javascript-объект `widget_api` со следующими методами:

### Показать виджет

    showWidget(name)

    name - строка, имя виджета

    widget_api.showWidget("Sample")

### Закрыть виджет

    closeWidget(name)

    name - строка, имя виджета

    widget_api.closeWidget("Sample")

### Отправить виджет

    submitWidget(name)

    name - строка, имя виджета

    widget_api.submitWidget("Sample")

### Добавить коллбэк

    addCallback(topic, callback)

    topic - строка, имя коллбэка
    возможные значения

    closeWidget
    submitWidget
    showWidget

    addCallback("submitWidget", function(){ alert("Hello"); })

### Убрать коллбэк

    removeCallback(topic, callback)

## План

Системные вещи:

* ~~Сделать виджет неблокирующим!~~
* ~~API~~
* Показывать виджет 2 раза (добавить timestamp или id)
* Компилировать api.js и отдавать статично
* Удалять script из dom после выполнения?
* ~~Переделать eventLister на apply если это безопасно~~
* Тип виджета (popup) вынести в настройки
* ~~Сделать showWidget (без указания типа виджета)~~
* Не запрашивать js, запрашивать только json
* Завернуть в docker-compose
* Переименовать `WIDGET_API_URL` в `WIDGET_URL` или `SELF_URL`
* Переименовать в github (убрать `_API`)
* Не хранить кнопку закрытия в разметке виджета (добавлять динамически)

Фильтры:
* ~~Свойства пользователя (любые сочетания полей, групп а/б тестов и тд)~~
* ~~URL~~
* Фильтр виджетов по времени

Виджет:
* ~~Скрипт для вставки на страницу~~
* ~~Поп-ап можно скрыть нажатием на крестик~~

Опции:
* ~~Задержка - возможность показывать виджет через 20 секунд~~
* ??? Как реализовать задержку ??? (Собирать события и сделать задержку по ним)
* Повторность - показывать один раз или каждый раз, когда выполняются условия (требует сбора данных)

Статистика:
* Сколько людей увидело попап
* Сколько кликнуло
* Сколько скрыло его

Дополнительно:
* Сверстать расположение
* Прописать условия показа конкретоного виджета
* Описать, какие показатели хотим видеть
* Обновить картинку виджета
* АБ-тест
* Протестировать
* Обновить примеры

## Поправить

```
(index):89 GET localhost:4000/api.js net::ERR_UNKNOWN_URL_SCHEME
```

```
api.js:15 Uncaught TypeError: Cannot read property 'insertBefore' of undefined
    at widget_api.showWidget (api.js:15)
    at api.js:94
```