resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties": true,
        "properties": {
            "CallerID": {
                "type": "string"
            },
            "Domain": {
                "description": "The Service Now instance domain e.g. https://*domain*.service-now.com",
                "type": "string"
            },
            "INC_Description": {
                "type": "string"
            }
        },
        "type": "object"
    })
    contract_output = jsonencode({
        "additionalProperties": true,
        "properties": {},
        "type": "object"
    })
    
    config_request {
        request_template     = "{ \"short_description\":\"$${input.INC_Description}\", \"contact_type\":\"self-service\", \"caller_id\": \"$${input.CallerID}\" }"
        request_type         = "POST"
        request_url_template = "https://$${input.Domain}.service-now.com/api/now/table/incident"
        headers = {
			Content-Type = "application/json"
		}
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}