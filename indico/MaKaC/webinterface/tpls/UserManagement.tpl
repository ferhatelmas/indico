<table width="90%" align="left" border="0">
  <tr>
    <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Account Creation")}</span></td>
    <td bgcolor="white" class="blacktext">
      <label class="toggle-checkbox toggle-checkbox-blacktext"><input type="checkbox" ${ publicAccountCreationChecked } class="toggle-checkbox" data-url="${ publicAccountCreationUrl }">${ _("Public Account Creation")}</label>
      <label class="toggle-checkbox toggle-checkbox-blacktext"><input type="checkbox" ${ notifyAccountCreationChecked } class="toggle-checkbox" data-url="notifyAccountCreationUrl">${ _("Notify Account Creation by Email")}</label>
      <label class="toggle-checkbox toggle-checkbox-blacktext"><input type="checkbox" ${ moderateAccountCreationChecked } class="toggle-checkbox" data-url="moderateAccountCreationUrl">${ _("Moderate Account Creation")}</label>
    </td>
  </tr>
</table>
