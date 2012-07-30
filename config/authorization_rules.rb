authorization do
  role :guest do
    has_permission_on [:families], :to => :read
    has_permission_on :devise_registrations, :to => :manage
    has_permission_on :devise_sessions, :to => :manage
  end

  role :operator do
    has_permission_on [:families,
                       :fathers,
                       :mothers,
                       :children,
                       :trusties,
                       :pages,
                       :users_families,
                       :statistics,
                       :family_helps,
                       :visits
                      ], to: [:create, :read, :additional]
    has_permission_on :devise_sessions, to: :manage
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
                        :admin_study_categories,
                        :admin_settings,
                        :admin_funds,
                        :admin_news
                      ], :to => :superman
  end

end

privileges do
  privilege :superman, :includes => [:manage, :delete_multiple, :read_multiple, :additional]
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :additional, includes: [:home, :about, :search]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
