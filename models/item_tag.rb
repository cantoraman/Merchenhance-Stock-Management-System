require_relative( '../db/sql_runner' )

class ItemTag

  attr_reader :id, :tag_id, :item_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @tag_id = options['tag_id'].to_i
    @item_id = options['item_id'].to_i
  end

  def save()
    sql = "INSERT INTO item_tags
    (
      tag_id,
      item_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@tag_id, @item_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM item_tags"
    results = SqlRunner.run( sql )
    return results.map { |item_tag| ItemTag.new( item_tag ) }
  end

  def tag()
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    results = SqlRunner.run( sql, values )
    return Tag.new( results.first )
  end

  def item()
    sql = "SELECT * FROM items
    WHERE id = $1"
    values = [@item_id]
    results = SqlRunner.run( sql, values )
    return Item.new( results.first )
  end

  def self.delete_all()
    sql = "DELETE FROM items"
    SqlRunner.run( sql )
  end



end
