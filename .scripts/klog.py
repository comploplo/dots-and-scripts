#!/usr/bin/python

import os
from collections import Counter
import sys
import random
import pyxhook

log_file = os.path.expanduser('~/.cache/klog.log')
def log(s):
    print(s)
    with open(log_file, 'a') as f:
        f.write(s)

def read_log():
    with open(log_file) as f:
        return f.readlines()

def get_keypress_callback():
    maxbuff= 32
    buffer = []

    def on_key_press(event):
        if event.Key == "Shift_L":
            return
        buffer.append(event.Key)

        if len(buffer) >= maxbuff:
            # make bigrams by zipping the two lists
            bigrams = list(zip(buffer[:-1], buffer[1:]))
            buffer.clear()
            random.shuffle(bigrams)
            # get rid of one random bigram for the sake of not logging everything
            for bigram in bigrams[:-1]:
                log('{} {}\n'.format(*bigram))

    return on_key_press

def record():
    hook = pyxhook.HookManager()
    hook.KeyDown = get_keypress_callback()
    hook.HookKeyboard()
    hook.start()

def bigram_freqs():
    with open(log_file) as f:
        bigrams = iter(tuple(line[:-1].split(" ")) for line in f)
        bigram_freqs = Counter(bigrams)
    for k in reversed(bigram_freqs.most_common()):
        print("{:<4} {:<12} {:<8}".format(
            str(k[1]).rjust(
                len(str(
                    bigram_freqs.most_common()[0][1]
                )),
                " "
            ),
            k[0][0],
            k[0][1]
        ))

def key_freqs(symbols_only=False):
    relevant_syms = ["BackSpace","braceright","braceleft","parenright","quotedbl","parenleft","underscore","colon","minus","equal","bracketleft","semicolon","bracketright","plus","percent","asterisk","numbersign","exclam","apostrophe","backslash","dollar","question","asciitilde","at","bar","ampersand","asciicircum","grave"]
    with open(log_file) as f:
        bigrams = iter(line.split(" ") for line in f)
        key_freqs = Counter(iter(
            bigram[0] for bigram in bigrams if not symbols_only or (bigram[0] in relevant_syms)
            # bigram[0] for bigram in bigrams if not (len(bigram[0]) <= 1 and symbols_only)
        ))
    for k in reversed(key_freqs.most_common()):
        print("{:<5} {}".format(
            k[1],
            k[0]
        ))

def print_help():
    print("--record           -r:   record keys to ~/.cache/klog.log")
    print("--key-frequency    -k:   print key frequencies")
    print("--bigram-frequency -b:   print bigram frequencies (there are ordered bigrams i.e. ka != ak)")
    print("--symbol-frequency -s:   print key frequencies excluding those whose keysyms are one character")

if __name__ == "__main__":
    args = sys.argv[1:]
    if args in [[], ["--record"], ["-r"]]:
        record()
    elif args in [["--key-frequency"], ["-k"]]:
        key_freqs()
    elif args in [["--symbol-frequency"], ["-s"]]:
        key_freqs(symbols_only=True)
    elif args in [["--bigram-frequency"], ["-b"]]:
        bigram_freqs()
    elif args in [["-h"], ["--help"]]:
        print_help()

    # if len(buffer) >= maxbuff:
        # # calculate bigram frequencies
        # freqs = dict()
        # for i, k in enumerate(buffer[:-1]):
        #     modifiers = ["Super_L", "Super_R", "Control_L", "Control_R", "Alt_L", "Alt_R"]
        #     bigram = buffer[i:i+2]
        #     # Don't sort bigrams if they've got modifiers, because theyre not equivalent when reversed
        #     if not any([mod in bigram for mod in modifiers]):
        #         bigram = sorted(bigram)
        #
        #     if bigram in freqs:
        #         freqs[bigram] += 1
        #     else:
        #         freqs[bigram] = 1
        #
