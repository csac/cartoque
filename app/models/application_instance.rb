class ApplicationInstance
  include Mongoid::Document
  include Mongoid::Denormalize
  include Mongoid::Timestamps

  #standard fields
  field :name, type: String
  field :authentication_method, type: String
  #associations
  embeds_many :application_urls
  belongs_to :application
  has_and_belongs_to_many :servers
  #denormalized fields
  denormalize :name, from: :application

  accepts_nested_attributes_for :application_urls, reject_if: lambda{|a| a[:url].blank? },
                                                   allow_destroy: true

  #default_scope includes(:application).order("applications.name, application_instances.name")

  AVAILABLE_AUTHENTICATION_METHODS = %w(none cerbere cerbere-cas cerbere-bouchon ldap-minequip internal other)

  validates_presence_of :name, :authentication_method, :application
  validates_inclusion_of :authentication_method, in: AVAILABLE_AUTHENTICATION_METHODS

  def full_name
    "#{application_name} (#{name})"
  end
  alias :to_s :full_name
end
