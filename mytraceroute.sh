#!/bin/bash

traceroute -6 vnexpress.net | grep ' 1 ' |  awk '{print $2}'
