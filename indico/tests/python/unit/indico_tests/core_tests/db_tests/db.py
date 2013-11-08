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

from flask.ext.testing import TestCase

from indico.core.db import db, load_room_booking
from indico.web.flask.app import make_app


class DBTest(TestCase):

    SQLALCHEMY_DATABASE_URI = "sqlite:///:memory:"
    TESTING = True

    def create_app(self):
        app = make_app()
        db.init_app(app)
        return app

    def setUp(self):
        load_room_booking()
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()
