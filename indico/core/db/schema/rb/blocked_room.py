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
Schema of blocked room (rejection and notification)
"""

from sqlalchemy import Column, String, Boolean, Integer, ForeignKey

from indico.core.db.schema import Base


class BlockedRoom(Base):
    __tablename__ = 'blocked_rooms'

    id = Column(Integer, primary_key=True)

    is_active = Column(Boolean, default=True)
    notification_sent = Column(Boolean, default=True)
    rejected_by = Column(String, nullable=False)
    rejection_reason = Column(String, nullable=True)

    blocking_id = Column(Integer, ForeignKey('blockings.id'))
    room_id = Column(Integer, ForeignKey('rooms.id'))
