require 'spec_helper'
describe 'nfs::client::redhat' do
  let(:facts) { {:osmajor => 6 } }
  it "redhat osmajor 6" do
    should include_class('nfs::client::redhat::install')
    should include_class('nfs::client::redhat::configure')
    should include_class('nfs::client::redhat::service')

    should contain_service('nfslock').with(
      'ensure' => 'running'
    )
    should contain_service('netfs').with(
      'enable' => 'true'
    )
    should contain_package('nfs-utils')
    should include_class('nfs::client::redhat')
    should contain_package('rpcbind')
    should contain_service('rpcbind').with(
      'ensure' => 'running'
    )
  end

  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_augeas('/etc/idmapd.conf') 
    end
  end

  context "osmajor => 20" do
    it "redhat osmajor 20" do
      should include_class('nfs::client::redhat::install')
      should include_class('nfs::client::redhat::configure')
      should include_class('nfs::client::redhat::service')

      should contain_service('nfslock').with(
                                             'ensure' => 'running'
                                             )
      should contain_service('netfs').with(
                                           'enable' => 'true'
                                           )
      should contain_package('nfs-utils')
      should include_class('nfs::client::redhat')
      should contain_package('rpcbind')
      should contain_service('rpcbind').with(
                                             'ensure' => 'running'
                                             )
    end

    context ":nfs_v4 => true" do
      let(:params) {{ :nfs_v4 => true }}
      it do
        should contain_augeas('/etc/idmapd.conf') 
      end
    end
  end
  
  context "osmajor => 5" do
    let(:facts) { {:osmajor => 5 } }
    it do
      should include_class('nfs::client::redhat')
      should contain_package('portmap')

      should contain_service('portmap').with(
        'ensure' => 'running'
      )
    end
  end
end
# test for fedora 20
describe 'nfs::client::redhat' do
  let(:facts) { {:osmajor => 20 } }
  it do
    should include_class('nfs::client::redhat::install')
    should include_class('nfs::client::redhat::configure')
    should include_class('nfs::client::redhat::service')

    should contain_service('nfs-lock').with(
      'ensure' => 'running'
    )
    should contain_service('netfs').with(
      'enable' => 'true'
    )
    should contain_package('nfs-utils')
    should include_class('nfs::client::redhat')
    should contain_package('rpcbind')
    should contain_service('rpcbind').with(
      'ensure' => 'running'
    )
  end

  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_augeas('/etc/idmapd.conf') 
    end
  end

  context "osmajor => 5" do
    let(:facts) { {:osmajor => 5 } }
    it do
      should include_class('nfs::client::redhat')
      should contain_package('portmap')

      should contain_service('portmap').with(
        'ensure' => 'running'
      )
    end
  end
end
