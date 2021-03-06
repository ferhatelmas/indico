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

from datetime import date, datetime, time, timedelta
from random import randint
from os import urandom

from indico.modules.rb.models.reservations import RepeatUnit


BLOCKING_PRINCIPALS = [
    {
        'entity_type': 'avatar',
        'entity_id': 'tim'
    }
]


BLOCKED_ROOMS = [
    {
        'is_active': True,
        'notification_sent': True,
        'rejected_by': None,
        'rejection_reason': None,
        'room': 'main-meeting-hall'
    }
]


BLOCKINGS = [
    {
        'created_by': 'admin',
        'created_at': datetime(2013, 11, 1, 8),
        'start_date': datetime(2013, 12, 15, 8),
        'end_date': datetime(2013, 12, 15, 17, 30),
        'reason': 'maintenance',
        'blocked_rooms': BLOCKED_ROOMS,
        'allowed': BLOCKING_PRINCIPALS
    }
]


RESERVATION_ATTRIBUTES = [
    {
        'name': 'AVC',
        'raw_data': '{"is_used": false}'
    },
    {
        'name': 'Vidyo',
        'raw_data': '{"is_used": true, "comment": "actually optional in case needed"}'
    },
    {
        'name': 'Assistance',
        'raw_data': '{"is_used": true}'
    },
    {
        'name': 'HERMES Collaboration',
        'raw_data': '{"is_used": true}'
    },
]


RESERVATION_EDIT_LOGS = [
    {
        'timestamp': datetime(2013, 12, 2, 11, 33, 57),
        'avatar_id': 'johhny',
        'info': 'name updated```flag is cleared'
    },
    {
        'timestamp': datetime(2013, 12, 2, 11, 34, 17),
        'avatar_id': 'admin',
        'info': 'removed bad words from reason```some value changed```set flag'
    }
]


RESERVATION_NOTIFICATIONS = [
    # auto generated
]


RESERVATION_EXCLUDED_DAYS = [
    date(2013, 12, 8),
    date(2014, 4, 6),
    date(2013, 12, 19),
    date(2014, 1, 1),
    date(2014, 1, 2),
    date(2014, 1, 3),
    date(2014, 1, 4),
    date(2014, 1, 5),
]


RESERVATIONS = [
    {
        'created_at': datetime(2013, 12, 2, 11, 30),
        'start_date': datetime(2013, 12, 5, 10),
        'end_date': datetime(2013, 12, 5, 12),
        'repeat_unit': RepeatUnit.NEVER,
        'booked_for_id': 'admin',
        'booked_for_name': 'admin',
        'created_by': 'admin',
        'is_confirmed': True,
        'reason': 'This is what I want',
        'attributes': RESERVATION_ATTRIBUTES,
        'edit_logs': RESERVATION_EDIT_LOGS,
    },
    {
        'created_at': datetime(2013, 11, 2, 11, 30),
        'start_date': datetime(2013, 12, 1, 8),
        'end_date': datetime(2013, 12, 30, 10),
        'repeat_unit': RepeatUnit.WEEK,
        'repeat_step': 1,
        'booked_for_id': 'admin',
        'booked_for_name': 'admin root',
        'created_by': 'admin',
        'is_confirmed': True,
        'reason': 'weekly group meetings',
        'contact_email': 'admin@cern.ch',
        'attributes': RESERVATION_ATTRIBUTES[1:3],
        'excluded_days': RESERVATION_EXCLUDED_DAYS[:1]
    },
    {
        'created_at': datetime(2013, 11, 30, 17),
        'start_date': datetime(2013, 12, 1, 15),
        'end_date': datetime(2014, 12, 1, 15),
        'repeat_unit': RepeatUnit.MONTH,
        'repeat_step': 1,
        'booked_for_id': 'admin',
        'booked_for_name': 'admin root',
        'created_by': 'admin',
        'is_confirmed': True,
        'reason': 'confidential',
        'attributes': RESERVATION_ATTRIBUTES[1:3],
        'excluded_days': RESERVATION_EXCLUDED_DAYS[1:2]
    },
    {
        'created_at': datetime(2013, 12, 1, 11, 30),
        'start_date': datetime(2013, 12, 1, 12),
        'end_date': datetime(2013, 12, 2, 14),
        'repeat_unit': RepeatUnit.NEVER,
        'booked_for_id': 'tim',
        'booked_for_name': 'tim ferref',
        'created_by': 'admin',
        'is_confirmed': True,
        'is_cancelled': True,
        'reason': 'can not be null',
        'attributes': RESERVATION_ATTRIBUTES[3:],
    },
    {
        'created_at': datetime(2013, 12, 20),
        'start_date': datetime(2014, 1, 1, 8),
        'end_date': datetime(2014, 1, 1, 12),
        'repeat_unit': RepeatUnit.NEVER,
        'booked_for_id': 'john',
        'booked_for_name': 'john kusack',
        'created_by': 'john',
        'is_confirmed': False,
        'is_rejected': True,
        'reason': 'extra',
        'attributes': RESERVATION_ATTRIBUTES[3:],
    },
    {
        'created_at': datetime(2012, 1, 1, 12),
        'start_date': datetime(2013, 12, 5, 10),
        'end_date': datetime(2013, 12, 5, 12),
        'repeat_unit': RepeatUnit.NEVER,
        'booked_for_id': 'fred',
        'booked_for_name': 'fred williams',
        'created_by': 'frankenstein',
        'is_confirmed': True,
        'reason': 'no reason, he just wanted me to book',
        'attributes': RESERVATION_ATTRIBUTES,
    },
    {
        'created_at': datetime(2008, 3, 3, 3, 3, 3),
        'start_date': datetime(2013, 12, 5, 10),
        'end_date': datetime(2013, 12, 5, 12),
        'repeat_unit': RepeatUnit.NEVER,
        'booked_for_id': 'tim',
        'booked_for_name': 'tim',
        'created_by': 'admin',
        'is_confirmed': True,
        'reason': 'big day for me',
        'attributes': RESERVATION_ATTRIBUTES,
    },
    {
        'created_at': datetime(2013, 11, 11, 11, 1, 1),
        'start_date': datetime(2013, 12, 5, 10),
        'end_date': datetime(2013, 1, 2, 12),
        'repeat_unit': RepeatUnit.WEEK,
        'repeat_step': 2,
        'booked_for_id': 'felmas',
        'booked_for_name': 'ferhat elmas',
        'created_by': 'felmas',
        'is_confirmed': False,
        'is_rejected': True,
        'reason': 'testing',
        'attributes': RESERVATION_ATTRIBUTES,
        'excluded_days': RESERVATION_EXCLUDED_DAYS[2:3]
    },
    {
        'created_at': datetime(2013, 12, 1, 23, 59),
        'start_date': datetime(2013, 9, 17, 8),
        'end_date': datetime(2014, 3, 15, 17),
        'repeat_unit': RepeatUnit.DAY,
        'repeat_step': 1,
        'booked_for_id': 'felmas',
        'booked_for_name': 'ferhat elmas',
        'created_by': 'pferreir',
        'is_confirmed': True,
        'reason': 'special testing',
        'attributes': RESERVATION_ATTRIBUTES,
        'excluded_days': RESERVATION_EXCLUDED_DAYS[3:]
    },
    {
        'created_at': datetime(2013, 12, 31, 23, 59),
        'start_date': datetime(2014, 1, 1, 0),
        'end_date': datetime(2014, 1, 1, 1),
        'repeat_unit': RepeatUnit.NEVER,
        'repeat_step': 1,
        'booked_for_id': 'felmas',
        'booked_for_name': 'ferhat elmas',
        'created_by': 'pferreir',
        'is_confirmed': True,
        'reason': 'special testing',
    }
]


ROOM_ATTRIBUTES = [
    {
        'name': 'Manager Group',
        'raw_data': '{"access_list": ["a@abc.com", "b@abc.com"]}'
    },
    {
        'name': 'Map URL',
        'raw_data': '{"google": "http://maps.google.com",'
                     '"openstreetmap": "http://openstreetmap.org"}'
    },
    {
        'name': 'Test',
        'raw_data': '{"comment": "test_room"}'
    }
]


ROOM_EQUIPMENTS = [
    'Blackboard',
    'Computer Projector',
    'Ethernet',
    'Telephone conference',
    'Wireless',
    'PC',
    'Video conference',
    'Telephone line',
    'Webcast/Recording',
    'Microphone',
    'Whiteboard'
]


ROOM_BOOKABLE_TIMES = [
    {
        'start_time': time(8),
        'end_time': time(18, 30)
    },
    {
        'start_time': time(19),
        'end_time': time(23, 59, 59)
    }
]


ROOM_NONBOOKABLE_DATES = [
    {
        'start_date': datetime(2013, 12, 20, 17, 30),
        'end_date': datetime(2014, 1, 6, 8)
    }
]


PHOTOS = [
    {
        'small_content': urandom(randint(0, 1024)),
        'large_content': urandom(randint(1025, 4096))
    },
    {
        'small_content': urandom(randint(0, 1024)),
        'large_content': urandom(randint(1025, 4096))
    }
]


ROOMS = [
    {
        'name': 'reception',
        'site': 'meyrin',
        'division': 'admin',
        'building': '33',
        'floor': '1',
        'number': '0',
        'is_active': True,
        'is_reservable': False,
        'owner_id': 'admin',
        'nonbookable_dates': ROOM_NONBOOKABLE_DATES,
        'bookable_times': ROOM_BOOKABLE_TIMES[:1],
        'reservations': RESERVATIONS[:9],
        'photos': PHOTOS,
        'equipments': ['PC']
    },
    {
        'name': 'main-meeting-hall',
        'site': 'meyrin',
        'division': 'IT-AVS-CIS',
        'building': '513',
        'floor': '2',
        'number': '001',
        'is_active': True,
        'is_reservable': True,
        'owner_id': 'tim',
        'reservations_need_confirmation': True,
        'capacity': 80,
        'surface_area': 145,
        'latitude': '42.45',
        'longitude': '11.09',
        'comments': u'☢ Please do not book unless really really necessary ☢',
        'max_advance_days': 45,
        'bookable_times': ROOM_BOOKABLE_TIMES[:1],
        'nonbookable_dates': ROOM_NONBOOKABLE_DATES,
        'equipments': ['PC', 'Video conference'],
        'attributes': ROOM_ATTRIBUTES[:2]
    },
    {
        'name': 'John\'s extra office',
        'site': 'meyrin',
        'division': 'IT',
        'building': '31',
        'floor': 'R',
        'number': 'last one on the right',
        'is_active': True,
        'is_reservable': False,
        'owner_id': 'john',
        'reservations_need_confirmation': True,
        'capacity': 5,
        'max_advance_days': 7,
        'bookable_times': ROOM_BOOKABLE_TIMES[1:],
        'nonbookable_dates': ROOM_NONBOOKABLE_DATES
    },
    {
        'name': 'F1',
        'site': 'munchen',
        'division': 'physics',
        'building': 'center',
        'floor': '0',
        'number': '1',
        'owner_id': 'fred',
        'equipments': ['Whiteboard'],
        'bookable_times': ROOM_BOOKABLE_TIMES[:1]
    },
    {
        'name': 'F2',
        'building': 'right',
        'floor': '0',
        'number': '2',
        'owner_id': 'frankenstein',
        'reservations': RESERVATIONS[9:],
        'attributes': ROOM_ATTRIBUTES[2:]
    }
]


ASPECTS = [
    {
        'name': 'main',
        'center_latitude': '35.42',
        'center_longitude': '38.59',
        'zoom_level': 1,
        'top_left_latitude': '32.01',
        'top_left_longitude': '23.21',
        'bottom_right_latitude': '28.27',
        'bottom_right_longitude': '40.03',
    },
    {
        'name': 'eye-view',
        'center_latitude': '35.42',
        'center_longitude': '38.59',
        'zoom_level': 4,
        'top_left_latitude': '38.01',
        'top_left_longitude': '17.21',
        'bottom_right_latitude': '22.27',
        'bottom_right_longitude': '46.03',
    }
]


LOCATION_ATTRIBUTES = [
    {
        'name': 'Live Webcast',
        'raw_data': '{"hidden": true, "required": false, "type": "str"}'
    },
    {
        'name': 'Test',
        'raw_data': '{"hidden": true, "required": true, "type": "str"}'
    },
]


LOCATIONS = [
    {
        'name': 'CERN',
        'is_default': True,
        'support_emails': 'admin@cern.ch,admin2@cern.ch',
        'aspects': ASPECTS,
        'default_aspect_id': 0,
        'rooms': ROOMS[:3],
        'attributes': LOCATION_ATTRIBUTES
    },
    {
        'name': 'FermiLab',
        'rooms': ROOMS[3:]
    }
]


ATTRIBUTE_KEYS = [
    {
        'name': 'Test',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Manager Group',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'IP',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'H323 IP',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Live Webcast',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Map URL',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Documentation',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Allowed Booking Group',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Notification Email',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'VidyoPanorama ID',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Event Recording',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'Radiation Level',
        'is_for_rooms': True,
        'is_for_reservations': False
    },
    {
        'name': 'H323 Point2Point',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'Vidyo',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'Audio Conference',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'CERN MCU',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'ESnet MCU',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'I don\'t know',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'EVO',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'Built-in (MCU) Bridge',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'ESnet Collaboration',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'Phone Conference',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'HERMES Collaboration',
        'is_for_rooms': True,
        'is_for_reservations': True
    },
    {
        'name': 'AVC',
        'is_for_rooms': False,
        'is_for_reservations': True
    },
    {
        'name': 'AVC Support',
        'is_for_rooms': False,
        'is_for_reservations': True
    },
    {
        'name': 'Assistance',
        'is_for_rooms': False,
        'is_for_reservations': True
    },
    {
        'name': 'ISDN Point2Point',
        'is_for_rooms': False,
        'is_for_reservations': True
    },
    {
        'name': 'VRVS',
        'is_for_rooms': False,
        'is_for_reservations': True
    }
]
