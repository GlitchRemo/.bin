#! /bin/bash

function style() {
  echo -e "\033[${2}m${1}\033[0m"
}

function red_fg() {
  style "$1" 31
}

function green_fg() {
  style "$1" 32
}

function yellow_fg() {
  style "$1" 33
}

function blue_fg() {
  style "$1" 34
}

function purple_fg() {
  style "$1" 35
}

function light_gray_bg() {
  style "$1" 37
}

function bold() {
  style "$1" 1
}

function underline() {
  style "$1" 4
}

function blink() {
  style "$1" 5
}
