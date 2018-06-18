#
# A simple key/value pair for storing sundry application-level data.
# Roughly analogous to the old .ini files of yore
#
class ApplicationDatum < ApplicationRecord
  validates_uniqueness_of :key

  def self.get(key)
    ApplicationDatum.find_by(key: key)&.value
  end

  # perform an "upsert"
  def self.set(key, value)
    datum = ApplicationDatum.find_or_create_by(key: key)
    datum.update_attributes(value: value)
  end
end
