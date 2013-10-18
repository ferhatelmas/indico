<br/>
<table>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Current status")}</span></td>
    <td class="blacktext" colspan="2">
      <form action="${ setStatusURL }" method="POST">
    <div>
      <input name="changeTo" type="hidden" value="${ changeTo }" />
      <b>${ status }</b>
      <small><input type="submit" class="btn" value="${ changeStatus }" /></small>
    </div>
      </form>
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Registration start date")}</span></td>
    <td class="blacktext">
      ${ startDate }
    </td>
    <td rowspan="8" style="align: right; vertical-align: bottom;">
      <form action="${ dataModificationURL }" method="POST">
    <div>
      <input type="submit" class="btn" value="${ _("modify")}" ${ disabled } />
    </div>
      </form>
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Registration end date")}</span></td>
    <td class="blacktext">
      ${ endDate }
      % if extraTimeAmount:
      (${ _("Allow")}&nbsp;${ extraTimeAmount }&nbsp;${ extraTimeUnit }&nbsp;${ _("after")})
      % endif
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat">${ _("Modification end date")}</span></td>
    <td class="blacktext">
      ${ modificationEndDate }
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Title")}</span></td>
    <td class="blacktext">
      ${ title }
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Contact info")}</span></td>
    <td class="blacktext">
      ${ contactInfo }
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Announcement")}</span></td>
    <td class="blacktext">
      <pre>${ announcement }</pre>
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Max No. of registrants")}</span></td>
    <td class="blacktext">
      ${ usersLimit }
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Email notification sender address")}</span></td>
    <td class="blacktext">
      ${ notificationSender }
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Email notification (on new registrations)")}</span></td>
    <td class="blacktext">
      % if notification:
        <table>
            <tr>
                <td align="right"><b> ${ _("To List") }:</b></td>
                <td align="left">${ notificationToList }</td>
            </tr>
            <tr>
                <td align="right"><b> ${ _("Cc List") }:</b></td>
                <td align="left">${ notificationCcList }</td>
            </tr>
        </table>
      % endif
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Email registrant")}</span></td>
    <td bgcolor="white" width="100%">
      % if activated:
      <table>
        <tr>
          <td align="right"><strong>${ _("After registration")}</strong>:</td>
          <td>${ sendRegEmail }</td>
        </tr>
        <tr>
          <td align="right"><strong>${ _("With a payment summary")}</strong>:</td>
          <td>${ sendReceiptEmail }</td>
        </tr>
        <tr>
          <td align="right"><strong>${ _("After successful payment")}</strong>:</td>
          <td>${ sendPaidEmail }</td>
        </tr>
      </table>
      % endif
    </td>
  </tr>
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Must have account")}</span></td>
    <td class="blacktext">
      ${ mandatoryAccount }
    </td>
  </tr>
  <tr>
    <td colspan="3" class="horizontalLine">&nbsp;</td>
  </tr>
  <tr>
    <td class="dataCaptionTD">
      <a name="sections"></a>
      <span class="dataCaptionFormat">${ _("Sections of the form")}</span>
    </td>

    <td colspan="2">
        <form id="sectionsForm" action="${ actionSectionURL }" method="POST">
            <input type="hidden" name="oldpos">
            <table>
                <tbody>
                    <td class="blacktext" style="padding-left:20px">
                        <table>
                            <tbody>
                                % for section in sections:
                                    <tr>
                                        <td>
                                            % if section['toggleUrl']:
                                                <input type="checkbox" ${ section['isEnabled'] } class="toggle-checkbox" data-url="${ section['toggleUrl'] }">
                                            % endif
                                        </td>
                                        <td>
                                            <select name="newpos${ section['sectionIndex'] }" data-index="${ section['sectionIndex'] }">
                                                % for i in range(1, section['sectionsCnt']):
                                                    <option
                                                        % if i == section['sectionIndex'] + 1:
                                                          selected
                                                        % endif
                                                        value="${ i-1 }">${ i }</option>
                                                % endfor
                                            </select>
                                            &nbsp;
                                            % if section['checkbox']:
                                                <input type="checkbox" name="sectionsIds" value="${ section['sectionId'] }">&nbsp;
                                            % else:
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            % endif
                                            <a href="${ section['modifUrl'] }">${ section['sectionTitle'] }</a>
                                        </td>
                                    </tr>
                                % endfor
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <input type="submit" class="btn" name="removeSection" value="${ _('remove sect.') }">
                        <input type="submit" class="btn" name="newSection" value="${ _('new sect.') }">
                    </td>
                </tbody>
            </table>
        </form>
    </td>
  </tr>
  <tr>
    <td colspan="3" class="horizontalLine">&nbsp;</td>
  </tr>
  <tr>
    <td class="dataCaptionTD">
      <span class="dataCaptionFormat"> ${ _("Custom statuses")}</span>
    </td>
    <td colspan="2">
      <form action="${ actionStatusesURL }" method="POST">
        <table>
          <tr>
            <td colspan="2">
              <input type="text" name="caption" value="" size="50" />
              <input type="submit" class="btn" name="addStatus" value="${ _("add status")}" />
            </td>
          </tr>
          <tr>
            <td>
                <a href="" name="statuses"></a>
                <table style="padding-top:20px">
                    % if statuses:
                        % for st in statuses:
                            <tr>
                                <td>
                                    &nbsp;<input type="checkbox" name="statusesIds" value="${ st['id'] }">
                                    &nbsp;<a href="${ st['url'] }">${ st['caption'] }</a>
                                </td>
                            </tr>
                        % endfor
                    % else:
                        <tr>
                            <td style="padding-left:20px">
                                <ul>
                                    <li>${ _("No statuses defined yet.") }</li>
                                </ul>
                                <br>${ _('You can use this option in order to create general statuses you will be able to use afterwards in the list of registrants. For instance, you can create a status "paid" in order to check if someone has paid or not.') }
                            </td>
                        </tr>
                    % endif
                </table>
            </td>
            <td>
              <input type="submit" class="btn" name="removeStatuses" value="${ _("remove status")}" />
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
  <tr>
    <td colspan="3" class="horizontalLine">&nbsp;</td>
  </tr>
</table>
<br/>

<script type="text/javascript">
    $(function() {
        $('select').on('change', function(evt) {
            var sectionsForm = $('#sectionsForm');
            sectionsForm.children('input[name=oldpos]').val($(this).data('index'));
            sectionsForm.submit();
        });
    });
</script>
