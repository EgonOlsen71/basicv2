This directory contains some python scripts for testing. It's purpose is to check if an optimization has an impact on a test program or not.

To check:

run python compile.py  - to compile all test files

run python verify.py - to see how many files have changed since the last run

This indicates which files are actually affected by a change. This in itself is expected and not an error.
But it might be worth it to check these files to see if they still function as intended. If they do...you can

run python create_checksums.py

to update the checksums.