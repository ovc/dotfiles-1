#!/usr/bin/env python3
# Get conents from an input email file.

import argparse
import email
import sys

import html2text

def _decode_bytes(baffelblag):
        if type(baffelblag) is bytes:
            codecs = ['utf8', 'iso-8859-1', 'cp1252']
            for codec in codecs:
                try:
                    return baffelblag.decode(codec)
                except:
                    pass
        else:
            return baffelblag

def parse_args():
    parser = argparse.ArgumentParser(description="Get info from an input email.")
    parser.add_argument('email_file', type=argparse.FileType('r'), help='The email file to read from.')
    cmd_grop = parser.add_mutually_exclusive_group(required=True)
    cmd_grop.add_argument('--fromf', action='store_true', help='The "From:" field.')
    cmd_grop.add_argument('--subject', action='store_true', help='The "Subject:" field.')
    cmd_grop.add_argument('--body', action='store_true', help='The body.')

    args = parser.parse_args()
    return args.email_file, args.fromf, args.subject, args.body

def main():
    email_file, fromf, subject, body = parse_args()

    # TODO broken on latin-1 input.
    message = email.message_from_file(email_file)
    #message_in = email_file.read()
    #message = email.message_from_string(message_in)
    if fromf:
        from_str = _decode_bytes(email.header.decode_header(message['from'])[0][0])
        print("{:s}".format(from_str))
    elif subject:
        subject_str = _decode_bytes(email.header.decode_header(message['subject'])[0][0])
        print("{:s}".format(subject_str))
    elif body:
        for part in message.walk():
            if part.get_content_type() == 'text/plain':
                body_str = _decode_bytes(part.get_payload(decode=True))
                break
            elif part.get_content_type() == 'text/html':
                body_str = _decode_bytes(part.get_payload(decode=True))
                h2txt = html2text.HTML2Text()
                h2txt.ignore_links = True
                #h2txt.body_width = 80
                body_str = h2txt.handle(body_str)

        print("{:s}".format(body_str))
    return 0

if __name__ == '__main__':
    sys.exit(main())