
include_recipe 'elasticsearch::default'
include_recipe 'kibana_lwrp::install'

elasticsearch_service 'elasticsearch' do
  action :start
end
