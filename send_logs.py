#!/usr/bin/env python

from argparse import ArgumentParser
import time
#from pygtail import Pygtail
import subprocess

from google.cloud import logging

def main():

    f = subprocess.Popen(['tail','-F',args.file_name],\
        stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    while True:
       line = f.stdout.readline()
       send_log(logger=logger, line=line, log_name=log_name)


def send_log(logger, line, log_name):
    print(line)
    logger.log_text(line)


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--file_name', required=True,  help='Log File to watch')
    parser.add_argument('--log_name',  required=True,  help='Log Name')

    args = parser.parse_args()

    logging_client = logging.Client()
    logger = logging_client.logger(args.log_name)
    log_name = args.log_name

    main()


