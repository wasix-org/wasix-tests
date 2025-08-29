#!/usr/bin/env bash

#####################################################################
##
## title: Assert Extension
##
## description:
## Assert extension of shell (bash, ...)
##   with the common assert functions
## Function list based on:
##   http://junit.sourceforge.net/javadoc/org/junit/Assert.html
## Log methods : inspired by
##	- https://natelandau.com/bash-scripting-utilities/
## author: Mark Torok
##
## date: 07. Dec. 2016
##
## license: MIT
##
#####################################################################

FAILED_ASSERTS=()
PASSED_ASSERTS=()


RED=
GREEN=
MAGENTA=
NORMAL=
BOLD=
if test -t 1 ; then
  if command -v tput &>/dev/null && tty -s; then
    RED=$(tput setaf 1 2>/dev/null || echo -en "\e[31m")
    GREEN=$(tput setaf 2 2>/dev/null || echo -en "\e[32m")
    MAGENTA=$(tput setaf 5 2>/dev/null || echo -en "\e[35m")
    NORMAL=$(tput sgr0 2>/dev/null || echo -en "\e[00m")
    BOLD=$(tput bold 2>/dev/null || echo -en "\e[01m")
  else
    RED=$(echo -en "\e[31m")
    GREEN=$(echo -en "\e[32m")
    MAGENTA=$(echo -en "\e[35m")
    NORMAL=$(echo -en "\e[00m")
    BOLD=$(echo -en "\e[01m")
  fi
fi

log_header() {
  printf "\n${BOLD}${MAGENTA}==========  %s  ==========${NORMAL}\n" "$@" >&2
}

# Empty placeholder varialble in format strings to avoid default
NONE=


log_success() {
  local msg="${1:-}"
  
  if test -z "$msg"; then
    MESSAGE="$(eval echo -ne "\"$default_success_msg\"")"
  elif [[ "$msg" != *'$'* ]]; then
    MESSAGE="$(eval echo -ne "\"$default_success_msg : $msg\"")"
  else
    MESSAGE="$(eval echo -ne "\"$msg\"")"
  fi

  PASSED_ASSERTS+=( "$MESSAGE" )
}

log_failure() {
  local msg="${1:-}"

  if test -z "$msg"; then
    MESSAGE="$(eval echo -ne "\"$default_error_msg\"")"
  elif [[ "$msg" != *'$'* ]]; then
    MESSAGE="$(eval echo -ne "\"$default_error_msg : $msg\"")"
  else
    MESSAGE="$(eval echo -ne "\"$msg\"")"
  fi

  FAILED_ASSERTS+=( "$MESSAGE" )
}

print_report() {
  PASSED_FORMAT="${GREEN}✔ %s${NORMAL}"
  FAILED_FORMAT="${RED}✘ %s${NORMAL}"

  local total=$(( ${#PASSED_ASSERTS[@]} + ${#FAILED_ASSERTS[@]} ))

  if [ "${#FAILED_ASSERTS[@]}" -gt 0 ]; then
    log_header "FAILED ASSERTS"
    for msg in "${FAILED_ASSERTS[@]}"; do
      printf "$FAILED_FORMAT\n" "$(echo -ne "$msg" | sed -z 's/\n/\n  /g')" >&2
    done
  fi

  if [ "${#PASSED_ASSERTS[@]}" -gt 0 ]; then
    log_header "PASSED ASSERTS"
    for msg in "${PASSED_ASSERTS[@]}"; do
      printf "$PASSED_FORMAT\n" "$(echo -ne "$msg" | sed -z 's/\n/\n  /g')" >&2
    done
  fi

  log_header "SUMMARY"
  printf "${BOLD}Total: %d, Passed: %d, Failed: %d${NORMAL}\n" "$total" "${#PASSED_ASSERTS[@]}" "${#FAILED_ASSERTS[@]}" >&2

  if [ "${#FAILED_ASSERTS[@]}" -gt 0 ]; then
    return 1
  else
    return 0
  fi
}

checkpoint() {
  if [ "${#FAILED_ASSERTS[@]}" -gt 0 ]; then
    print_report
    return 1
  fi
}

_assert_msg() {
  local default_error_msg='assertion failed'

  local failed=false
  if eval echo "$msg" > /dev/null ; then
    return
  else
    local previous_message="$msg"
    local msg=""
    local msg=
    log_failure 'Your assert message is not valid: \"$previous_message\"'
    failed=true
  fi
  
  if eval echo "$success_msg" > /dev/null ; then
    return
  else
    local previous_success_message="$success_msg"
    local success_msg=""
    local success_msg=
    log_failure 'Your assert message is not valid: \"$previous_success_message\"'
    failed=true
  fi

  "$failed" && return 1 || return 0
}

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  local default_success_msg='\"$expected\" == \"$actual\"'
  local default_error_msg='\"$expected\" != \"$actual\"'

  if [ "$expected" == "$actual" ]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_not_eq() {
  local expected="$1"
  local actual="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  local default_success_msg='\"$expected\" != \"$actual\"'
  local default_error_msg='\"$expected\" == \"$actual\"'

  if [ ! "$expected" == "$actual" ]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_true() {
  local actual="$1"
  local msg="${2-}"
  local success_msg="${3-}"
  _assert_msg || return 1

  local default_success_msg='$actual is true'
  local default_error_msg='\"$actual\" is not true'

  if [ ! true == "$actual" ]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_false() {
  local actual="$1"
  local msg="${2-}"
  local success_msg="${3-}"
  _assert_msg || return 1

  local default_success_msg='$actual is false'
  local default_error_msg='$expected is not false'

  if [ ! false == "$actual" ]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_empty() {
  local actual=$1
  local msg="${2-}"
  local success_msg="${3-}"
  _assert_msg || return 1

  local default_success_msg='\"$actual\" is empty'
  local default_error_msg='\"$actual\" is not empty'

  if test -z "$actual" ; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_not_empty() {
  local actual=$1
  local msg="${2-}"
  local success_msg="${3-}"
  _assert_msg || return 1

  local default_success_msg='\"$actual\" is not empty'
  local default_error_msg='\"$actual\" is empty'

  if test -n "$actual" ; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_contains() {
  local haystack="$1"
  local needle="${2-}"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  local default_success_msg='\"$haystack\" contains \"$needle\"'
  local default_error_msg='\"$haystack\" does not contain \"$needle\"'

  if [ -z "${needle:+x}" ]; then
    local default_success_msg='Everything contains nothing'
    log_success "$success_msg"
    return
  fi

  if [ -z "$haystack" ]; then
    local default_error_msg='Nothing contains nothing but nothing'
    log_failure "$msg"
    return
  fi

  if grep -q "$needle" <<< "$haystack"; then
    log_success "$success_msg"
    return
  fi

  log_failure "$msg"
  return
}

assert_not_contains() {
  local haystack="$1"
  local needle="${2-}"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  local default_success_msg='\"$haystack\" does not contain \"$needle\"'
  local default_error_msg='\"$haystack\" contains \"$needle\"'

  if [ -z "${needle:+x}" ]; then
    log_failure "$msg"
    return
  fi

  if [ -z "$haystack" ]; then
    log_success "$success_msg"
    return
  fi

  if [ "${haystack##*$needle*}" ]; then
    log_success "$success_msg"
    return
  fi

  log_failure "$msg"
  return
}

assert_gt() {
  local first="$1"
  local second="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  default_success_msg='$first > $second'
  default_error_msg='$first is not > $second'

  if [[ "$first" -gt  "$second" ]]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_ge() {
  local first="$1"
  local second="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  default_success_msg='$first >= $second'
  default_error_msg='$first is not >= $second'

  if [[ "$first" -ge  "$second" ]]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_lt() {
  local first="$1"
  local second="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  default_success_msg='$first < $second'
  default_error_msg='$first is not < $second'

  if [[ "$first" -lt  "$second" ]]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}

assert_le() {
  local first="$1"
  local second="$2"
  local msg="${3-}"
  local success_msg="${4-}"
  _assert_msg || return 1

  default_success_msg='$first <= $second'
  default_error_msg='$first is not <= $second'

  if [[ "$first" -le  "$second" ]]; then
    log_success "$success_msg"
  else
    log_failure "$msg"
  fi
}