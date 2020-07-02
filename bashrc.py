import sys
from pathlib import Path
from subprocess import run

OUT_FILE = Path('.pybashrc')

def command(f):
    f._is_cmd = True
    return f

def is_command(f):
    return getattr(f, '_is_cmd', False)

@command
def vidtiny(height: int, *files: str):
    "usage: <height> [files...]"
    out = Path('vid.tiny')
    out.mkdir(parents=True, exist_ok=True)
    for file in files:
        run(['ffmpeg', '-i', file, '-filter:v', f'scale=trunc(oh*a/2)*2:{height}', '-c:a', 'copy', str(out / file)])

def main(args):
    if not args:
        this_py = Path(__file__).absolute()
        with OUT_FILE.open('w', encoding='utf-8') as fd:
            for cmd in filter(is_command, globals().values()):
                fd.write(f'''alias {cmd.__name__}="'/usr/local/bin/python3.7' '{this_py}' '{cmd.__name__}'"\n''')
    else:
        for cmd in filter(is_command, globals().values()):
            if cmd.__name__ == args[0]:
                try:
                    args = args[1:]
                    for i, name in enumerate(cmd.__code__.co_varnames):
                        if name in cmd.__annotations__:
                            args[i] = cmd.__annotations__[name](args[i])

                    quit(cmd(*args) or 0)
                except:
                    print(cmd.__doc__ or '(error, but no usage info)', file=sys.stderr)
                    quit(1)

if __name__ == '__main__':
    main(sys.argv[1:])
