<script>
    $( document ).ready(function() {
        $("#grid-addresses").UIBootgrid(
            {   search:'/api/interfaces/vxlan_settings/searchItem/',
                get:'/api/interfaces/vxlan_settings/getItem/',
                set:'/api/interfaces/vxlan_settings/setItem/',
                add:'/api/interfaces/vxlan_settings/addItem/',
                del:'/api/interfaces/vxlan_settings/delItem/'
            }
        );

        $("#reconfigureAct").click(function(){
            $("#reconfigureAct_progress").addClass("fa fa-spinner fa-pulse");
            ajaxCall("/api/interfaces/vxlan_settings/reconfigure", {}, function(data,status) {
                // when done, disable progress animation.
                $("#reconfigureAct_progress").removeClass("fa fa-spinner fa-pulse");
                if (status != "success" || data['status'] != 'ok') {
                    BootstrapDialog.show({
                        type: BootstrapDialog.TYPE_WARNING,
                        title: "{{ lang._('Error reconfiguring vxlan') }}",
                        message: data['status'],
                        draggable: true
                    });
                }
            });
        });

    });
</script>
<div class="tab-content content-box">
  <table id="grid-addresses" class="table table-condensed table-hover table-striped" data-editDialog="DialogVxlan" data-editAlert="VxLanChangeMessage">
      <thead>
          <tr>
              <th data-column-id="uuid" data-type="string" data-identifier="true" data-visible="false">{{ lang._('ID') }}</th>
              <th data-column-id="deviceId" data-type="string">{{ lang._('Device') }}</th>
              <th data-column-id="vxlanid" data-type="string">{{ lang._('VNI') }}</th>
              <th data-column-id="vxlanlocal" data-type="string">{{ lang._('Source') }}</th>
              <th data-column-id="commands" data-width="7em" data-formatter="commands" data-sortable="false">{{ lang._('Commands') }}</th>
          </tr>
      </thead>
      <tbody>
      </tbody>
      <tfoot>
          <tr>
              <td></td>
              <td>
                  <button data-action="add" type="button" class="btn btn-xs btn-default"><span class="fa fa-plus"></span></button>
                  <button data-action="deleteSelected" type="button" class="btn btn-xs btn-default"><span class="fa fa-trash-o"></span></button>
              </td>
          </tr>
      </tfoot>
  </table>
  <div class="col-md-12">
      <div id="VxLanChangeMessage" class="alert alert-info" style="display: none" role="alert">
          {{ lang._('After changing settings, please remember to apply them with the button below') }}
      </div>
      <hr/>
      <button class="btn btn-primary" id="reconfigureAct" type="button"><b>{{ lang._('Apply') }}</b> <i id="reconfigureAct_progress" class=""></i></button>
      <br/><br/>
  </div>
</div>


{{ partial("layout_partials/base_dialog",['fields':formDialogVxlan,'id':'DialogVxlan','label':lang._('Edit VxLan')])}}
