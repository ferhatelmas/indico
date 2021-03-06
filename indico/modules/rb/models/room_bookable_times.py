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

"""
Available times to book for rooms
"""

from sqlalchemy.ext.hybrid import hybrid_property

from indico.core.db import db
from indico.modules.rb.models.utils import getTimeDiff


class BookableTime(db.Model):
    __tablename__ = 'room_bookable_times'

    start_time = db.Column(
        db.Time,
        nullable=False,
        primary_key=True
    )
    end_time = db.Column(
        db.Time,
        nullable=False,
        primary_key=True
    )
    room_id = db.Column(
        db.Integer,
        db.ForeignKey('rooms.id'),
        primary_key=True,
        nullable=False
    )

    def __repr__(self):
        return '<BookableTime({0}, {1}, {2})>'.format(
            self.room_id,
            self.start_time,
            self.end_time
        )

    def toDict(self):
        return {
            'start_time': self.start_time,
            'end_time': self.end_time
        }

    def saveFromDict(self, d):
        if 'start_time' in d:
            self.start_time = d['start_time']

        if 'end_time' in d:
            self.start_time = d['end_time']

    def isFit(self, st, et):
        return self.start_time >= st and self.end_time <= et
