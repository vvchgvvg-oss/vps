#!/usr/bin/env python3
"""
Fail-closed placeholder for a future OS-level isolated runner.
Python audit hooks are not a security boundary and must never be used to run
untrusted tenant code. This panel intentionally does not execute tenant code.
"""
import sys

print("Execution refused: Python-level sandboxing is not a secure isolation boundary.", file=sys.stderr)
print("Run untrusted code only in a separately restricted container or VM.", file=sys.stderr)
sys.exit(78)
