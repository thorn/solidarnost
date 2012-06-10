authorization do
  role :guest do
    has_permission_on [:families], :to => :read
    has_permission_on :devise_registrations, :to => :manage
    has_permission_on :devise_sessions, :to => :manage
  end

  role :moderator do

  end

  role :volunteer do
    has_permission_on [:families, :family_helps], :to => :manage
  end

  role :admin do
    has_permission_on [:devise_sessions, :devise_registrations,:users,:visits,:families,:fathers,:mothers,:trusties,:roles,:children, :family_helps], :to => :superman
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :superman, :includes => [:create, :read, :update, :delete, :delete_multiple]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
