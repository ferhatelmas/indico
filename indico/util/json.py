# -*- coding: utf-8 -*-
##
##
## This file is part of Indico.
## Copyright (C) 2002 - 2014 European Organization for Nuclear Research (CERN).
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

try:
    import simplejson as _json
except ImportError:
    import json as _json

from datetime import datetime

from persistent.dict import PersistentDict

from ..core.config import Config
from .i18n import LazyProxy


class _JSONEncoder(_json.JSONEncoder):
    """
    Custom JSON encoder that supports more types
     * datetime objects
     * PersistentDict
    """
    def default(self, o):
        if isinstance(o, LazyProxy):
            return str(o)
        elif isinstance(o, PersistentDict):
            return dict(o)
        elif type(o) is datetime:
            return {'date': str(o.date()), 'time': str(o.time()), 'tz': str(o.tzinfo)}
        return _json.JSONEncoder.default(self, o)


def dumps(obj, **kwargs):
    """
    Simple wrapper around json.dumps()
    """
    if kwargs.pop('pretty', False):
        kwargs['indent'] = 4 * ' '
    textarea = kwargs.pop('textarea', False)
    ret = _json.dumps(obj, cls=_JSONEncoder, **kwargs).replace('/', '\\/')

    if textarea:
        return '<html><head></head><body><textarea>%s</textarea></body></html>' % ret
    else:
        return ret


def loads(string):
    """
    Simple wrapper around json.decode()
    """
    return _json.loads(string)


def create_json_error_answer(exception):
    return dumps({
        'version': Config.getInstance().getVersion(),
        'result': None,
        'error': exception.toDict()
    })
