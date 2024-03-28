class TagsController < ApplicationController
    def autocomplete_word
      @tags = Tag.where("name LIKE ?", "%#{params[:keyword]}%")
      respond_to do |format|
        format.js
      end
    end
  end
  class TagsController < ApplicationController
    def autocomplete_word
      @tags = Tag.where("name LIKE ?", "%#{params[:keyword]}%")
      respond_to do |format|
        format.js
      end
    end
  end
    