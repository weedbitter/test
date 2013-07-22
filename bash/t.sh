#!/bin/bash

echo "----------------------";
for arg in $@; do
	echo $arg;
done

echo "----------------------";
for arg in "$@"; do
	echo $arg;
done

echo "----------------------";
for arg in $*; do
	echo $arg;
done

echo "----------------------";
for arg in "$*"; do
	echo $arg;
done

