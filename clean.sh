#!/bin/bash

echo "$(date '+%Y-%m-%d %H:%M:%S') - Cleaning up directories..."

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing install directory..."
rm -rf install

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing software contents..."
rm -rf software/*

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing data directory..."
rm -rf data

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing checkpoints directory..."
rm -rf checkpoints

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing logs contents..."
rm -rf logs/*

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing output contents..."
rm -rf output/*

echo "$(date '+%Y-%m-%d %H:%M:%S') - Cleanup completed!"