class Record < ApplicationRecord
  belongs_to :domain
  self.inheritance_column = nil

  after_save :bump_soa_version

  def bump_soa_version
    return if type == 'SOA'
    soa_record = domain.records.find_by(type: 'SOA')
    parts = soa_record.content.split(' ')
    date = parts[2][0..7]
    if Date.parse(date) < Date.today
       parts[2] = Time.now.localtime.strftime('%Y%m%d00')
    else
       parts[2] = (parts[2].to_i + 1).to_s
    end
    soa_record.update(content: parts.join(' '))
  end
end
