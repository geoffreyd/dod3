class View < ActiveRecord::Base
  belongs_to :field

  def after_save # :nodoc:
    Doc.all.each do |doc|
      doc.build_it doc.retrieve(doc.id)
    end
  end
  

end
