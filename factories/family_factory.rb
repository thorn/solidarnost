Factory.define :group_option, :aliases => [:home, :resource, :source] do |gp|
  gp.name "OPT"
  gp.coeff 10
end

Factory.define :family do |family|
  family.title "name"
  family.home_id Factory(:group_option)
  family.source_id Factory(:group_option)
  family.resource_id Factory(:group_option)
end
