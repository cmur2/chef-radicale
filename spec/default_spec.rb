require 'chefspec'
begin require 'chefspec/deprecations'; rescue LoadError; end

describe 'radicale::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'radicale::default'
  end
  
  it 'installs radicale via pip' do
    pending "Cannot test python_pip"
  end
  
  it 'creates an init.d script' do
    expect(chef_run).to create_file_with_content "/etc/init.d/radicale", ""
  end
  
  it 'creates the radicale config' do
    expect(chef_run).to create_file_with_content "/opt/radicale/config", ""
  end

  it 'creates the radicale logging config' do
    expect(chef_run).to create_file_with_content "/opt/radicale/logging", ""
  end

  it 'enables and starts radicale' do
    expect(chef_run).to start_service "radicale"
    expect(chef_run).to set_service_to_start_on_boot "radicale"
  end
end
