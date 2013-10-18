
<br>
<table width="90%" align="left" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Current status")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext" colspan="2">
            <form action="${ setStatusURL }" method="POST">
                <input name="changeTo" type="hidden" value="${ changeTo }">
                <b>${ status }</b>
                <small><input type="submit" value="${ changeStatus }"></small>
            </form>
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Currency")}</span></td>
        <td class="blacktext" style=${"color:red;font-weight:bold;" if Currency ==_("not selected") else "" }>
            ${ Currency }
        </td>
    </tr></tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Detail of Payment")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
           <TEXTAREA ROWS="6" COLS="60" disabled="true" >${ detailPayment }</TEXTAREA>
        </td>
        <td valign="bottom" rowspan="3">
        <form action="${ dataModificationURL }" method="POST">
            <input type="submit" value="${ _("modify")}" ${ disabled }>
        </form>
        </td>
    </tr>
<%
from MaKaC.common import HelperMaKaCInfo
minfo = HelperMaKaCInfo.getMaKaCInfoInstance()
al = minfo.getAdminList()
%>
% if al.isAdmin( self_._rh._getUser() ):
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Mandatory Conditions")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
           ${ _("This conditions are:")} <b>${ conditionsEnabled }</b>
           <br/>
           <TEXTAREA ROWS="6" COLS="60" disabled="true" >${ conditionsPayment }</TEXTAREA>
           <br/>
        </td>
        <td></td>
    </tr>
% endif
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">Conditions</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
           <TEXTAREA ROWS="6" COLS="60" disabled="true" >${ specificConditionsPayment }</TEXTAREA>
           <br/>
        </td>
        <td></td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Payment Summary Email Message")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
           <textarea rows="6" cols="60" disabled="disabled">${ receiptMsgPayment }</textarea>
           <br/>
        </td>
        <td></td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Success Email Message")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
           <textarea rows="6" cols="60" disabled="disabled">${ successMsgPayment }</textarea>
           <br/>
        </td>
        <td></td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD">
          <span class="dataCaptionFormat"> ${ _("Mod of Payments")}</span>
        </td>
        <td bgcolor="white" width="100%" class="blacktext" style="padding-left:20px">
            <table align="left">
                % for section in sections:
                <tr>
                    <td>
                        <input type="checkbox" class="toggle-checkbox" ${ section['isEnabled'] } data-url="${ section['toggleUrl'] }">
                        <a href="${ section['modifUrl'] }">${ section['title'] }</a>
                    </td>
                </tr>
                % endfor
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
</table>
<br>
