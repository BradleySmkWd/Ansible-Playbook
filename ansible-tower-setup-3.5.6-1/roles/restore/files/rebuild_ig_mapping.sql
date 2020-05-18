-- Clear old instance group mappings
DELETE FROM main_organization_instance_groups;
DELETE FROM main_unifiedjobtemplate_instance_groups;
DELETE FROM main_inventory_instance_groups;

-- Build new mappings based on instance group names
INSERT INTO main_organization_instance_groups (instancegroup_id, organization_id)
    SELECT main_instancegroup.id, organization_id
    FROM tmp_organization_instancegroup_name_map, main_instancegroup
    WHERE tmp_organization_instancegroup_name_map.name = main_instancegroup.name;

INSERT INTO main_unifiedjobtemplate_instance_groups (instancegroup_id, unifiedjobtemplate_id)
    SELECT main_instancegroup.id, unifiedjobtemplate_id
    FROM tmp_jobtemplate_instancegroup_name_map, main_instancegroup
    WHERE tmp_jobtemplate_instancegroup_name_map.name = main_instancegroup.name;

INSERT INTO main_inventory_instance_groups (instancegroup_id, inventory_id)
    SELECT main_instancegroup.id, inventory_id
    FROM tmp_inventory_instancegroup_name_map, main_instancegroup
    WHERE tmp_inventory_instancegroup_name_map.name = main_instancegroup.name;

-- Remove temp mapping tables
DROP TABLE tmp_organization_instancegroup_name_map;
DROP TABLE tmp_jobtemplate_instancegroup_name_map;
DROP TABLE tmp_inventory_instancegroup_name_map;
