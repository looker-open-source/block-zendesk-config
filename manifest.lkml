project_name: "block-zendesk-config"

constant: CONNECTION_NAME {
  value: "fivetran_looker_blocks_demo"
}

constant: SCHEMA_NAME {
  value: "zendesk"
}

# TODO: Insert the name of your zendesk instance below (i.e. if your zendesk instance url is mycompany.zendesk.com, insert 'mycompany')
constant: ZENDESK_INSTANCE_DOMAIN {
  value: "INSERT HERE"
}

local_dependency: {
  project: "block-zendesk"
}
