#
# Copyright (C) 2020 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

AUDIO_TABLE_FOLDER := comet

# Platform Configuration for AudioHAL / SoundTriggerHAL
PRODUCT_COPY_FILES += \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_a2dp_offload_disabled.xml \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/audio_platform_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_configuration.xml \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/sound_trigger_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_configuration.xml

# AudioEffectHAL Configuration
PRODUCT_COPY_FILES += \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# Mixer Path Configuration for AudioHAL
PRODUCT_COPY_FILES += \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/config/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Speaker firmware files
SPK_FIRMWARE_PATH := $(AUDIO_TABLE_FOLDER)/cs35l41/fw
SPK_FIRMWARE_FULL_PATH := device/google/comet/audio/$(SPK_FIRMWARE_PATH)

PRODUCT_COPY_FILES += $(call copy-files,$(wildcard  $(SPK_FIRMWARE_FULL_PATH)/*),$(TARGET_COPY_OUT_VENDOR)/firmware)

# Audio tuning
PRODUCT_SOONG_NAMESPACES += device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/tuning
PRODUCT_PACKAGES += \
    recording.gatf \
    BLUETOOTH.dat \
    HANDSFREE.dat \
    HANDSET.dat \
    HEADSET.dat \
    mcps.dat \
    waves_config.ini \
    waves_preset.mps \
    compens_spk_l_1.conf \
    compens_spk_l_2.conf \
    compens_spk_r_1.conf \
    compens_spk_r_2.conf

# userdebug specific
PRODUCT_PACKAGES_DEBUG += \
    BLUETOOTH.mods \
    HANDSFREE.mods \
    HANDSET.mods \
    HEADSET.mods \
    template.xml \
    tuning_constraints_combination.xml \
    test_config.ini \
    test_preset.mps

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Mixer Path Configuration for Audio Speaker Calibration Tool crus_sp_cal
PRODUCT_COPY_FILES += \
    device/google/comet/audio/$(AUDIO_TABLE_FOLDER)/cs35l41/crus_sp_cal_mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/crus_sp_cal_mixer_paths.xml

endif
