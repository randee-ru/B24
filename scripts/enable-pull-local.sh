#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

docker compose exec -T app php <<'PHP'
<?php
$_SERVER["DOCUMENT_ROOT"] = "/var/www/html";
$_SERVER["SERVER_NAME"] = "localhost";

define("DOCUMENT_ROOT", "/var/www/html");
define("NOT_CHECK_PERMISSIONS", true);
define("NO_KEEP_STATISTIC", true);
define("NO_AGENT_STATISTIC", true);
define("NO_AGENT_CHECK", true);

require "/var/www/html/bitrix/modules/main/include.php";

COption::SetOptionString("pull", "nginx", "Y");
COption::SetOptionString("pull", "nginx_version", "2");
COption::SetOptionString("pull", "websocket", "Y");
COption::SetOptionString("pull", "push", "Y");
COption::SetOptionString("pull", "server_mode", "personal");
COption::SetOptionInt("pull", "config_timestamp", time());

echo "Pull module queue server options enabled.\n";
PHP
