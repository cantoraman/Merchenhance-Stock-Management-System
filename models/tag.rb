require_relative('../db/sql_runner')

class Tag

  attr_reader :id, :title

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
  end

  def save()
    sql = "INSERT INTO tags (title) VALUES ($1)
    RETURNING id"
    values = [@title]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run( sql )
    return results.map { |tag| Tag.new( tag ) }
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end

end
