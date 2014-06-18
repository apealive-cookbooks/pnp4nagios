# Required for proper recipe testing by platform
%w{rhel}.each do |platform|
  describe "The pnp4nagios::_add_repositories_#{platform} recipe" do
    before (:all) {
      # Create our object
      @chef_run = ChefSpec::ChefRunner.new
      @chef_run.node.automatic_attrs['hostname'] = 'localhost'
      @chef_run.node.automatic_attrs['platform'] = platform
      @chef_run.node.automatic_attrs['platform_family'] = platform
      @chef_run.node.automatic_attrs['lsb'] = { 'codename' => 'squeeze' }
      @chef_run.converge "pnp4nagios::_add_repositories_#{platform}"
      @chef_run
    }
    %w(yum::yum yum-epel).each do |rcp|
      it "should include recipe #{rcp}" do
        @chef_run.should include_recipe rcp
      end
    end
  end
end
