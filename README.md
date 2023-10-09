# Домашнее задание №7 "Свой RPM в своем репозитории"
## Цель
1. научиться создавать свой RPM;
1. научится создавать свой репозиторий с RPM;

## Задание
1. создать свой RPM (можно взять свое приложение, либо собрать к примеру апач с определенными опциями);
1. создать свой репо и разместить там свой RPM;
1. реализовать это все либо в вагранте, либо развернуть у себя через nginx и дать ссылку на репо.

## Решение
1. При выполнении `vagrant up` разворачивается среда с настроенным репо 'lab6' (в процессе выполнятеся [скрипт](./script.sh)).
1. [Скрипт](./script.sh) выполняет следующие действия:
    - Устанавливает пакеты для работы с rpm
    - Скачивает исходники nginx
    - Правит nginx.spec (добавляет опцию `--with-openssl=/root/openssl-OpenSSL_1_1_1-stable \`)
    - Cобираем пакет nginx-1.20.2-1.el8.ngx.x86_64.rpm
    - Устанавливает из собранного пакета nginx и выполняет конфигурирование
    - Добавляет репозиторий lab6, с пакетом 'percona-orchestrator-3.2.6-2.el8.x86_64.rpm' и публикует в nginx.
    - Устанавливает пакет percona-orchestrator из репозитория lab6
## Результат
В результате мы получили свой rpm пакет nginx и создали репозиторий lab6
Результат работы дополнительно отражен на [скриншоте](./result.png)