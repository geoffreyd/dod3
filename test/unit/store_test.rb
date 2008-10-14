require 'test_helper'

class StoreTest < ActiveSupport::TestCase


  def test_maximum_size_of_data_field
    test = "".ljust(Store::MAX_ITEM_SIZE,"0123456789abc")
    rec = Store.create(:data=>test)
    rec.reload
    assert_equal(test, rec.data)
  end

  def test_revision
    assert_equal Store.find_all_by_rev(0), Store.revision
    assert_equal Store.find_all_by_rev(0), Store.revision(nil)
    assert_equal Store.find_all_by_rev(1), Store.revision(1)
    assert_equal Store.find(:all, :conditions=>"rev != 0"), Store.revision(:history)
    assert_equal Store.all, Store.revision(:all)
  end

  def test_include_fields
    field_1 = fields(:field_1)
    field_2 = fields(:field_2)
    assert_equal Store.all, Store.include_fields(nil)
    assert_equal Store.find_all_by_field_id(field_1.id), Store.include_fields(field_1.name.to_sym)
    assert_equal Store.find_all_by_field_id([field_1.id, field_2.id]), Store.include_fields([field_1.name.to_sym, field_2.name.to_sym])
    assert_equal Store.find_all_by_field_id([field_1.id, field_2.id]), Store.include_fields([field_1.name.to_sym, field_2.name.to_sym])
    assert_equal Store.find_all_by_field_id([field_1.id, field_2.id]), Store.include_fields([field_1.name.to_sym, field_2.name.to_sym])
  end

  # TODO complete this
  def test_search_for

    assert_equal Store.find_all_by_data("barneyb"), Store.search_for("barneyb", nil)
    assert_equal Store.find_all_by_data("barneyb"), Store.search_for("barneyb", "=")
    assert_equal Store.find(:all, :conditions=>"data != 'barneyb'"), Store.search_for("barneyb", "!=")

  end

  def test_filter_on_ids
    doc_1 = docs(:doc_1)
    doc_2 = docs(:doc_2)
    both = [doc_1, doc_2]
    
    assert_equal(Store.find_all_by_doc_id(doc_1), Store.filter_on_ids(doc_1))
    assert_equal(Store.find_all_by_doc_id(doc_2), Store.filter_on_ids(doc_2))
    assert_equal(Store.find_all_by_doc_id(both), Store.filter_on_ids(both))
    assert_equal Store.all, Store.filter_on_ids
    assert_equal Store.all, Store.filter_on_ids(nil)
  end

end
