# Encoding: utf-8
# used by ChefSpec for LWRPs

if defined?(ChefSpec)

  def create_kibana_install(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_install, :create, name)
  end

  def remove_kibana_install(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_install, :remove, name)
  end

  def create_kibana_web(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_web, :create, name)
  end

  def remove_kibana_web(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_web, :remove, name)
  end

  def create_kibana_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_user, :create, name)
  end

  def remove_kibana_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_user, :remove, name)
  end

end
