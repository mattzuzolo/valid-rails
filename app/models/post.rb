require 'pry'
class Post < ActiveRecord::Base

    CATEGORY_OPTIONS = ["Fiction", "Non-Fiction"]
    CLICKBAIT_BLACKLIST = ["Won't", "Believe", "Secret", "Top", "Guess", "True", "Facts"]

    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: { in: CATEGORY_OPTIONS }
    validate :is_valid?

    def is_valid?
      if self.title != nil && ( !self.title.include?("Top") && (!self.title =~ (/\d/)) == nil) && check_blacklist(self.title)
          true
      else
        false
      end
    end

    def check_blacklist(passed_phrase)
      passed_array = passed_phrase.split(" ")
      if (CLICKBAIT_BLACKLIST & passed_array).any?

        return false
      else

        return true
      end

    end
end

####more text to save
#
# CLICKBAIT_BLACKLIST.in do |bad_word|
#   #binding.pry
#    !passed_phrase.include? (bad_word)
#   end
