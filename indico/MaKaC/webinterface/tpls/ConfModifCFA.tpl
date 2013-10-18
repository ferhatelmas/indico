<br>
<table class="groupTable">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Current status")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext" colspan="2">
            <form action="${ setStatusURL }" method="POST">
                <input name="changeTo" type="hidden" value="${ changeTo }">
                <b>${ status }</b>
                <small><input type="submit" class="btn" value="${ changeStatus }"></small>
            </form>
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Submission start date")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            ${ startDate }
        </td>
    <form action="${ dataModificationURL }" method="POST">
        <td rowspan="5" valign="bottom" align="right">
            <input type="submit" class="btn" value="${ _("modify")}" ${ disabled }>
        </td>
    </form>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Submission end date")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            ${ endDate }
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Modification deadline")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            ${ modifDL }
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Announcement")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            ${ announcement }
        </td>
    </tr>

    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Email notification on submission")}</span></td>
        <td bgcolor="white" width="100%">
          <table>
            <tr>
              <td class="blacktext">
                <table align="left">
                    <tr>
                        <td align="right"><b> ${ _("To List")}:</b></td>
                        <td align="left">${ notificationToList }</td>
                    </tr>
                    <tr>
                        <td align="right"><b> ${_("Cc List")}:</b></td>
                        <td align="left">${ notificationCcList }</td>
                    </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td><font color="#777777"><small> ${ _("An email is automatically sent to the submitter after their abstract submission. This email will also be sent to the email addresses above this line.")}</small></font></td>
            </tr>
          </table>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Late submission authorised users")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext" colspan="2">
            <table width="100%">
                <tr>
                    <td><ul id="inPlaceUsers" class="UIPeopleList"></ul></td>
                </tr>
                <tr>
                    <td nowrap style="width:80%">
                        <input type="button" id="inPlaceAddUserButton" onclick="lateSubmissionAuthUsers.addExistingUser();" value='${ _("Add user") }'></input>
                    </td>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Misc. Options")}</span></td>
        <td bgcolor="white" width="100%" class="blacktext">
            <label class="toggle-checkbox"><input type="checkbox" ${ multipleTracks } class="toggle-checkbox" data-url="${ multipleUrl }">${ _("Allow multiple tracks selection") }</label>

            <label class="toggle-checkbox"><input type="checkbox" ${ mandatoryTracks } class="toggle-checkbox" data-url="${ mandatoryUrl }">${ _("Make track selection mandatory") }</label>

            <label class="toggle-checkbox"><input type="checkbox" ${ canAttachFiles } class="toggle-checkbox" data-url="${ attachUrl }">${ _("Allow to attach files") }</label>

            <label class="toggle-checkbox"><input type="checkbox" ${ showSelectAsSpeaker } class="toggle-checkbox" data-url="${ showSpeakerUrl }">${ _("Allow to choose the presenter(s) of the abstracts") }</label>

            <label class="toggle-checkbox"><input type="checkbox"
            % if not showSelectAsSpeaker:
                disabled="true" style="color: red;"
            % endif
            ${ isSelectSpeakerMandatory } class="toggle-checkbox" data-url="${ speakerMandatoryUrl }">${ _("Make mandatory the selection of at least one author as presenter") }</label>

            <label class="toggle-checkbox"><input type="checkbox" ${ showAttachedFilesContribList }
                % if showAttachedFilesContribList:
                    data-url="${ showAttachedFilesUrl }"
                % endif
            class="toggle-checkbox">${ _("Show files attached to abstracts in the contribution list") }
                <a href="${ showAttachedFilesUrl }"
                   % if not showAttachedFilesContribList:
                     data-confirm="${_("Please, note that if you enable this option the files (attached to the abstracts) will be public and accessible by everybody. Are you sure to continue?")}"
                     data-title="${_("Show attached files")}"
                   % endif
                ></a>
            </label>
        </td>
    </tr>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
    <tr>
        <td class="dataCaptionTD">
          <a name="optional"></a>
          <span class="dataCaptionFormat"> ${ _("Abstract fields")}</span>
        </td>
        <td bgcolor="white" width="100%" class="blacktext" style="padding-left:20px" colspan="2">
            <table align="left" width="100%">
              <form action="" method="POST">
                % for af in abstractFields:
                  <tr>
                    <td>
                      <input type="checkbox" ${ af['isEnabled'] } class="toggle-checkbox" data-url="${ af['toggleUrl'] }">&nbsp;
                      <a href="${ af['urlUp'] }"><img src="${ arrowUp }" border="0" alt="" style="vertical-align: middle"></a>
                      <a href="${ af['urlDown'] }"><img src="${ arrowDown }" border="0" alt="" style="vertical-align: middle"></a>
                    </td>
                    <td width="1%">
                      % if af['removeButton']:
                        <input type="checkbox" name="fieldId" value="${ af['id'] }">
                      % endif
                    </td>
                    <td>
                      &nbsp;<a class="edit-field" href="#" data-id="${ af['id']}" data-fieldType="${ af['type']}">${ af['caption'] }</a> ${ af['addInfo'] }
                    </td>
                  </tr>
                % endfor
                <tr>
                  <td align="right" colspan="3">
                    <input type="submit" value="${ _('remove') }" onClick="this.form.action='${ abstractFieldsUrlRemove }';" class="btn">
                    <input id="add-field-button" type="submit" value="${ _('add') }" class="btn">
                  </td>
                </tr>
              </form>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="horizontalLine">&nbsp;</td>
    </tr>
</table>

<%include file="ConfModifCFAAddFieldTooltip.tpl"/>

<script type="text/javascript">
$(function() {
    $("#add-field-button").click(function(e) {
        e.preventDefault();
    }).qtip({
        id: "add-field",
        content: $("#qtip-content-add-field"),
        position: {
            at: "top right",
            my: "bottom right"
        },
        show: {
            event: "click"
        },
        hide: {
            event: "unfocus click"
        },
        events: {
            render: function(event, api) {
                $("#qtip-content-add-field .i-big-button").click(function(e) {
                    e.preventDefault();
                    api.hide();
                    var fieldType = $(this).data("fieldtype");
                    new AbstractFieldDialogFactory().makeDialog(fieldType, ${confId}).open();
                });
            }
        }
    });

    $(".edit-field").click(function(e) {
        e.preventDefault();
        var fieldId = $(this).data("id");
        var fieldType = $(this).data("fieldtype");
        new AbstractFieldDialogFactory().makeDialog(fieldType, ${confId}, fieldId).open();
    });
});

var lateSubmissionAuthUsers = new ListOfUsersManager('${ confId }',
    {'addExisting': 'abstracts.lateSubmission.addExistingLateAuthUser', 'remove': 'abstracts.lateSubmission.removeLateAuthUser'},
    {'confId': '${ confId }'}, $E('inPlaceUsers'), "user", "UIPerson", false, {}, {title: false, affiliation: false, email:true},
    {remove: true, edit: false, favorite: true, arrows: false, menu: false}, ${ lateAuthUsers | n,j});

IndicoUI.executeOnLoad(function(){
    $('#makePresenterMandatory').qtip({content: "${_('This option is automatically disabled when the option \'Allow to choose the presenter(s) of the abstracts\' is also disabled')}", position: {my: 'top middle', at: 'bottom middle'}});
});
</script>
