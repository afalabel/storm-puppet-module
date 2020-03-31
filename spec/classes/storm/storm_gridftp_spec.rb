require 'spec_helper'

describe 'storm::gridftp', :type => :class do

  on_supported_os.each do |os, facts|

    context "on #{os}" do

      let(:facts) do
        facts
      end
    
      context 'Use custom gridftp params' do

        let(:params) do 
          {
            'port'                => 2911,
            'port_range'          => '30000,40000',
            'connections_max'     => 4000,
            'redirect_lcmaps_log' => true,
            'llgt_log_file'       => '/var/log/storm/lcmaps.log',
          }
        end

        it "check gridftp conf file content" do
          title='/etc/gridftp.conf'
          is_expected.to contain_file(title).with( 
            :ensure => 'present',
          )
          is_expected.to contain_file(title).with( :content => /port 2911/ )
          is_expected.to contain_file(title).with( :content => /port_range 30000,40000/ )
          is_expected.to contain_file(title).with( :content => /connections_max 4000/ )
        end

        it "check gridftp sysconf file content" do
          title='/etc/sysconfig/storm-globus-gridftp'
          is_expected.to contain_file(title).with( 
            :ensure => 'present',
          )
          is_expected.to contain_file(title).with( :content => /LLGT_LOG_FILE=\/var\/log\/storm\/lcmaps.log/ )
        end
      end

      context 'Use default gridftp params' do

        it "check gridftp conf file content" do
          title='/etc/gridftp.conf'
          is_expected.to contain_file(title).with( 
            :ensure => 'present',
          )
          is_expected.to contain_file(title).with( :content => /port 2811/ )
          is_expected.to contain_file(title).with( :content => /port_range 20000,25000/ )
          is_expected.to contain_file(title).with( :content => /connections_max 2000/ )
        end

        it "check gridftp sysconf file content" do
          title='/etc/sysconfig/storm-globus-gridftp'
          is_expected.to contain_file(title).with( 
            :ensure => 'present',
          )
          is_expected.to contain_file(title).with( :content => /#LLGT_LOG_FILE=\/var\/log\/storm\/storm-gridftp-lcmaps.log/ )
        end
      end
    end
  end
end