<div style="padding:20px 0px">

<a href="${urlHandlers.UHConfAbstractBook.getURL(conf)}">${_("Download book of abstracts")}</a>

<div style="margin-top: 10px;">
% if bookOfAbstractsActive:
    % if bookOfAbstractsMenuActive:
        ${ _("Users will be able to download the book from the <a href='%s'>event home page</a>. You can disable the download from the <a href='%s'>Layout->Menu</a> configuration page.") % (urlHandlers.UHConferenceDisplay.getURL(conf), urlHandlers.UHConfModifDisplayMenu.getURL(conf))}
    % else:
        ${ _("Note that you need to enable the book of abstracts link in <a href='%s'>Layout->Menu</a>") % urlHandlers.UHConfModifDisplayMenu.getURL(conf) }.
    % endif
% else:
    ${ _("Note that you need to enable abstract submission if you wish to provide a link in the <a href='%s'>event home page</a> menu, so users can download your book of abstracts")% urlHandlers.UHConferenceDisplay.getURL(conf) }.
% endif
</div>
</div>

<div class="groupTitle">${ _("Customisation")}</div>
<table width="90%" align="center" border="0">
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Additional text")}</span></td>
        <td>
            <div class="blacktext" id="inPlaceEditAdditionalText">${ boaConfig.getText() }</div>
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat"> ${ _("Sort by")}</span></td>
        <td class="blacktext" width="100%">
            <div id="inPlaceEditSortBy" style="display:inline"></div>
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD"><span class="dataCaptionFormat" style="white-space: nowrap;"> ${ _("Corresponding Author")}</span></td>
        <td class="blacktext" width="100%">
            <div id="inPlaceEditCorrespondingAuthor" style="display:inline"></div>
        </td>
    </tr>
    <tr>
        <td class="dataCaptionTD">
            <span class="dataCaptionFormat" style="white-space: nowrap;"> ${ _("Miscellaneous options")}</span>
        </td>
        <td bgcolor="white" width="100%" class="blacktext">
            <label class="toggle-checkbox"><input type="checkbox"
            % if boaConfig.getShowIds():
                checked
            % endif
            class="toggle-checkbox" data-url="${ urlToogleShowIds }">${ _("Show Abstract IDs") } (${ _("Table of Contents") })</label>
        </td>
    </tr>
</table>
<div class="groupTitle">${ _("Caching")}</div>

<table style="width: 50%;">
  <tr>
    <td colspan="2" style="padding-bottom:10px;">${_("It is recommended to enable the cache for the book of abstracts once you have the final version of it. This will enable users to download the book of abstracts faster.")}</td>
  </tr>
  <tr>
    <td class="dataCaptionTD dataCaptionFormat" nowrap>
      ${_("Cache book of abstracts")}
    </td>
    <td>
      <input type="checkbox" id="cacheToggle" ${'checked="checked"' if boaConfig.isCacheEnabled() else ''}/>
    </td>
  </tr>
  <tr>
    <td colspan="2"><button id="cacheRefresh">${_("Force cache refresh")}</button></td>
  </tr>
</table>

<script type="text/javascript">

$(function() {
    <%  from MaKaC.common import info %>
        $E('inPlaceEditAdditionalText').set(new RichTextInlineEditWidget('abstract.abstractsbook.changeAdditionalText', ${ jsonEncode(dict(conference="%s"%conf.getId())) }, ${ boaConfig.getText() | n,j }, 300, 45, "${_('No additional text')}").draw());
        new IndicoUI.Widgets.Generic.selectionField($E('inPlaceEditSortBy'), 'abstract.abstractsbook.changeSortBy', ${dict(conference="%s"%conf.getId())}, ${sortByList|n,j}, '${sortBy}');
        $('#inPlaceEditCorrespondingAuthor').html(new SelectEditWidget('abstract.abstractsbook.changeCorrespondingAuthor',
                {'conference':'${conf.getId()}'}, ${correspondingAuthorList|n,j}, ${ jsonEncode(correspondingAuthor) }, null).draw().dom);
    $('#cacheToggle').click(function(){
        indicoRequest('abstract.abstractsbook.toggleCache',
                      {conference: '${conf.getId()}'},
                      function(result, error) {
                          if (error) {
                              IndicoUtil.errorReport(error);
                          } else {
                              $('.savedText').remove();
                              $('#cacheToggle').after($('<span/>').text($T('Saved')).
                                                      addClass('savedText').delay(1000).fadeOut('fast'));
                          }
                      });
    });
    $('#cacheRefresh').click(function() {
        var self = this;
        indicoRequest('abstract.abstractsbook.dirtyCache',
                      {conference: '${conf.getId()}'},
                      function(result, error) {
                          if (error) {
                              IndicoUtil.errorReport(error);
                          } else {
                              $('#cacheRefresh').after($('<span/>').text($T('Done')).
                                                       addClass('savedText').delay(1000).fadeOut('fast'));
                          }
                      });
    });
});
</script>
