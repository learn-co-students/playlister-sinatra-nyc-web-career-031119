module Slug
  module InstanceMethods
    def slug
      self.name.split.join('-').downcase
    end
  end
  module ClassMethods
    def find_by_slug(slug)
      # unslug = slug.split('-').map do |word|
      #   word.capitalize
      # end.join(' ')
      # self.find_by(name: unslug)
      self.all.find{ |song| song.slug == slug}
    end
  end
end
