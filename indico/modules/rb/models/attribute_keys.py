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
Attribute keys for rooms and reservations
"""

from indico.core.db import db


class AttributeKey(db.Model):
    __tablename__ = 'attribute_keys'

    # columns

    id = db.Column(
        db.Integer,
        primary_key=True
    )
    parent_id = db.Column(
        db.Integer,
        db.ForeignKey('attribute_keys.id')
    )
    name = db.Column(
        db.String,
        nullable=False,
        unique=True,
        index=True
    )
    is_for_rooms = db.Column(
        db.Boolean,
        nullable=False
    )
    is_for_reservations = db.Column(
        db.Boolean,
        nullable=False
    )

    # relationships

    children = db.relationship(
        'AttributeKey',
        backref=db.backref(
            'parent',
            remote_side=[id]
        )
    )
    location_attributes = db.relationship(
        'LocationAttribute',
        backref='key',
        cascade='all, delete-orphan'
    )
    room_attributes = db.relationship(
        'RoomAttribute',
        backref='key',
        cascade='all, delete-orphan'
    )
    reservation_attributes = db.relationship(
        'ReservationAttribute',
        backref='key',
        cascade='all, delete-orphan'
    )

    def __str__(self):
        return self.name

    def __repr__(self):
        return '<AttributeKey({0}, {1}, {2}, {3})>'.format(
            self.id,
            self.name,
            self.is_for_rooms,
            self.is_for_reservations
        )

    @staticmethod
    def getKeyByName(name):
        return AttributeKey.query.filter_by(name=name).first()

    @staticmethod
    def getAllKeys():
        return AttributeKey.query.all()

    @staticmethod
    def getAllReservationKeys():
        """All keys are also reservation key"""
        return AttributeKey.query.filter_by(is_for_reservations=True).all()

    @staticmethod
    def getAllRoomKeys():
        return AttributeKey.query.filter_by(is_for_rooms=True).all()