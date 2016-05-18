module Fog
  module Network
    class AzureRM
      # Real class for Network Request
      class Real
        def list_public_ips(resource_group)
          Fog::Logger.debug "Getting list of PublicIPs from Resource Group #{resource_group}."
          begin
            promise = @network_client.public_ipaddresses.list(resource_group)
            result = promise.value!
            Azure::ARM::Network::Models::PublicIPAddressListResult.serialize_object(result.body)['value']
          rescue  MsRestAzure::AzureOperationError => e
            msg = "Exception listing Public IPs from Resource Group '#{resource_group}'. #{e.body['error']['message']}."
            raise msg
          end
        end
      end

      # Mock class for Network Request
      class Mock
        def list_public_ips(_resource_group)
          public_ip = Azure::ARM::Network::Models::PublicIPAddress.new
          public_ip.name = 'fogtestpublicip'
          public_ip.location = 'West US'
          public_ip.type = 'Static'
          [public_ip]
        end
      end
    end
  end
end
