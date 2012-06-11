authorization do
  role :guest do
    has_permission_on [:families], :to => :read
    has_permission_on :devise_registrations, :to => :manage
    has_permission_on :devise_sessions, :to => :manage
  end

  role :operator do
    has_permission_on [:admin_groups], to: :manage
  end

  role :volunteer do
    has_permission_on [:families, :family_helps], :to => :manage
  end

  role :admin do
    has_permission_on [ :devise_sessions,
                        :devise_registrations,
                        :families,
                        :fathers,
                        :mothers,
                        :children,
                        :trusties,
                        :visits,
                        :pages,
                        :statistics,
                        :users_families,
                        :family_helps,
                        :admin_users,
                        :admin_roles,
                        :admin_groups,
                        :admin_cities,
                        :admin_group_options,
                        :admin_help_types,
                        :admin_necessities,
                        :admin_study_categories
                      ], :to => :superman
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :superman, :includes => [:create, :read, :update, :delete, :delete_multiple, :home, :about, :search]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
