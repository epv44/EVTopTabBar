#!/bin/sh

PATH=$(bash -l -c 'echo $PATH')

jazzy -x -workspace,Example/EVTopTabBar.xcworkspace,-scheme,EVTopTabBar-Example
