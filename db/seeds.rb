require "open-uri"

Card.delete_all
Block.delete_all
User.delete_all

user = User.create(
  email: "example@test.com",
  password: "123456",
  password_confirmation: "123456"
)

block = user.blocks.create(title: "Test deck")

page_url = "http://www.learnathome.ru/blog/100-beautiful-words"
doc = Nokogiri::HTML(open(page_url))

doc.css("table tbody tr").each do |row|
  original = row.css("td")[1].css("p")[0].text
  translated = row.css("td")[0].css("p")[0].text
  block.cards.create(
    original_text: original,
    translated_text: translated,
    review_date: DateTime.current,
    user_id: user.id
  )
end