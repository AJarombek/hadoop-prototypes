#!/usr/bin/env bash

# Commands to setup the Java environment to build Hadoop MapReduce applications.
# Author: Andrew Jarombek
# Date: 4/6/2020

# Install gradle with Homebrew
brew install gradle

# Confirm gradle is installed
gradle --version

# Find the gradle installation directory
which gradle

# List the tasks Gradle can execute
gradle tasks

# Execute the default Gradle tasks defined in build.gradle
gradle