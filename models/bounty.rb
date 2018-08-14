require('PG')

class Bounty
  attr_accessor :name, :species, :bounty_value, :danger_level
  attr_reader :id

  def initialize(details)
    @id = details['id'].to_i if details ['id']
    @name = details['name']
    @species = details['species']
    @bounty_value = details['bounty_value'].to_i
    @danger_level = details['danger_level']
  end

  def save()
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "INSERT INTO bounties
    (name, species, bounty_value, danger_level)
    VALUES
    ($1, $2, $3, $4) RETURNING *"
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "UPDATE bounties
    SET
    (name, species, bounty_value, danger_level) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @species, @bounty_value, @danger_level, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM bounties
    WHERE name = $1"
    values = [name]
    db.prepare("find", sql)
    bounty = db.exec_prepared("find", values)
    db.close()
    return Bounty.new(bounty[0])
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM bounties
    WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    bounty = db.exec_prepared("find", values)
    db.close()
    return Bounty.new(bounty[0])
  end


end
