REVERSE_TZ_HASH = {}
ActiveSupport::TimeZone.all.each do |tz|
  REVERSE_TZ_HASH[tz.tzinfo.name] = tz.name
end
REVERSE_TZ_HASH.freeze
