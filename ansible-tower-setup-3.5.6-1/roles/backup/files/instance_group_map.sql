-- Create temporary tables that capture instance group assignments based on IG *name*
CREATE TABLE tmp_organization_instancegroup_name_map
AS
    SELECT organization_id, name
    FROM main_organization_instance_groups, main_instancegroup
    WHERE main_organization_instance_groups.instancegroup_id=main_instancegroup.id;

CREATE TABLE tmp_jobtemplate_instancegroup_name_map
AS
    SELECT unifiedjobtemplate_id, name
    FROM main_unifiedjobtemplate_instance_groups, main_instancegroup
    WHERE main_unifiedjobtemplate_instance_groups.instancegroup_id=main_instancegroup.id;

CREATE TABLE tmp_inventory_instancegroup_name_map
AS
    SELECT inventory_id, name
    FROM main_inventory_instance_groups, main_instancegroup
    WHERE main_inventory_instance_groups.instancegroup_id=main_instancegroup.id;

ALTER TABLE tmp_organization_instancegroup_name_map OWNER TO awx;
ALTER TABLE tmp_jobtemplate_instancegroup_name_map OWNER TO awx;
ALTER TABLE tmp_inventory_instancegroup_name_map OWNER TO awx;
