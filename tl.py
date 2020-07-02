import os.path
import sys
import time
import logging
import asyncio
from datetime import date, datetime
logging.basicConfig(level=logging.INFO)
import telethon
from telethon import TelegramClient, sync, events, Button, functions, types, utils
_path = os.path.expanduser('~/dotfiles/')

def debug():
    for handler in logging.root.handlers[:]:
        logging.root.removeHandler(handler)
    logging.basicConfig(level=logging.DEBUG)

dbg = debug
f = functions
t = types
on = 'telethonchat'
off = 'telethonofftopic'
c = cl = client = bot = TelegramClient(
    _path + ('nnsd' if '-b' in sys.argv else 'lonami'),
    6, 'eb06d4abfb49dc3eeb1aeb98ae0f581e',
    flood_sleep_threshold=0
).start()
me = cl.get_me()
print(f'Running Telethon v{telethon.__version__}')
