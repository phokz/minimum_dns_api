class Domain < ApplicationRecord
  has_many :records, dependent: :delete_all
  self.inheritance_column = nil

  after_create :create_soa_record

  def create_soa_record
    Record.create!(domain: self, name: name, type: 'SOA', ttl: 300, content: soa_content)
  end

  def master_ns
    'dns1.domain.tld'
  end

  def hostmaster
    'hostmaster@domain.tld'
  end

  def initial_version
    Time.now.strftime('%Y%m%d')+'00'
  end

  def soa_timers
     '3600 900 1814400 7200'
  end

  def soa_content
    [master_ns, hostmaster, initial_version, soa_timers].join(' ')
  end
end
