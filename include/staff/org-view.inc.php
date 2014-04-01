<?php
if(!defined('OSTSCPINC') || !$thisstaff || !is_object($org)) die('Invalid path');

?>
<table width="940" cellpadding="2" cellspacing="0" border="0">
    <tr>
        <td width="50%" class="has_bottom_border">
             <h2><a href="orgs.php?id=<?php echo $org->getId(); ?>"
             title="Reload"><i class="icon-refresh"></i> <?php echo $org->getName(); ?></a></h2>
        </td>
        <td width="50%" class="right_align has_bottom_border">
            <a id="org-delete" class="action-button org-action"
            href="#orgs/<?php echo $org->getId(); ?>/delete"><i class="icon-trash"></i> Delete Organization</a>
        </td>
    </tr>
</table>
<table class="ticket_info" cellspacing="0" cellpadding="0" width="940" border="0">
    <tr>
        <td width="50">
            <table border="0" cellspacing="" cellpadding="4" width="100%">
                <tr>
                    <th width="100">Name:</th>
                    <td><b><a href="#orgs/<?php echo $org->getId();
                    ?>/edit" class="org-action"><i
                    class="icon-edit"></i>&nbsp;<?php echo
                    $org->getName();
                    ?></a></td>
                </tr>
                <tr>
                    <th>Users:</th>
                    <td> {num-here}
                    </td>
                </tr>
            </table>
        </td>
        <td width="50%" style="vertical-align:top">
            <table border="0" cellspacing="" cellpadding="4" width="100%">
                <tr>
                    <th>Created:</th>
                    <td><?php echo Format::db_datetime($org->getCreateDate()); ?></td>
                </tr>
                <tr>
                    <th>Updated:</th>
                    <td><?php echo Format::db_datetime($org->getUpdateDate()); ?></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br>
<div class="clear"></div>
<ul class="tabs">
    <li><a class="active" id="users_tab" href="#users"><i
    class="icon-list-alt"></i>&nbsp;Users</a></li>
</ul>
<div id="users">
<div style="width:700px; float:left;">
   <?php
    if ($results) {
        echo  sprintf('<strong>Showing 1 - %d of %s</strong>',
            count($results), count($results));
    } else {
        echo 'Organization does not have users';
    }
   ?>
</div>
<div style="float:right;text-align:right;padding-right:5px;">
    <b><a class="Icon newStaff" href="users.php?a=open&oid=<?php echo
    $org->getId(); ?>"> Add New User</a></b>
</div>
<br/>
</div>

<script type="text/javascript">
$(function() {
    $(document).on('click', 'a.org-action', function(e) {
        e.preventDefault();
        var url = 'ajax.php/'+$(this).attr('href').substr(1);
        $.dialog(url, [201, 204], function (xhr) {
            if (xhr.status == 204)
                window.location.href = 'orgs.php';
            else
                window.location.href = window.location.href;
         }, {
            onshow: function() { $('#org-search').focus(); }
         });
        return false;
    });
});
</script>
