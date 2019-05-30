import os.path
import sys
from telethon import TelegramClient, sync, events
from telethon.tl import functions, types
_path = os.path.expanduser('~/dotfiles/')

f = functions
t = types
c = cl = client = bot = TelegramClient(
    _path + ('nnsd' if '-b' in sys.argv else 'lonami'),
    6, 'eb06d4abfb49dc3eeb1aeb98ae0f581e'
).start()
