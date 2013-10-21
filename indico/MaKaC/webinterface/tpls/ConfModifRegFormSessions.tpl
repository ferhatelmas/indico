<table width="90%" align="left" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Title")}</span></td>
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
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Type of sessions' form")}<br><small>(${ _("how many sessions the<br>registrant can choose")})</small></span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            % if sessionsType == "all":
                ${ _("multiple") }
            % else:
                ${ _("2 choices") }&nbsp;<span style="color:red;">(${ _("session billing not possible") })</span>
            % endif
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Sessions")}</span></td>
        <td bgcolor="white" class="blacktext" colspan="2" width="100%">
            <table width="100%">
                <tr>
                    <form action="${ postURL }" method="POST">
                    <td width="100%">
                        % if sessions:
                            % for session in sessions["sessionList"]:
                                <div>
                                    <input type="checkbox" name="sessionIds" value="${ session['id'] }">
                                    <a href="${ session['url'] }">${ session["title"] }</a>
                                    % if session["isBillable"]:
                                        &nbsp;<i>[billable: ${ session["price"]}]</i>%s
                                    % endif
                                    % if session["isCancelled"]:
                                        &nbsp;<font color="red">(${ _("cancelled") })</font>
                                    % endif
                                </div>
                            % endfor
                        % else:
                            ${ sessionsVars["noSessionMessage"] }
                        % endif
                    </td>
                    <td valign="bottom" align="right">
                        <input type="submit" class="btn" name="remove" value="${ _("remove")}" style="width:80px">
                        </form>
                        <form action="${ postAddURL }" method="POST">
                            <input type="submit" class="btn" name="add" value="${ _("add")}" style="width:80px">
                    </td>
                    </form>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            ${ _("You can change the price and billable flag of a session in the session properties.") }
        </td>
    </tr>
</table>
