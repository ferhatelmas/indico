<a name="tickertape"></a>
<div class="groupItem">

    <table class="groupTable">
        <tr>
            <td colspan="2">
                <div class="groupTitle"> ${ _("Announcement")}</div>
            </td>
        </tr>

        <tr>
            <td nowrap class="dataCaptionTD"><span class="titleCellFormat">${ _("Text announcement")}</span></td>
            <td bgcolor="white" width="65%" class="blacktext">
                <form action="${ tickertapeURL }" method="POST" style="margin:0;">
                    <input type="text" size="60" name="ttText" value="${ text }">
                    <input type="submit" class="btn" name="savettText" value="${ _("save")}">
                    % if modifiedText:
                        <font color="green">(${_("text saved")})</font>
                    % endif
                    <br>

                    <small> ${ _("""Note that text announcement must be enabled above to display this text""")}</small>
                </form>
            </td>
        </tr>

        <tr>
            <td nowrap class="dataCaptionTD"><span class="titleCellFormat"> ${ _("Status")}</span></td>
            <td bgcolor="white" width="65%" class="blacktext">
                <form action=${ simpleTextURL } method="POST">
                    % if isSimpleTextEnabled:
                        <span style="color: #286135;"><b>${ _("ENABLED") }</b></span>
                    % else:
                        <span style="color: #612828;"><b>${ _("DISABLED") }</b></span>
                    % endif
                    <input type="submit"  id="toggleSimpleTextButton" class="btn" value="${ (_('Enable'), _('Disable'))[isSimpleTextEnabled] }">
                </form>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a name="headerFeatures"></a>
                <div class="groupTitle"> ${ _("Conference header features")}</div>
            </td>
        </tr>

        <tr>
            <td nowrap class="dataCaptionTD">
                <span class="titleCellFormat"> ${ _("Show in header")}</span>
            </td>
            <td bgcolor="white" width="65%" class="blacktext">
              <table align="left">
                <tr>
                    <td>
                        <form action="${ nowHappeningURL }" method="POST">
                            <label class='toggle-checkbox toggle-checkbox-blacktext'><input type="checkbox" ${ nowHappeningEnabled } class='toggle-checkbox'>${ _("Now happening...")}</label>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td>
                        <form action="${ searchBoxURL }" method="POST">
                            <label class='toggle-checkbox toggle-checkbox-blacktext'><input type="checkbox" ${ searchBoxEnabled } class='toggle-checkbox'>${ _("Display search box") }</label>
                        </form>
                    </td>
                </tr>
                % if confType == "conference":
                <tr>
                    <td>
                        <form action="${ navigationBoxURL }" method="POST">
                            <label class='toggle-checkbox toggle-checkbox-blacktext'><input type="checkbox" ${ navigationBoxEnabled } class='toggle-checkbox'>${ _("Display navigation bar") }</label>
                        </form>
                    </td>
                </tr>
                % endif
              </table>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    $(function() {
        $('input[type="checkbox"]').click(function(evt) {
            evt.preventDefault();
            $(this).closest('form').submit();
        });
    });
</script>
