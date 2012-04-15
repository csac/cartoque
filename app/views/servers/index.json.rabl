collection @servers => :servers

attributes :id, :name
node(:hypervisor_name) { |server| server.hypervisor.try(:name) }

# hardware details
attributes :memory_GB
attributes :processor_system_count,
           :processor_reference,
           :processor_frequency_GHz
