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
Nonbookable dates of rooms
"""

from datetime import datetime

from indico.core.db import db, UTCDateTime


class NonBookableDate(db.Model):
    __tablename__ = 'room_nonbookable_dates'

    # columns

    # dates
    start_date = db.Column(
        UTCDateTime,
        nullable=False,
        primary_key=True
    )
    end_date = db.Column(
        UTCDateTime,
        nullable=False,
        primary_key=True
    )
    # room
    room_id = db.Column(
        db.Integer,
        db.ForeignKey('rooms.id'),
        primary_key=True,
        nullable=False
    )

    def __repr__(self):
        return '<NonBookableDate({0}, {1}, {2})>'.format(
            self.room_id,
            self.start_date,
            self.end_date
        )

    def toDict(self):
        return {
            'startDate': self.start_date,
            'endDate': self.end_date
        }

    def saveFromDict(self, d):
        if 'startDate' in d:
            self.start_date = d['startDate']

        if 'endDate' in d:
            self.start_date = d['endDate']

    def overlaps(self, st, et):
        return not (self.start_date >= et or self.end_date <= st)

    def isPast(self):
        return self.end_date <= datetime.utcnow()
