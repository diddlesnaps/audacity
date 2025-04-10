#!/bin/bash

set -e
set -E # ensure ERR trap is inherited by shell functions
set -o pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

MODELS="${SCRIPT_DIR}/models/openvino-models"
MUSICGEN_TMP="/tmp/musicgen_tmp"
MUSICGEN="${MODELS}/musicgen"
WHISPER_TMP="/tmp/whisper_tmp"
WHISPER="${MODELS}"
SEPARATION_TMP="/tmp/separation_tmp"
SEPARATION="${MODELS}"
SUPPRESSION_TMP="/tmp/suppression_tmp"
SUPPRESSION="${MODELS}"
RESOLUTION_TMP="/tmp/resolution_tmp"
RESOLUTION="${MODELS}/audiosr"

usage() {
  cat<< EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-b]

Manage the installation of OpenVINO™ AI models for Audacity in preparation for snapping.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-b, --batch     Install all models in non-interactive mode
EOF
  exit
}

cleanup() {
  RC=$?
  rm -rf "${MUSICGEN_TMP}" "${WHISPER_TMP}" "${SEPARATION_TMP}" "${SUPPRESSION_TMP}" "${RESOLUTION_TMP}"
  if [ "${RC}" -ne 0 ]; then
    echo "Warning: the script is not exiting normally. You may need to run again. Pass the -v flag to show debug info."
  fi
  exit "${RC}"
}

trap cleanup SIGINT SIGTERM ERR

silent() {
  if [ "${verbose}" = 'no' ]; then
    "$@" > /dev/null 2>&1
  else
    "$@"
  fi
}

musicgen_status() {
  if [ -d "${MUSICGEN}" ] && \
     [ "$(find "${MUSICGEN}" -maxdepth 1 -type f | wc -l)" = '12' ] && \
     [ "$(find "${MUSICGEN}/mono" -maxdepth 1 -type f | wc -l)" = '17' ] && \
     [ "$(find "${MUSICGEN}/stereo" -maxdepth 1 -type f | wc -l)" = '17' ]; then 
    echo ' (installed) '
  fi
  echo ''
}

whisper_status() {
  if [ -d "${WHISPER}" ] && \
     [ "$(find "${WHISPER}" -name 'ggml*' | wc -l)" = '9' ]; then
    echo ' (installed) '
  fi
  echo ''
}

separation_status() {
  if [ -d "${SEPARATION}" ] && \
     [ "$(find "${SEPARATION}" -name 'htdemucs_v4*' | wc -l)" = '2' ]; then
    echo ' (installed) '
  fi
  echo ''
}

suppression_status() {
  if [ -d "${SUPPRESSION}" ] && \
     [ "$(find "${SUPPRESSION}" -name 'noise-suppression-denseunet-ll-0001*' | wc -l)" = '2' ] && \
     [ "$(find "${SUPPRESSION}/deepfilternet2" -maxdepth 1 -type f | wc -l)" = '6' ] && \
     [ "$(find "${SUPPRESSION}/deepfilternet3" -maxdepth 1 -type f | wc -l)" = '6' ]; then 
    echo ' (installed) '
  fi
  echo ''
}

resolution_status() {
  if [ -d "${RESOLUTION}" ] && \
     [ "$(find "${RESOLUTION}" -maxdepth 1 -type f | wc -l)" = '13' ] && \
     [ "$(find "${RESOLUTION}/basic" -maxdepth 1 -type f | wc -l)" = '2' ] && \
     [ "$(find "${RESOLUTION}/speech" -maxdepth 1 -type f | wc -l)" = '2' ]; then 
    echo ' (installed) '
  fi
  echo ''
}

install_musicgen() {
  echo "
Downloading Music Generation models from Hugging Face. Please be patient!
  "
  silent git clone https://huggingface.co/Intel/musicgen-static-openvino "${MUSICGEN_TMP}"
  cd "${MUSICGEN_TMP}"
  silent git lfs install
  silent git lfs pull
  mkdir -p "${MUSICGEN}"
  silent unzip -o "${MUSICGEN_TMP}/musicgen_small_enc_dec_tok_openvino_models.zip" -d "${MUSICGEN}"
  silent unzip -o "${MUSICGEN_TMP}/musicgen_small_mono_openvino_models.zip" -d "${MUSICGEN}"
  silent unzip -o "${MUSICGEN_TMP}/musicgen_small_stereo_openvino_models.zip" -d "${MUSICGEN}"
  rm -rf "${MUSICGEN_TMP}"
  echo "Music Generation models (~2.8GB) successfully installed to ${MUSICGEN}"
}

install_whisper() {
  echo "
Downloading Whisper Transcription models from Hugging Face. Please be patient!
  "
  silent git clone https://huggingface.co/Intel/whisper.cpp-openvino-models "${WHISPER_TMP}"
  cd "${WHISPER_TMP}"
  silent git lfs install
  silent git lfs pull
  mkdir -p "${WHISPER}"
  silent unzip -o "${WHISPER_TMP}/ggml-base-models.zip" -d "${WHISPER}"
  silent unzip -o "${WHISPER_TMP}/ggml-small-models.zip" -d "${WHISPER}"
  silent unzip -o "${WHISPER_TMP}/ggml-small.en-tdrz-models.zip" -d "${WHISPER}"
  rm -rf "${WHISPER_TMP}"
  echo "Whisper Transcription models (~1.5GB) successfully installed to ${WHISPER}"
}

install_separation() {
  echo "
Downloading Music Separation models from Hugging Face. Please be patient!
  "
  silent git clone https://huggingface.co/Intel/demucs-openvino "${SEPARATION_TMP}"
  mkdir -p "${SEPARATION}"
  cp "${SEPARATION_TMP}/htdemucs_v4."{bin,xml} "${SEPARATION}"
  rm -rf "${SEPARATION_TMP}"
  echo "Music Separation models (~99MB) successfully installed to ${SEPARATION}"
}

install_suppression() {
  echo "
Downloading Noise Suppression models from Hugging Face. Please be patient!
  "
  silent git clone https://huggingface.co/Intel/deepfilternet-openvino "${SUPPRESSION_TMP}"
  cd "${SUPPRESSION_TMP}"
  silent git lfs install
  silent git lfs pull
  mkdir -p "${SUPPRESSION}"
  silent unzip -o "${SUPPRESSION_TMP}/deepfilternet2.zip" -d "${SUPPRESSION}"
  silent unzip -o "${SUPPRESSION_TMP}/deepfilternet3.zip" -d "${SUPPRESSION}"
  silent wget -O "${SUPPRESSION}/noise-suppression-denseunet-ll-0001.xml" "https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/noise-suppression-denseunet-ll-0001/FP16/noise-suppression-denseunet-ll-0001.xml"
  silent wget -O "${SUPPRESSION}/noise-suppression-denseunet-ll-0001.bin" "https://storage.openvinotoolkit.org/repositories/open_model_zoo/2023.0/models_bin/1/noise-suppression-denseunet-ll-0001/FP16/noise-suppression-denseunet-ll-0001.bin"
  rm -rf "${SUPPRESSION_TMP}"
  echo "Noise Suppression models (~27MB) successfully installed to ${SUPPRESSION}"
}

install_resolution() {
  echo "
Downloading Super Resolution models from Hugging Face. Please be patient!
  "
  silent git clone https://huggingface.co/Intel/versatile_audio_super_resolution_openvino "${RESOLUTION_TMP}"
  cd "${RESOLUTION_TMP}"
  silent git lfs install
  silent git lfs pull
  mkdir -p "${RESOLUTION}"
  silent unzip -o "${RESOLUTION_TMP}/versatile_audio_sr_base_openvino_models.zip" -d "${RESOLUTION}"
  silent unzip -o "${RESOLUTION_TMP}/versatile_audio_sr_ddpm_basic_openvino_models.zip" -d "${RESOLUTION}"
  silent unzip -o "${RESOLUTION_TMP}/versatile_audio_sr_ddpm_speech_openvino_models.zip" -d "${RESOLUTION}"
  rm -rf "${RESOLUTION_TMP}"
  echo "Super Resolution models (~2GB) successfully installed to ${RESOLUTION}"
}

build_model_menu() {
  model_menu="
-------------------------------------------------------------------------------------------------
| Audacity OpenVINO™ plugins support several AI models available for download from Hugging Face |
-------------------------------------------------------------------------------------------------

1. Music Generation$(musicgen_status)
2. Whisper Transcription$(whisper_status)
3. Music Separation$(separation_status)
4. Noise Suppression$(suppression_status)
5. Super Resolution$(resolution_status)
6. Exit

Some models are several GB in size, so be mindful of your available disk space and network speed.

To download and install a model, please select an option from the menu above and hit enter: "
}

parse_params() {
  verbose='no' # default behavior is to run commands silently
  batch_mode='no' # default behavior is interactive mode

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) verbose='yes' ;;
    -b | --batch) batch_mode='yes' ;;
    -?*) echo "Unknown option: $1" && exit 1 ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

loop_menu() {
  while :; do
    cd "${SCRIPT_DIR}"
    build_model_menu
    read -rp "${model_menu}" model_selection
    case "${model_selection}" in
      1) install_musicgen ;;
      2) install_whisper ;;
      3) install_separation ;;
      4) install_suppression ;;
      5) install_resolution ;;
      6) exit ;;
      *) echo "
Unknown option ${model_selection} selected." ;;
    esac
  done
}

parse_params "$@"

if [ "${batch_mode}" = 'yes' ]; then
  for model in musicgen whisper separation suppression resolution; do
    cd "${SCRIPT_DIR}"
    install_"${model}"
  done
else
  loop_menu
fi