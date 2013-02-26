class P2p::ItemSpec < ActiveRecord::Base

  belongs_to :spec ,:class_name => 'P2p::Spec'
  belongs_to :item ,:class_name => 'P2p::Item'

  attr_accessible :value   

  before_destroy do
	#puts self.inspect + "bafter delete"
	self.item.itemhistories.create(:approved => false , :columnname => self.spec.name(self.spec.id) , :newvalue => "" ,:oldvalue =>  self.value ,:created_at => P2p::item_updated_at )
  end

  after_destroy do 
  	#puts self.inspect + "after delete"
  	#self.item.itemhistory.create(:approved => false , :columnname => self.spec.name(self.spec.id) , :newvalue => "" ,:oldvalue =>  self.value ,:created_at => P2p::item_updated_at )
  end

  after_save do
  	
  	#self.item.itemhistories.create(:approved => false , :columnname => self.spec.name + "( #{self.spec.id})" , :newvalue => self.value ,:oldvalue =>  "" ,:created_at => P2p::item_updated_at )
  	
  end

  after_update do
  	self.item.itemhistories.create(:approved => false , :columnname => self.spec.name(self.spec.id) , :newvalue => self.value ,:oldvalue =>  "" ,:created_at => P2p::item_updated_at )
  end

end
	
