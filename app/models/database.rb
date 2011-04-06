class Database < ActiveRecord::Base
  attr_accessible :name, :database_type, :machine_ids
  has_many :machines
  validates_presence_of :name
  validates_inclusion_of :database_type, :in => %w(postgres oracle)

  def postgres_report
    machines.inject([]) do |memo,machine|
      memo.concat(machine.postgres_report)
    end.sort_by do |report|
      [report["port"].to_i, report["pg_cluster"]]
    end
  end

  def oracle_report
    machines.inject([]) do |memo,machine|
      memo.concat(machine.oracle_report)
    end.sort_by do |report|
      report["ora_instance"]
    end
  end
end