#!/bin/bash

# Configurações
SITE_URL="url-do-site" #substitua pela url do seu site
LOG_FILE="/var/log/monitoramento.log"
DISCORD_WEBHOOK="SUA_WEBHOOK_DO_DISCORD"  # Substitua pelo seu webhook

# Verifica se o site está acessível
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" $SITE_URL)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "[$TIMESTAMP] Site está funcionando. Status: $HTTP_STATUS" >> $LOG_FILE
else
    echo "[$TIMESTAMP] ALERTA: Site indisponível. Status: $HTTP_STATUS" >> $LOG_FILE
    # Envia notificação para o Discord (opcional)
    curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"⚠️ **ALERTA**: O site $SITE_URL está retornando status $HTTP_STATUS!\"}" $DISCORD_WEBHOOK
fi