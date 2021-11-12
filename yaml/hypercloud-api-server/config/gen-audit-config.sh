#!/bin/bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
API_SERVER_HOME="${SCRIPTDIR}/hypercloud-api-server/"
sudo cp /etc/kubernetes/pki/hypercloud-root-ca.crt .
export HYPERCLOUD5_CA_CERT=$(openssl base64 -A <"hypercloud-root-ca.crt")
rm -f hypercloud-root-ca.crt

AUDIT_CONFIG_FILE=audit-webhook-config
if [ -f ${API_SERVER_HOME}/config/"$AUDIT_CONFIG_FILE" ]; then
   echo "Remove existed audit config file."
   rm -f ${API_SERVER_HOME}/config/$AUDIT_CONFIG_FILE
fi

echo "Generate audit config file."
envsubst < ${API_SERVER_HOME}/config/"$AUDIT_CONFIG_FILE".template  > ${API_SERVER_HOME}/config/"$AUDIT_CONFIG_FILE"
