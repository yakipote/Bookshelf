# encoding: utf-8
 
require 'rubygems'
require 'amazon/ecs'
def amazon(isbn) 
# 初期設定
Amazon::Ecs.configure do |options|
  options[:associate_tag] = "pumissyu-22"# アソシエイトID(なんとか-22ってやつ)
  options[:AWS_access_key_id] = "AKIAJUDAHJBFXMBJO3WQ"
  options[:AWS_secret_key] = "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"         
  options[:country] = 'jp' # amazon.co.jpしか検索しないのでここで設定
end
 
# データ取得
# response = Amazon::Ecs.item_lookup(ARGV[0], { response_group: 'Small' })
response = Amazon::Ecs.item_lookup(isbn, { response_group: 'Large' })
# response = Amazon::Ecs.item_lookup(ARGV[0], { response_group: 'Large' })
 title=""
 image=""
# データ表示
if response.items.length > 0
  response.items.each do |item|
#    p item
    #puts("ASIN:         #{item.get('ASIN')}")
    #puts("Author:       #{item.get('ItemAttributes/Author')}")
    #puts("Title:        #{item.get('ItemAttributes/Title')}")
    image =item.get('LargeImage/URL')
    title = item.get('ItemAttributes/Title')
   # puts("Manufacturer: #{item.get('ItemAttributes/Manufacturer')}")
   # puts("Group:        #{item.get('ItemAttributes/ProductGroup')}")
    #puts("URL:          #{item.get('DetailPageURL')}")
    #puts("SalesRank:    #{item.get('SalesRank')}")
   # puts("Amount:       #{item.get('ItemAttributes/ListPrice/Amount')}")
    #puts("LowestNewPrice: #{item.get('OfferSummary/LowestNewPrice/Amount')}")
    #puts("Image: #{item.get('LargeImage/URL')}")
  end
else
   return {"title" => "not found", "image" => "http://livedoor.blogimg.jp/kankore200/imgs/0/b/0b9d6d63.jpg"}
end
return {"title" => title, "image" => image}
end


