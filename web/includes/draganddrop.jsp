<%-- 
    Document   : draganddrop
    Created on : Feb 27, 2013, 11:33:07 PM
    Author     : Robert Brown
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
	$(function() {
	$('.sortable').sortable();
	$('.handles').sortable({
	handle: 'span'
	});
	$('.connected').sortable({
	connectWith: '.connected'
	});
	$('.exclude').sortable({
	items: ':not(.disabled)'
	});
	});
	</script>
	<script type="text/javascript">
			$(function () {
					$("#tabs").tabs();

					$('#showsTable').dataTable({
							'aoColumns': [
									{ 'bSortable': false },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true }, 
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': false }    
							],
							'aaSorting': [[1, 'asc']],
							'fnHeaderCallback': Scripps.DataTables.fnHeaderCallback,
							'bFilter': false,
							'bLengthChange': false,
							'sPaginationType': 'scripps'
					});

					$("#assignmentsTabs").tabs();

					$('#assignmentsTable').dataTable({
							'aoColumns': [
									{ 'bSortable': false },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': false },
							],
							'aaSorting': [[1, 'asc']],
							'fnHeaderCallback': Scripps.DataTables.fnHeaderCallback,
							'bFilter': false,
							'bLengthChange': false,
							'sPaginationType': 'scripps'
					});
			});
	</script>
	<script type="text/javascript">
	$(function() {
    $( ".inlineTabs" ).tabs();
    });
	</script>
