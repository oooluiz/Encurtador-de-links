require 'extralite'
require 'securerandom'
#puts 'ja existe um link igual a esse' if db.query_single("select count(*) from links where original='https://x.com'")[:"count(*)"] > 1
class Db
  @db = Extralite::Database.new('db/db.db')
  def self.short url
    code = SecureRandom.alphanumeric 6
    self.short(url) if @db.query_single_splat("select count(*) from links where shortened='#{code}'").to_i > 1
    @db.execute('insert into links values (?,?)',url,code)
    code
  end

  def self.unshort code
    @db.query_single_splat("select original from links where shortened='#{code}'")
  end

end
