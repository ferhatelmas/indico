# -*- coding: utf-8 -*-
##
##
## This file is part of Indico.
## Copyright (C) 2002 - 2013 European Organization for Nuclear Research (CERN).
##
## Indico is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 3 of the
## License, or (at your option) any later version.
##
## Indico is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Indico;if not, see <http://www.gnu.org/licenses/>.

from flask import request

import os, string, copy
import logging.handlers, logging.config, logging
import ConfigParser

from MaKaC.common.Configuration import Config
from MaKaC.common.contextManager import ContextManager


class ExtraIndicoFilter(logging.Filter):

    def filter(self, record):
        if record.name.split('.')[0] == 'indico':
            return 0
        return 1


class IndicoMailFormatter(logging.Formatter):
    def format(self, record):
        s = logging.Formatter.format(self, record)
        return s + self._getRequestInfo()

    def _getRequestInfo(self):
        rh = ContextManager.get('currentRH', None)
        info = ['Additional information:']

        try:
            info.append('URL: %s' % request.url)
            info.append('Endpoint: %s' % request.url_rule.endpoint)
            info.append('Method: %s' % request.method)
            if rh:
                info.append('Params: %s' % rh._getTruncatedParams())
            info.append('IP: %s' % request.remote_addr)
            info.append('User Agent: %s' % request.user_agent)
            info.append('Referer: %s' % (request.referrer or 'n/a'))
        except RuntimeError, e:
            info.append('Not available: %s' % e)
        return '\n\n%s' % '\n'.join(info)


class LoggerUtils:

    @classmethod
    def _bootstrap_cp(cls, cp, defaultArgs):
        """
        Creates a very basic logging config for cases in which
        logging.conf does not yet exist
        """
        if not cp.has_section('loggers'):
            cp.add_section('loggers')
            cp.add_section('logger_root')
            cp.add_section('handlers')
            cp.set('loggers', 'keys', 'root')
            cp.set('logger_root', 'handlers', ','.join(defaultArgs))
            cp.set('handlers', 'keys', ','.join(defaultArgs))
            for handler_name in defaultArgs:
                section_name = 'handler_' + handler_name
                cp.add_section(section_name)
                cp.set(section_name, 'formatter', 'defaultFormatter')

    @classmethod
    def configFromFile(cls, fname, defaultArgs, filters):
        """
        Read the logging configuration from the logging.conf file.
        Fetch default values if the logging.conf file is not set.
        """
        cp = ConfigParser.ConfigParser()
        parsed_files = cp.read(fname)

        if cp.has_section('formatters'):
            formatters = logging.config._create_formatters(cp)
        else:
            formatters = {}

        # Really ugly.. but logging fails to import MaKaC.common.logger.IndicoMailFormatter
        # when using it in the class= option...
        if 'mailFormatter' in formatters:
            f = formatters.get('mailFormatter')
            if f:
                formatters['mailFormatter'] = IndicoMailFormatter(f._fmt, f.datefmt)

        # if there is a problem with the config file, set some sane defaults
        if not parsed_files:
            formatters['defaultFormatter'] = logging.Formatter("%(asctime)s %(name)-16s: %(levelname)-8s %(message)s")
            cls._bootstrap_cp(cp, defaultArgs)

        logging._acquireLock()
        try:
            logging._handlers.clear()
            del logging._handlerList[:]

            handlers = cls._install_handlers(cp, defaultArgs, formatters, filters)
            logging.config._install_loggers(cp, handlers, False)

        finally:
            logging._releaseLock()
        return handlers

    @classmethod
    def _install_handlers(cls, cp, defaultArgs, formatters, filters=None):
        """
        Install and return handlers. If a handler configuration
        is missing its args, fetches the default values from the
        indico.conf file
        """
        hlist = cp.get("handlers", "keys")
        hlist = hlist.split(",")
        handlers = {}
        fixups = [] #for inter-handler references

        for hand in hlist:
            sectname = "handler_%s" % hand.strip()
            opts = cp.options(sectname)
            if "class" in opts:
                klass = cp.get(sectname, "class")
            else:
                klass = defaultArgs[hand.strip()][0]
            if "formatter" in opts:
                fmt = cp.get(sectname, "formatter")
            else:
                fmt = ""
            klass = eval(klass, vars(logging))
            if "args" in opts:
                # if the args are not present in the file,
                # take default values
                args = cp.get(sectname, "args")
            else :
                try:
                    args = defaultArgs[hand.strip()][1]
                except KeyError:
                    continue
            args = eval(args, vars(logging))
            h = apply(klass, args)
            if "level" in opts:
                level = cp.get(sectname, "level")
                h.setLevel(logging._levelNames[level])
            else:
                h.setLevel(logging._levelNames[defaultArgs[hand.strip()][2]])
            if len(fmt):
                h.setFormatter(formatters[fmt])
            if filters and hand.strip() in filters:
                for fltr in filters[hand.strip()]:
                    h.addFilter(fltr)
            #temporary hack for FileHandler and MemoryHandler.
            if klass == logging.handlers.MemoryHandler:
                if "target" in opts:
                    target = cp.get(sectname,"target")
                else:
                    target = ""
                if len(target): #the target handler may not be loaded yet, so keep for later...
                    fixups.append((h, target))
            handlers[hand] = h
        #now all handlers are loaded, fixup inter-handler references...
        for h, t in fixups:
            h.setTarget(handlers[t])
        return handlers


class Logger:
    """
    Encapsulates the features provided by the standard logging module
    """

    @classmethod
    def initialize(cls):
        # Lists of filters for each handler
        filters = {'indico' : [logging.Filter('indico')],
                   'other'  : [ExtraIndicoFilter()],
                   'smtp'   : [logging.Filter('indico')]}

        config = Config.getInstance()

        logConfFilepath = os.path.join(config.getConfigurationDir(), "logging.conf")

        smtpServer = config.getSmtpServer()
        serverName = config.getWorkerName()
        if not serverName:
            serverName = config.getHostNameURL()

        # Default arguments for the handlers, taken mostly for the configuration
        defaultArgs = { 'indico' : ("FileHandler", "('%s', 'a')" % cls._log_path('indico.log'), 'DEBUG'),
                        'other'  : ("FileHandler", "('%s', 'a')" % cls._log_path('other.log'), 'DEBUG'),
                        'smtp'   : ("handlers.SMTPHandler", "(%s, 'logger@%s', ['%s'], 'Unexpected Exception occurred at %s')"
                        % (smtpServer, serverName, config.getSupportEmail(), serverName), "ERROR")
                    }

        cls.handlers = LoggerUtils.configFromFile(logConfFilepath, defaultArgs, filters)
    @classmethod
    def reset(cls):
        """
        Reset the config, using new paths, etc (useful for testing)
        """
        if cls.handlers:
            for handler in copy.copy(cls.handlers):
                cls.removeHandler(handler)

        cls.initialize()

    @classmethod
    def removeHandler(cls, handlerName):
        if cls.handlers:
            handler = cls.handlers.get(handlerName)

            if handler:
                del cls.handlers[handlerName]
                logging.root.handlers.remove(handler)

    @classmethod
    def get(cls, module=None):
        return logging.getLogger('indico' if module == None else 'indico.' + module)

    @classmethod
    def _log_path(cls, fname):
        config = Config.getInstance()
        configDir = config.getLogDir()
        fpath = os.path.join(configDir, fname)

        if not os.access(os.path.dirname(fpath), os.W_OK):
            # if the file in the config is not accessible, use a "local" one
            fpath = os.path.join(os.getcwd(), '.indico.log')

        return fpath.replace('\\', '\\\\')


Logger.initialize()
