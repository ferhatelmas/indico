<table width="90%" align="left" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Title")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">${ title }</td>
        <form action="${ dataModificationURL }" method="POST">
        <td rowspan="2" valign="bottom" align="right">
            <input type="submit" class="btn" value="${ _("modify")}">
        </td>
        </form>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Description")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext"><pre>${ description }</pre></td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("General Fields")}</span></td>
        <td bgcolor="white" class="blacktext" colspan="2" width="100%">
            <table width="100%">
                <tr>
                    <form action="${ postActionURL }" method="POST">
                    <td width="100%">
                        <a href="" name="sections"></a><input type="hidden" name="oldpos">
                        <table align="left">
                            % for gf in generalFields:
                                <tr>
                                    <td align="left" style="padding-left:10px">
                                        <input type="checkbox" class="toggle-checkbox" data-url="${ gf['urlStatus'] }" ${ "checked" if gf['isToggle'] else ""}>
                                    </td>
                                    <td>
                                        <select name="newpos${ gf['fieldIndex'] }" onChange="this.form.oldpos.value='${ gf['fieldIndex'] }';this.form.submit();">
                                            % for i in range(1, gf['fieldCnt'] + 1):
                                                % if i == gf['fieldIndex'] + 1:
                                                    <option selected value='${ i-1 }'>${ i }
                                                % else:
                                                    <option value='${ i-1 }'>${ i }
                                                % endif
                                            % endfor
                                        </select>
                                    </td>
                                    <td>
                                        % if not gf['isLocked']:
                                            <input type="checkbox" name="fieldsIds" value="${ gf['id'] }">
                                        % endif
                                    </td>
                                    <td>
                                        <a href="${ gf['url'] }">${ gf['caption'] }</a>
                                        <b>(${ gf['name'] }${ ", {}".format(_("mandatory")) if gf['isMandatory'] else "" }${ ", {} = {}".format(_("Billable"), gf['price']) if gf['isBillable'] else "" }${ ", {} = {}/{}".format(_("Places"), gf['noPlacesLeft'], gf['limit']) if gf['limit'] else "" })
                                        </b>
                                    </td>
                                </tr>
                            % endfor
                        </table>
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
