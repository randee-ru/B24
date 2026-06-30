# Bitrix24 Docker Dev Stack

Локальное окружение для коробочной версии Bitrix24 под разработку, отладку и учебные доработки.

## Что входит

- `app` - Apache + PHP 8.2
- `db` - MariaDB 10.11
- `redis` - кеш и сессии
- `phpmyadmin` - админка базы данных
- `mailhog` - просмотр исходящих писем

## Структура

- `docker/` - Dockerfile и PHP/Apache-конфиг
- `www/` - web-root Bitrix24, сюда распаковывается дистрибутив
- `scripts/` - вспомогательные скрипты установки
- `.env.example` - шаблон переменных окружения

## Быстрый старт

1. Создай `.env`:
   ```bash
   cp .env.example .env
   ```
2. Подними контейнеры:
   ```bash
   docker compose up -d --build
   ```
3. Если `www/` пустая, скачай и распакуй дистрибутив:
   ```bash
   ./scripts/bootstrap-bitrix.sh
   ```
4. Открой сайт:
   - Bitrix24: `http://localhost:8080/`
   - phpMyAdmin: `http://localhost:8081/`
   - MailHog: `http://localhost:8025/`

## Установка Bitrix24

Если архив дистрибутива ещё не распакован, выполни:

```bash
./scripts/bootstrap-bitrix.sh
```

Скрипт:

- создаёт `www/`, если его нет
- скачивает официальный архив Bitrix24
- распаковывает файлы в web-root
- оставляет сам дистрибутив вне Git, чтобы репозиторий не раздувался

После распаковки открой `http://localhost:8080/` и пройди мастер установки.

## Доступ к базе

- Host: `db`
- Port: `3306`
- Database: `bitrix24`
- User: `bitrix`
- Password: `bitrix`

## Текущая локальная установка

В этой рабочей копии Bitrix24 уже установлен и открывается по адресу:

- `http://localhost:8080/online/`

Локальный демонстрационный вход:

- login: `admin`
- password: `bitrix123`

## Что важно для разработки

- Свои доработки держи в `local/`
- Ядро `bitrix/` лучше не править напрямую
- Для записи нужны права на `upload/`, `bitrix/cache/`, `bitrix/managed_cache/`, `bitrix/tmp/` и `local/`
- Для отладки удобно включить Xdebug и работать через IDE

## Полезно

- Bitrix24 не стоит коммитить целиком в Git, если в репозиторий попадает полный дистрибутив
- База хранится в Docker volume `db_data`
- Если нужен полный сброс, проще удалить volume и повторить установку с нуля

## Команды

Запуск:

```bash
docker compose up -d
```

Пересборка:

```bash
docker compose up -d --build
```

Остановка:

```bash
docker compose down
```
