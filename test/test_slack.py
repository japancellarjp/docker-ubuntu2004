#!/bin/python3

import sys
import os
from slack import WebClient
from slack.errors import SlackApiError

t = os.getenv('SLACK_API_TOKEN')
if t is None:
  print('env SLACK_API_TOKEN empty')
  exit(1)

args = sys.argv
c = '#general' if len(args) <= 1 else args[1]
m = 'Hello world!' if len(args) <= 2 else args[2]
client = WebClient(token=t)

try:
  response = client.chat_postMessage(
    channel = c,
    text = m)
  print(format(response['message']['text']))
except SlackApiError as e:
  print(fomat(e.response['error']))

