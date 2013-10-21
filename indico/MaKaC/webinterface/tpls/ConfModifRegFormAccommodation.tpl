<table width="90%" align="left" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Title")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ title }</td>
        <form action="${ dataModificationURL }" method="POST">
        <td rowspan="4" valign="bottom" align="right">
            <input type="submit" class="btn" value="${ _("modify")}">
        </td>
        </form>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Description")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext"><pre>${ description }</pre></td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Proposed Arrival dates")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ arrivalDates }</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Proposed Departure dates")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ departureDates }</td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Accommodation types")}</span></td>
        <td bgcolor="white" class="blacktext" colspan="2" width="100%">
            <table width="100%">
                <tr>
                    <form action="${ postURL }" method="POST">
                    <td width="100%">
                        % for acc in accommodationTypes:
                            <tr>
                                <td align="left" style="padding-left:10px"><input type="checkbox" name="accommodationType" value="${ acc['id'] }"><a href="${ acc['url'] }">${ acc['caption'] }</a>
                                % if acc['limit'] > 0:
                                    &nbsp;<i>[${ acc['currentNoPlaces'] }/${ acc['limit'] } place(s)]</i>
                                % else:
                                    &nbsp;<i>[${ _("unlimited places")}]</i>
                                % endif

                                % if acc['isBillable']:
                                    &nbsp;<i>[billable: ${ acc['price'] }]</i>
                                % endif

                                % if acc['isCancelled']:
                                    &nbsp;<font color="red">(${ _("disabled") })</font>
                                % endif
                                </td>
                            </tr>
                        % endfor
                    </td>
                    <td valign="bottom" align="right">
                        <input type="submit" class="btn" name="remove" value="${ _("remove")}" style="width:80px">
                        </form>
                        <form action="${ postNewURL }" method="POST">
                            <input type="submit" class="btn" name="add" value="${ _("add")}" style="width:80px">
                    </td>
                    </form>
                </tr>
            </table>
        </td>
    </tr>
</table>
