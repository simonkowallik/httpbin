# -*- coding: utf-8 -*-

"""
httpbin-unit
~~~~~~~~~~~~

This module maps the callable 'app' to 'application', as required by unit.
"""
import httpbin

application = httpbin.app
