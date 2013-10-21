<table width="90%" align="left" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Title")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ title }</td>
        <form action="${ dataModificationURL }" method="POST">
        <td rowspan="3" valign="bottom" align="right">
            <input type="submit" class="btn" value="${ _("modify")}">
        </td>
        </form>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Description")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext"><pre>${ description }</pre></td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Introduction sentence")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ intro }</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Selection type")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ selectionType }</td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Social event entries")}</span></td>
        <td bgcolor="white" class="blacktext" colspan="2" width="100%">
            <table width="100%">
                <tr>
                    <form action="${ postURL }" method="POST">
                    <td width="100%">
                        % for socialEvent in socialEvents:
                            <tr>
                                <td align="left" style="padding-left:10px"><input type="checkbox" name="socialEvents" value="${ socialEvent['id'] }"><a href="${ socialEvent['url'] }">${ socialEvent['url'] }</a>
                                % if socialEvent['limit'] > 0:
                                    &nbsp;<i>[${ socialEvent['currentNoPlaces'] }/${ socialEvent['limit'] } place(s)]</i>
                                % else:
                                    &nbsp;<i>[${ _("unlimited places") }]</i>
                                % endif

                                % if socialEvent['isBillable']:
                                    <i>&nbsp;[${ _("billable") }: ${ socialEvent['price'] }
                                    % if socialEvent['isPricePerPlace']:
                                        &nbsp;<acronym title="per place">pp</acronym>
                                    % endif
                                    ]</i>
                                % endif

                                % if socialEvent['isCancelled']:
                                    % if socialEvent['cancelledReason']:
                                        <font color="red">(${ _("disabled") }: ${ socialEvent['cancelledReason'] })</font>
                                    % else:
                                        <font color="red">(${ _("cancelled") })</font>
                                    % endif
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
