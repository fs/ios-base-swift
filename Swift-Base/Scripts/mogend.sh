#!/bin/sh
#  mogend.sh

mogenerator --swift --model "${INPUT_FILE_PATH}/" --machine-dir "${PROJECT_DIR}/TwiageEMS/CoreData/Private/" --human-dir "${PROJECT_DIR}/TwiageEMS/CoreData/" --template-var arc=true

${DEVELOPER_BIN_DIR}/momc -XD_MOMC_TARGET_VERSION=10.7 "${INPUT_FILE_PATH}" "${TARGET_BUILD_DIR}/${EXECUTABLE_FOLDER_PATH}/${INPUT_FILE_BASE}.momd"

echo "Mogend.sh is done"