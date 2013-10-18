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

import string

from MaKaC import epayment
from MaKaC.webinterface.pages import conferences
from MaKaC.webinterface.pages import registrationForm
from MaKaC.webinterface import urlHandlers
from MaKaC.webinterface import navigation
from MaKaC.webinterface import wcomponents
from xml.sax.saxutils import quoteattr
from MaKaC.common import Configuration
from datetime import timedelta,datetime
from MaKaC.webinterface.common.countries import CountryHolder
from MaKaC.webinterface.pages import registrationForm
from MaKaC.conference import Session
from MaKaC.i18n import _
from MaKaC.common import HelperMaKaCInfo
from MaKaC.webinterface.common.currency import CurrencyRegistry
# ----------------- MANAGEMENT AREA ---------------------------
class WPConfModifEPaymentBase( registrationForm.WPConfModifRegFormBase ):

    def _setActiveTab( self ):
        self._tabEPay.setActive()

class WPConfModifEPayment( WPConfModifEPaymentBase ):

    def _getTabContent( self, params ):
        wc = WConfModifEPayment(self._conf, self._getAW())
        return wc.getHTML()

class WConfModifEPayment( wcomponents.WTemplated ):

    def __init__( self, conference, aw ):
        self._conf = conference
        self._aw = aw

    def _getSectionsHTML(self):
        sections = []
        modPay = self._conf.getModPay()

        for gs in modPay.getSortedModPay():
            section = {}
            urlStatus = urlHandlers.UHConfModifEPaymentEnableSection.getURL(self._conf)
            urlStatus.addParam("epayment", gs.getId())
            section['toggleUrl'] = urlStatus
            section['isEnabled'] = 'checked' if gs.isEnabled() else ''

            section['modifUrl'] = gs.getConfModifEPaymentURL(self._conf)
            section['title'] = gs.getTitle()
            sections.append(section)

        return sections


    def getVars( self ):
        vars = wcomponents.WTemplated.getVars(self)
        modPay = self._conf.getModPay()
        vars["setStatusURL"] = urlHandlers.UHConfModifEPaymentChangeStatus.getURL(self._conf)
        if modPay.isActivated():
            vars["changeTo"] = "False"
            vars["status"] = _("ENABLED")
            vars["changeStatus"] = _("DISABLE")
            vars["disabled"] = ""
            vars["detailPayment"] = self._conf.getModPay().getPaymentDetails()
            vars["conditionsPayment"] = self._conf.getModPay().getPaymentConditions()
            vars["specificConditionsPayment"] = self._conf.getModPay().getPaymentSpecificConditions()
            vars["successMsgPayment"] = self._conf.getModPay().getPaymentSuccessMsg()
            vars["receiptMsgPayment"] = self._conf.getModPay().getPaymentReceiptMsg()
            vars["conditionsEnabled"] = "DISABLED"
            if self._conf.getModPay().arePaymentConditionsEnabled():
                vars["conditionsEnabled"] = "ENABLED"
            vars["Currency"]=self._conf.getRegistrationForm().getCurrency() or _("not selected")
        else:
            vars["changeTo"] = "True"
            vars["status"] = _("DISABLED")
            vars["changeStatus"] = _("ENABLE")
            vars["disabled"] = "disabled"
            vars["detailPayment"] = ""
            vars["conditionsPayment"] = ""
            vars["conditionsEnabled"] = "DISABLED"
            vars["specificConditionsPayment"] = ""
            vars["successMsgPayment"] = ""
            vars["receiptMsgPayment"] = ""
            vars["Currency"] = ""
        vars["dataModificationURL"]=urlHandlers.UHConfModifEPaymentdetailPaymentModification.getURL(self._conf)
        vars["sections"] = self._getSectionsHTML()
        return vars

class WPConfModifEPaymentDataModification( WPConfModifEPaymentBase ):

    def _getTabContent( self, params ):
        wc = WConfModifEPaymentDataModification(self._conf)
        return wc.getHTML()

class WConfModifEPaymentDataModification( wcomponents.WTemplated ):

    def __init__( self, conference ):
        self._conf = conference

    def getVars( self ):
        vars = wcomponents.WTemplated.getVars(self)
        vars["postURL"]=urlHandlers.UHConfModifEPaymentPerformdetailPaymentModification.getURL(self._conf)
        vars["dataModificationURL"]=urlHandlers.UHConfModifRegFormDataModification.getURL(self._conf)
        vars["detailPayment"]= self._conf.getModPay().getPaymentDetails()
        vars["conditionsPayment"]= self._conf.getModPay().getPaymentConditions()
        vars["specificConditionsPayment"]= self._conf.getModPay().getPaymentSpecificConditions()
        vars["conditionsEnabled"]= ""
        if self._conf.getModPay().arePaymentConditionsEnabled():
            vars["conditionsEnabled"]= "checked=\"checked\""
        vars["successMsgPayment"] = self._conf.getModPay().getPaymentSuccessMsg()
        vars["receiptMsgPayment"] = self._conf.getModPay().getPaymentReceiptMsg()
        regForm = self._conf.getRegistrationForm()
        vars["successMsgPaymentEnabled"] = regForm.isSendPaidEmail() and _("ENABLED") or _("DISABLED")
        vars["receiptMsgPaymentEnabled"] = regForm.isSendReceiptEmail() and _("ENABLED") or _("DISABLED")
        vars["Currency"]=CurrencyRegistry.getSelectItemsHTML(regForm.getCurrency())
        return vars

