authorization do
  role :guest do
    has_permission_on [:families], :to => :read
    # has_permission_on :devise_registrations, :to => :manage
    has_permission_on :devise_sessions, :to => :manage
  end

  role :user do
    includes :guest
    has_permission_on [:families,
                       :fathers,
                       :mothers,
                       :children,
                       :trusties,
                       :family_members,
                       :pages,
                       :users_families,
                       :statistics,
                       :family_helps,
                       :visits
                      ], to: [:read, :additional]
  end

  role :operator do
    has_permission_on [:families,
                       :fathers,
                       :mothers,
                       :children,
                       :trusties,
                       :family_members,
                       :pages,
                       :users_families,
                       :statistics,
                       :family_helps,
                       :visits
                      ], to: [:create, :read, :additional]
    has_permission_on :families, to: [:edit, :update] do
      if_attribute :status => is {0}
    end
    has_permission_on :devise_sessions, to: :manage
    has_permission_on :admin_cities, to: :read
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
                        :family_members,
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
                        :admin_news,
                        :admin_areas
                      ], :to => :superman
  end

end

privileges do
  privilege :superman, :includes => [:persist, :manage, :delete_multiple, :read_multiple, :additional, :mark_as_read]
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :additional, includes: [:home, :about, :search, :help_search, :get_new]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
