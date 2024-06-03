#!/bin/bash
adb shell "am startservice -e lat 48.9295 -e lon 2.0452 com.android.location.fused/.FusedLocationService"
