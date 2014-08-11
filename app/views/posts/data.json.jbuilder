@start_year = (@first_year / @precision) * @precision
@end_year = (@last_year / @precision) * @precision
@n_blocks = (@end_year - @start_year) / @precision

json.startYear @start_year
json.endYear @end_year
json.precision @precision
json.nBlocks @n_blocks

json.blocks do
    json.array! (0...@n_blocks).to_a do |index|
      posts = @posts.select do |post| 
        post.year >= @start_year + index*@precision && post.year < @start_year + index*@precision + @precision
      end
      json.index index
      json.year @start_year + index*@precision
      json.count posts.count

      json.posts do
        json.array! posts.take(5) do |post|
          json.id post.id
          json.title post.post_title
          json.date post.post_date
        end
      end
    end
end