function echo_variable(){
  echo '>>>>>>>>>>>>>echo in current shell'
  echo "LOCAL_VAR=${LOCAL_VAR}"
  echo "EXPORT_VAR=${EXPORT_VAR}"
  echo "BASH_ENV_CURRENT_STEP=${BASH_ENV_CURRENT_STEP}"
  echo "BASH_ENV_PREVIOUS_STEP=${BASH_ENV_ANOTHER_STEP}"

  echo '>>>>>>>>>>>>>echo in child shell'
  bash -c 'echo "LOCAL_VAR=${LOCAL_VAR}"'
  bash -c 'echo "EXPORT_VAR=${EXPORT_VAR}"'
  bash -c 'echo "BASH_ENV_CURRENT_STEP=${BASH_ENV_CURRENT_STEP}"'
  bash -c 'echo "BASH_ENV_PREVIOUS_STEP=${BASH_ENV_PREVIOUS_STEP}"'
}

LOCAL_VAR='local'
export EXPORT_VAR='export'
echo 'BASH_ENV_CURRENT_STEP=bash_env_current_step' >>${BASH_ENV}

cat <<EOT
--------------------------------------------------------
do not replace
--------------------------------------------------------
EOT
echo_variable

cat <<EOT
--------------------------------------------------------
replace BASH_ENV local
--------------------------------------------------------
EOT
BASH_ENV_CURRENT_STEP='replace local'
BASH_ENV_ANOTHER_STEP='replace local'

echo_variable

cat <<EOT
--------------------------------------------------------
replace BASH_ENV export
--------------------------------------------------------
EOT
export BASH_ENV_CURRENT_STEP='replace export'
export BASH_ENV_ANOTHER_STEP='replace export'

echo_variable

bash -xc '# nop'
