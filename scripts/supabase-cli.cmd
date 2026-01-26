@echo off
setlocal ENABLEDELAYEDEXPANSION

set IMAGE=jtdev0ps/supabase-cli:1.167.4

REM --- Parse network (optional) ---
set NETWORK_MODE=%1
set HAS_NETWORK=0

if not "%NETWORK_MODE%"=="" (
  set HAS_NETWORK=1
  echo Using Docker network mode: %NETWORK_MODE%
  shift
) else (
  echo Using Docker network mode: default
)

REM --- Collect remaining args into tokens ---
set FIRST_TOKEN=
set REMAINING_ARGS=

:collect
if "%1"=="" goto collected
if not defined FIRST_TOKEN (
  set FIRST_TOKEN=%1
) else (
  set REMAINING_ARGS=!REMAINING_ARGS! %1
)
shift
goto collect
:collected

REM --- Pull image if missing ---
docker image inspect %IMAGE% >nul 2>&1
if errorlevel 1 (
  docker pull %IMAGE%
)

REM --- Build docker base command ---
set DOCKER_RUN=docker run --rm -it --label "monocker.enable=false" -v "%cd%:/workspace" -w /workspace
if %HAS_NETWORK%==1 (
  set DOCKER_RUN=%DOCKER_RUN% --network %NETWORK_MODE%
)
set DOCKER_RUN=%DOCKER_RUN% %IMAGE%

REM --- Decide what to run ---
if not defined FIRST_TOKEN (
  echo ^> %DOCKER_RUN% sh
  %DOCKER_RUN% sh

) else if "%FIRST_TOKEN%"=="sh" (
  echo ^> %DOCKER_RUN% sh%REMAINING_ARGS%
  %DOCKER_RUN% sh%REMAINING_ARGS%

) else if "%FIRST_TOKEN%"=="bash" (
  echo ^> %DOCKER_RUN% bash%REMAINING_ARGS%
  %DOCKER_RUN% bash%REMAINING_ARGS%

) else if "%FIRST_TOKEN%"=="supabase" (
  REM Leading 'supabase' provided — do NOT duplicate it
  if not defined REMAINING_ARGS (
    echo ^> %DOCKER_RUN% supabase
    %DOCKER_RUN% supabase
  ) else (
    echo ^> %DOCKER_RUN% supabase%REMAINING_ARGS%
    %DOCKER_RUN% supabase%REMAINING_ARGS%
  )

) else (
  echo ^> %DOCKER_RUN% supabase %FIRST_TOKEN%%REMAINING_ARGS%
  %DOCKER_RUN% supabase %FIRST_TOKEN%%REMAINING_ARGS%
)

endlocal
