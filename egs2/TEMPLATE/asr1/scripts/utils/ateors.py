#!/usr/bin/python

import telegram
import sys
import pathlib
import json


def ateors_send(message):
    token_file = pathlib.Path(__file__).parent.absolute() / 'token.json'
    with open(token_file, "r") as f:
        data = json.load(f)
    bot = telegram.Bot(token=data["token"])
    bot.sendMessage(chat_id=data["chat_id"], text=message)


if __name__ == '__main__':
    try:
        with open('HOST', 'r') as f:
            host = f.read().splitlines()[0]
    except FileNotFoundError:
        host = 'Unknown'

    message = f'[{host}]'

    if len(sys.argv) > 1:
        message += ' '.join(sys.argv[1:])
        message = message.replace('\\n', '\n')

    ateors_send(message)
