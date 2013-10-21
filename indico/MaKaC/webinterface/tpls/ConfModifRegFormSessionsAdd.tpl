<form action="${ postURL }" method="POST">
    <table width="80%" align="center" border="0" style="border-left: 1px solid #777777">
        <tr>
            <td class="groupTitle" colspan="2">${ _("Add") } ${ title }</td>
        </tr>
        <tr>
          <td class="titleCellTD"><span class="titleCellFormat">${ _("Sessions to add")}</span></td>
          <td bgcolor="white" class="blacktext" width="100%">
            <table width="100%">
                <tr>
                    <td width="100%">
                        % if sessions['list']:
                            % for session in sessions['list']:
                                <p><input type="checkbox" name="sessionIds" value="${ session['id'] }" >${ session['title'] }</p>
                            % endfor
                        % else:
                            ${ sessions['emptyMessage'] }
                        % endif
                    </td>
                </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td valign="bottom" align="left">
            <input type="submit" class="btn" name="add" value="${ _("add")}" style="width:80px">
          </td>
        </tr>
    </table>
</form>
