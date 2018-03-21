require 'azure_sdk'
require 'azure_mgmt_resources'
options = {
  tenant_id: ENV['AZURE_TENANT_ID'],
  client_id: ENV['AZURE_CLIENT_ID'],
  client_secret: ENV['AZURE_CLIENT_SECRET'],
  subscription_id: ENV['AZURE_SUBSCRIPTION_ID']
}

include Azure::Resources::Profiles::Latest::Mgmt
include Azure::Resources::Profiles::Latest::Mgmt::Models
client = Client.new(options)
resources = client.resources
require 'json'
JSON.parse(resources.list_async.value.response.body)["value"].each do |resource| 
 p resource["name"] if resource["tags"] == {} || resource["tags"] == nil
end
